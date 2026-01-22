# StencilTest

Experimenting with lowering IR (intermediate representation) from the xDSL stencil dialect, to MLIR (Multi-Level Intermediate Representation) dialects, to LLVM IR for CPUs and GPUs.

This is purely a prototype to be used as part of a larger project.

## Requirements
### System
- Linux (tested on Ubuntu)
- Python ≥ 3.9
- MLIR built from source with Python bindings enabled 
    - Learn how to [enable python bindings](https://mlir.llvm.org/docs/Bindings/Python/) and [build MLIR](https://mlir.llvm.org/getting_started/)

### Optional (GPU)
- NVIDIA GPU
- CUDA Toolkit installed and on PATH
- LLVM built with `NVPTX` target enabled

## Building the Python Environment

It is recommended to use `uv` to build the virtual env for this project.

```bash
# Create the virtual environment
uv venv

# Activate the virtual environment
source .venv/bin/activate

# Install core dependencies
uv sync

# (Optional) If you want GPU support with PyCUDA
uv sync --extras gpu
```

## MLIR Python Bindings Setup (Required)

Important: MLIR Python bindings are not installed via pip.

They are built as part of the LLVM/MLIR build and must be made discoverable via `PYTHONPATH`.

### 1. Build LLVM/MLIR with Python bindings enabled

When configuring LLVM:
```bash
cmake -G Ninja \
  ...
  -DMLIR_ENABLE_BINDINGS_PYTHON=ON \
  -DPython3_EXECUTABLE=$(which python) \
  ...
```

Then build:
```bash
cmake --build . --target check-mlir -j $(nproc)
```

### 2. Export MLIR Python bindings

After building, export:
```bash
export PYTHONPATH=$path-to-llvm-project/build/tools/mlir/python_packages/mlir_core
```
This directory contains the mlir namespace package used by the Python bindings.

You can verify the setup:
```bash
python - <<EOF
from mlir import ir, passmanager
print(ir, passmanager)
EOF
```

## Running the Project

The main driver script lowers stencil IR through xDSL and MLIR.

| Argument            | Description                                                                                        | Default                        |
| ------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------ |
| `--device`          | The device type to compile for. Choices are `cpu` or `gpu`.                                        | `cpu`                          |
| `--input`           | Path to the stencil input file.                                                                    | `sample_ir/sample_stencil.txt` |
| `--output`          | Optional path to write the fully lowered IR to a file instead of printing it to the console.       | None                           |
| `--save-after-pass` | If set, saves the IR after each pass is applied in a directory (`lowered_cpu/` or `lowered_gpu/`). | False                          |


### CPU Lowering

```bash
uv run main.py --device cpu
```
### GPU Lowering (requires CUDA + NVPTX-enabled LLVM)
```bash
uv run main.py --device gpu
```

### Example: Save IR after every pass to inspect the lowering
```bash
uv run main.py --device gpu --save-after-pass
```

### Example: Use a different input file and output final IR to a file
```bash
uv run main.py --input my_stencil.txt --output lowered_final.mlir
```