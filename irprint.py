import xdsl
from xdsl.dialects.stencil import Stencil, FieldType, ApplyOp
from xdsl.builder import Builder, InsertPoint
from xdsl.dialects import builtin, func, arith, scf, stencil
from xdsl.context import Context  
from xdsl.parser import Parser, ModuleOp
from xdsl.transforms.experimental.convert_stencil_to_ll_mlir import ConvertStencilToLLMLIRPass

import argparse
import subprocess
from io import StringIO
from xdsl.printer import Printer
import os

ctx = Context()
ctx.load_dialect(builtin.Builtin)
ctx.load_dialect(func.Func)
ctx.load_dialect(arith.Arith)
ctx.load_dialect(scf.Scf)
ctx.load_dialect(stencil.Stencil)

file_path = "sample_ir/sample_stencil.txt"


cpu_passes = [
    # -------- Lower to OpenMP --------
    "--convert-bufferization-to-memref",
    "--convert-scf-to-openmp",
    "--canonicalize",
    "--cse",

    # -------- OpenMP to LLVM --------
    "--convert-openmp-to-llvm",
    "--canonicalize",
    # "--func.func=lower-affine",
    "--lower-affine",

    "--expand-strided-metadata",
    "--finalize-memref-to-llvm",

    # -------- Control flow & final lowering --------
    "--convert-scf-to-cf",
    "--convert-cf-to-llvm",
    "--lower-affine",
    "--convert-arith-to-llvm",
    "--convert-math-to-llvm",
    "--convert-func-to-llvm",
    "--reconcile-unrealized-casts"
]


gpu_passes = [
    # -------- Bufferization --------
    "--convert-bufferization-to-memref",
    "--canonicalize",
    "--cse",

    # -------- Parallel loops to GPU --------
    "--gpu-map-parallel-loops",

    "--convert-parallel-loops-to-gpu",
    "--gpu-kernel-outlining",

    # "--gpu-host-register", -- can not find equivalent mlir-opt flag for this

    # # -------- GPU dialect to NVVM dialect --------
    "--convert-gpu-to-nvvm",
    "--nvvm-attach-target=chip=sm_90,triple=nvptx64-nvidia-cuda",

    # # -------- Control flow / scalar lowering --------
    "--convert-scf-to-cf",
    "--lower-affine",
    "--convert-arith-to-llvm",
    "--convert-index-to-llvm=index-bitwidth=64",
    "--convert-ub-to-llvm",
    "--expand-strided-metadata",

    # # -------- Device NVVM instrinsics to LLVM --------
    "--convert-nvvm-to-llvm",
    "--convert-to-llvm",
    "--canonicalize",
    "--cse",

    # # -------- Serialize GPU module to binary (PTX/ELF blob) --------
    "--gpu-module-to-binary",

    # # -------- GPU host/device to LLVM --------
    "--gpu-to-llvm",
    "--finalize-memref-to-llvm",
    "--convert-func-to-llvm",
    "--convert-cf-to-llvm",
    "--reconcile-unrealized-casts",
    "--canonicalize",
    "--cse"
]

def dump_ir(ir_text: str, stage: int, pass_name: str, prefix="ir_dump"):
    filename = f"{prefix}/{stage:02d}_{pass_name}.mlir"
    with open(filename, "w") as f:
        f.write(ir_text)
    print(f"[IR dump] {filename}")




def main():

  print(xdsl.__file__)

  device_type = "gpu"

  os.makedirs("ir_dump", exist_ok=True)


  parser = argparse.ArgumentParser()
  parser.add_argument("--device", help="the device type you want to compile for")
  args = parser.parse_args()


  if args.device:
    device_type = args.device

  # Initialise stencil dialect sample

  with open(file_path, 'r') as file:
    sample_stencil = file.read()

  module = Parser(ctx, sample_stencil).parse_module()

  # Convert IR from xDSL stencil to LLVM dialects 
  lowering_pass = ConvertStencilToLLMLIRPass()


  lowering_pass.apply(ctx, module)

  # print(module)


  # Convert the IR in the module to a string object
  buf = StringIO()
  Printer(stream=buf).print_op(module)
  mlir_text = buf.getvalue()

  print(mlir_text)

  

  # Lower to target device with MLIR
  lowered_mlir = ""
  if device_type == "cpu":
    current_ir = mlir_text
    dump_ir(current_ir, 0, "after_xdsl_lowering")

    for i, p in enumerate(cpu_passes, start=1):
        result = subprocess.run(
            ["mlir-opt", p],
            input=current_ir,
            text=True,
            capture_output=True,
        )

        if result.returncode != 0:
            print(f"Pass failed: {p}")
            print(result.stderr)
            exit(1)

        current_ir = result.stdout
        pass_name = p.replace("--", "").replace("=", "_")
        dump_ir(current_ir, i, pass_name)
  elif device_type == "gpu":
    current_ir = mlir_text
    dump_ir(current_ir, 0, "after_xdsl_lowering")

    for i, p in enumerate(gpu_passes, start=1):
        result = subprocess.run(
            ["mlir-opt", p],
            input=current_ir,
            text=True,
            capture_output=True,
        )

        if result.returncode != 0:
            print(f"Pass failed: {p}")
            print(result.stderr)
            exit(1)

        current_ir = result.stdout
        pass_name = p.replace("--", "").replace("=", "_")
        dump_ir(current_ir, i, pass_name)

    lowered_mlir = current_ir


    print("=== STDOUT ===")
    print(result.stdout)

    print("=== STDERR ===")
    print(result.stderr)

    print("Return code:", result.returncode)

    lowered_mlir = result.stdout

  elif device_type == "gpu":
    result = subprocess.run(
        ["mlir-opt", *gpu_passes],
        input=mlir_text,
        text=True,
        capture_output=True,
        # check=True,
    )

    print("=== STDOUT ===")
    print(result.stdout)

    print("=== STDERR ===")
    print(result.stderr)

    print("Return code:", result.returncode)

    lowered_mlir = result.stdout
  else:
    print(f"Unrecognised device type {device_type}")
    exit(1)

  print("Lowering finished.")
  print("--------------------------------------")
  print(lowered_mlir)


if __name__ == "__main__":
  main()

