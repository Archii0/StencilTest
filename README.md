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
uv venv
source .venv/bin/activate

uv sync
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

### CPU Lowering

```bash
uv run main.py --device cpu
```
### GPU Lowering (requires CUDA + NVPTX-enabled LLVM)
```bash
uv run main.py --device gpu
```

