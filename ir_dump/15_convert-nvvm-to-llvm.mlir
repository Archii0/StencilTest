module attributes {gpu.container_module} {
  func.func @laplace2d(%arg0: memref<66x66xf64>, %arg1: memref<66x66xf64>) {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(64 : index) : i64
    %3 = llvm.mlir.constant(-4.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(-1 : index) : i64
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    %6 = builtin.unrealized_conversion_cast %1 : i64 to index
    %7 = builtin.unrealized_conversion_cast %0 : i64 to index
    %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg1 : memref<66x66xf64> -> memref<f64>, index, index, index, index, index
    %reinterpret_cast = memref.reinterpret_cast %base_buffer to offset: [67], sizes: [64, 64], strides: [66, 1] : memref<f64> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    %8 = builtin.unrealized_conversion_cast %1 : i64 to index
    %9 = builtin.unrealized_conversion_cast %2 : i64 to index
    %10 = builtin.unrealized_conversion_cast %2 : i64 to index
    gpu.launch_func  @laplace2d_kernel::@laplace2d_kernel blocks in (%9, %10, %8) threads in (%8, %8, %8)  args(%6 : index, %7 : index, %5 : index, %arg0 : memref<66x66xf64>, %3 : f64, %reinterpret_cast : memref<64x64xf64, strided<[66, 1], offset: 67>>)
    return
  }
  gpu.module @laplace2d_kernel [#nvvm.target<chip = "sm_90,triple=nvptx64-nvidia-cuda">] {
    llvm.func @laplace2d_kernel(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: f64, %arg11: !llvm.ptr, %arg12: !llvm.ptr, %arg13: i64, %arg14: i64, %arg15: i64, %arg16: i64, %arg17: i64) attributes {gpu.kernel, gpu.known_block_size = array<i32: 1, 1, 1>, nvvm.kernel, nvvm.maxntid = array<i32: 1, 1, 1>} {
      %0 = llvm.mlir.constant(66 : index) : i64
      %1 = nvvm.read.ptx.sreg.ctaid.x : i32
      %2 = llvm.sext %1 : i32 to i64
      %3 = nvvm.read.ptx.sreg.ctaid.y : i32
      %4 = llvm.sext %3 : i32 to i64
      %5 = llvm.mul %2, %arg0 overflow<nsw> : i64
      %6 = llvm.add %5, %arg1 : i64
      %7 = llvm.mul %4, %arg0 overflow<nsw> : i64
      %8 = llvm.add %7, %arg1 : i64
      %9 = llvm.add %6, %arg2 : i64
      %10 = llvm.mul %9, %0 overflow<nsw, nuw> : i64
      %11 = llvm.add %10, %8 overflow<nsw, nuw> : i64
      %12 = llvm.getelementptr inbounds|nuw %arg4[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %13 = llvm.load %12 : !llvm.ptr -> f64
      %14 = llvm.add %6, %arg0 : i64
      %15 = llvm.mul %14, %0 overflow<nsw, nuw> : i64
      %16 = llvm.add %15, %8 overflow<nsw, nuw> : i64
      %17 = llvm.getelementptr inbounds|nuw %arg4[%16] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %18 = llvm.load %17 : !llvm.ptr -> f64
      %19 = llvm.add %8, %arg2 : i64
      %20 = llvm.mul %6, %0 overflow<nsw, nuw> : i64
      %21 = llvm.add %20, %19 overflow<nsw, nuw> : i64
      %22 = llvm.getelementptr inbounds|nuw %arg4[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %23 = llvm.load %22 : !llvm.ptr -> f64
      %24 = llvm.add %8, %arg0 : i64
      %25 = llvm.mul %6, %0 overflow<nsw, nuw> : i64
      %26 = llvm.add %25, %24 overflow<nsw, nuw> : i64
      %27 = llvm.getelementptr inbounds|nuw %arg4[%26] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %28 = llvm.load %27 : !llvm.ptr -> f64
      %29 = llvm.mul %6, %0 overflow<nsw, nuw> : i64
      %30 = llvm.add %29, %8 overflow<nsw, nuw> : i64
      %31 = llvm.getelementptr inbounds|nuw %arg4[%30] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %32 = llvm.load %31 : !llvm.ptr -> f64
      %33 = llvm.fadd %13, %18 : f64
      %34 = llvm.fadd %23, %28 : f64
      %35 = llvm.fadd %33, %34 : f64
      %36 = llvm.fmul %32, %arg10 : f64
      %37 = llvm.fadd %36, %35 : f64
      %38 = llvm.getelementptr %arg12[67] : (!llvm.ptr) -> !llvm.ptr, f64
      %39 = llvm.mul %6, %0 overflow<nsw, nuw> : i64
      %40 = llvm.add %39, %8 overflow<nsw, nuw> : i64
      %41 = llvm.getelementptr inbounds|nuw %38[%40] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      llvm.store %37, %41 : f64, !llvm.ptr
      llvm.return
    }
  }
}

