module {
  llvm.func @laplace2d(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64) {
    %0 = llvm.mlir.constant(66 : index) : i64
    %1 = llvm.mlir.constant(0 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(64 : index) : i64
    %4 = llvm.mlir.constant(-1 : index) : i64
    %5 = llvm.mlir.constant(-4.000000e+00 : f64) : f64
    %6 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %7 = llvm.insertvalue %arg7, %6[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.insertvalue %arg8, %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.insertvalue %arg9, %8[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %arg10, %9[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %arg12, %10[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %arg11, %11[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %arg13, %12[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = builtin.unrealized_conversion_cast %13 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<66x66xf64>
    %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %14 : memref<66x66xf64> -> memref<f64>, index, index, index, index, index
    %reinterpret_cast = memref.reinterpret_cast %base_buffer to offset: [67], sizes: [64, 64], strides: [66, 1] : memref<f64> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    %15 = builtin.unrealized_conversion_cast %reinterpret_cast : memref<64x64xf64, strided<[66, 1], offset: 67>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg14, %arg15) : i64 = (%1, %1) to (%3, %3) step (%2, %2) collapse(2) {
          %16 = llvm.add %arg14, %4 : i64
          %17 = llvm.mul %16, %0 overflow<nsw, nuw> : i64
          %18 = llvm.add %17, %arg15 overflow<nsw, nuw> : i64
          %19 = llvm.getelementptr inbounds|nuw %arg1[%18] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %20 = llvm.load %19 : !llvm.ptr -> f64
          %21 = llvm.add %arg14, %2 : i64
          %22 = llvm.mul %21, %0 overflow<nsw, nuw> : i64
          %23 = llvm.add %22, %arg15 overflow<nsw, nuw> : i64
          %24 = llvm.getelementptr inbounds|nuw %arg1[%23] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %25 = llvm.load %24 : !llvm.ptr -> f64
          %26 = llvm.add %arg15, %4 : i64
          %27 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %28 = llvm.add %27, %26 overflow<nsw, nuw> : i64
          %29 = llvm.getelementptr inbounds|nuw %arg1[%28] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %30 = llvm.load %29 : !llvm.ptr -> f64
          %31 = llvm.add %arg15, %2 : i64
          %32 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %33 = llvm.add %32, %31 overflow<nsw, nuw> : i64
          %34 = llvm.getelementptr inbounds|nuw %arg1[%33] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %35 = llvm.load %34 : !llvm.ptr -> f64
          %36 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %37 = llvm.add %36, %arg15 overflow<nsw, nuw> : i64
          %38 = llvm.getelementptr inbounds|nuw %arg1[%37] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %39 = llvm.load %38 : !llvm.ptr -> f64
          %40 = llvm.fadd %20, %25 : f64
          %41 = llvm.fadd %30, %35 : f64
          %42 = llvm.fadd %40, %41 : f64
          %43 = llvm.fmul %39, %5 : f64
          %44 = llvm.fadd %43, %42 : f64
          %45 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %46 = llvm.getelementptr %45[67] : (!llvm.ptr) -> !llvm.ptr, f64
          %47 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %48 = llvm.add %47, %arg15 overflow<nsw, nuw> : i64
          %49 = llvm.getelementptr inbounds|nuw %46[%48] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          llvm.store %44, %49 : f64, !llvm.ptr
          omp.yield
        }
      }
      omp.terminator
    }
    llvm.return
  }
}

