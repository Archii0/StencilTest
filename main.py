import argparse
from lowering import init_xdsl_context, xdsl_to_mlir, run_mlir_passes, get_pass_pipeline

from xdsl.transforms.experimental.convert_stencil_to_ll_mlir import (
    ConvertStencilToLLMLIRPass,
)

from xdsl.parser import Parser

FILE_PATH = "sample_ir/sample_stencil.txt"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--device", help="the device type you want to compile for")
    parser.add_argument(
        "--input",
        default=FILE_PATH,
        help=f"Path to stencil input file (default: {FILE_PATH})",
    )
    parser.add_argument(
        "--output",
        default=None,
        help="Optional path to write lowered IR instead of printing to console",
    )
    parser.add_argument(
        "--save-after-pass",
        action="store_true",
        help="Save IR to separate files after each pass is applied",
    )

    args = parser.parse_args()

    device_type = args.device if args.device else "cpu"
    input_file = args.input

    print(f"\n{'='*60}")
    print("Starting lowering pipeline")
    print(f"Target device: {device_type.upper()}")
    print(f"Input file: {input_file}")
    print(f"{'='*60}\n")

    xdsl_ctx = init_xdsl_context()

    # Initialise stencil dialect sample
    with open(input_file, "r") as file:
        stencil_text = file.read()

    xdsl_module = Parser(xdsl_ctx, stencil_text).parse_module()

    # Convert IR from xDSL stencil to LLVM dialects
    lowering_pass = ConvertStencilToLLMLIRPass()
    lowering_pass.apply(xdsl_ctx, xdsl_module)

    mlir_text = xdsl_to_mlir(xdsl_module)

    passes = get_pass_pipeline(device_type)
    lowered_ir = run_mlir_passes(
        mlir_text,
        passes,
        save_after_pass=args.save_after_pass,
        base_dir="ir_test",
        device_type=device_type,
    )

    print(f"\n{'-'*60}")
    print(f"Lowering finished for device: {device_type.upper()}")
    print(f"{'-'*60}\n")

    if args.output:
        with open(args.output, "w") as f:
            f.write(lowered_ir)
        print(f"Lowered IR written to: {args.output}\n")
    else:
        print("=== Lowered IR Start ===")
        print(lowered_ir)
        print("=== Lowered IR End ===\n")


if __name__ == "__main__":
    main()
