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

import pycuda.driver as cuda
import pycuda.autoinit

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



def main():

  num_devices = cuda.Device.count()
  print("Number of CUDA devices:", num_devices)

  dev = cuda.Device(0)
  major, minor = dev.compute_capability()
  
  sm_param = f"sm_{major}{minor}"

  print("----- GPU DETECTED -----")
  print(f"Device: {dev.name()}")
  print(f"  Compute Capability: {major}.{minor}")
  print(f"  SM version: {sm_param}")
  print("-----------------------")

  return

  print(xdsl.__file__)

  device_type = "cpu"

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
    result = subprocess.run(
        ["mlir-opt", *cpu_passes],
        input=mlir_text,
        text=True,
        capture_output=True,
    )

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
