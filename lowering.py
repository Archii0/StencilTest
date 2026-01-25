# lowering.py
from io import StringIO
from typing import List, Any
import re
import os
from xdsl.context import Context as XDSLContext
from xdsl.dialects import builtin, func, arith, scf, stencil
from xdsl.printer import Printer

from mlir import ir as mlir_ir
from mlir.passmanager import PassManager as MLIRPassManager

# CPU & GPU pass pipelines
CPU_PASSES = [
    "convert-bufferization-to-memref",
    "convert-scf-to-openmp",
    "canonicalize",
    "cse",
    "convert-openmp-to-llvm",
    "canonicalize",
    "lower-affine",
    "expand-strided-metadata",
    "finalize-memref-to-llvm",
    "convert-scf-to-cf",
    "convert-cf-to-llvm",
    "lower-affine",
    "convert-arith-to-llvm",
    "convert-math-to-llvm",
    "convert-func-to-llvm",
    "reconcile-unrealized-casts",
]

GPU_PASSES = [
    "convert-bufferization-to-memref",
    "canonicalize",
    "cse",
    "gpu-map-parallel-loops",
    "convert-parallel-loops-to-gpu",
    "gpu-kernel-outlining",
    "convert-gpu-to-nvvm",
    "nvvm-attach-target=chip=sm_90,triple=nvptx64-nvidia-cuda",
    "convert-scf-to-cf",
    "lower-affine",
    "convert-arith-to-llvm",
    "convert-index-to-llvm=index-bitwidth=64",
    "convert-ub-to-llvm",
    "expand-strided-metadata",
    "convert-nvvm-to-llvm",
    "convert-to-llvm",
    "canonicalize",
    "cse",
    "gpu-module-to-binary",
    "gpu-to-llvm",
    "finalize-memref-to-llvm",
    "convert-func-to-llvm",
    "convert-cf-to-llvm",
    "reconcile-unrealized-casts",
    "canonicalize",
    "cse",
]


def init_xdsl_context() -> XDSLContext:
    """Initialise an xDSL Context and load required dialects."""
    ctx = XDSLContext()
    for dialect in [builtin.Builtin, func.Func, arith.Arith, scf.Scf, stencil.Stencil]:
        ctx.load_dialect(dialect)
    return ctx


def xdsl_to_mlir(xdsl_module: Any) -> str:
    """Convert an xDSL module to MLIR textual representation."""
    buf = StringIO()
    Printer(stream=buf).print_op(xdsl_module)
    return buf.getvalue()


def sanitize_pass_name(pass_name: str) -> str:
    """Sanitize pass names to be safe filenames (remove / replace special chars)."""
    return re.sub(r"[^a-zA-Z0-9_-]", "_", pass_name)


def run_mlir_passes(
    mlir_text: str,
    passes: List[str],
    save_after_pass: bool = False,
    base_dir: str = "lowered_ir",
    device_type: str = "cpu",
) -> str:
    """Run a list of MLIR passes on MLIR text and return transformed text."""
    with mlir_ir.Context() as ctx:
        mlir_module = mlir_ir.Module.parse(mlir_text, context=ctx)
        op = mlir_module.operation

        pm = MLIRPassManager(context=ctx)

        if save_after_pass:
            # Debug mode - run each pass isolation for saving to file
            save_dir = f"{base_dir}_{device_type}"
            os.makedirs(save_dir, exist_ok=True)

            # Run each pass in isolation
            for idx, p in enumerate(passes, start=1):
                single_pass_pm = MLIRPassManager(context=ctx)
                single_pass_pm.add(p)
                single_pass_pm.run(op)

                file_name = f"{idx}_{sanitize_pass_name(p)}.mlir"
                path = os.path.join(save_dir, file_name)
                with open(path, "w") as f:
                    f.write(str(mlir_module))
                print(f"[Info] Saved IR after pass {idx} ({p}) -> {path}")

        else:
            # Production mode - add all passes and run once
            for p in passes:
                pm.add(p)
            pm.run(op)
        return str(mlir_module)


def get_nvvm_target() -> str:

    gpu_sm = os.environ.get("OPS_GPU_SM")

    if gpu_sm:
        print(f"Detected GPU SM version from env variable: {gpu_sm}")
    else:
        print("GPU SM env variable not set, attempting auto detection")
        try:
            import pycuda.driver as cuda
            import pycuda.autoinit  # noqa: F401, runs automatically on import

            dev = cuda.Device(0)
            major, minor = dev.compute_capability()
            gpu_sm = f"{major}{minor}"

            print(f"Automatically detected GPU SM version: {gpu_sm}")
        except ModuleNotFoundError:
            raise RuntimeError(
                "PyCUDA is not installed. Install it with `pip install pycuda`.\n"
                "Note: PyCUDA only works if you have an NVIDIA GPU and CUDA installed.\n"
                "If you do not have an NVIDIA GPU, run the script again with '--device cpu'."
            )
        except cuda.Error as e:
            raise RuntimeError(f"Failed to detect GPU compute capability: {e}")

    return f"chip=sm_{gpu_sm},triple=nvptx64-nvidia-cuda"


def get_pass_pipeline(device_type: str) -> List[str]:
    """Return the MLIR pass pipeline for the given device."""
    if device_type == "cpu":
        return CPU_PASSES
    elif device_type == "gpu":
        nvvm_target = get_nvvm_target()
        gpu_passes_with_target = [
            (
                p
                if not p.startswith("nvvm-attach-target")
                else f"nvvm-attach-target={nvvm_target}"
            )
            for p in GPU_PASSES
        ]
        return gpu_passes_with_target
    else:
        raise ValueError(f"Unrecognised device type: {device_type}")
