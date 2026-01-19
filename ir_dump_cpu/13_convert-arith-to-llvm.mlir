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
    %15 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %16 = llvm.insertvalue %arg7, %15[0] : !llvm.struct<(ptr, ptr, i64)> 
    %17 = llvm.insertvalue %arg8, %16[1] : !llvm.struct<(ptr, ptr, i64)> 
    %18 = llvm.mlir.constant(0 : index) : i64
    %19 = llvm.insertvalue %18, %17[2] : !llvm.struct<(ptr, ptr, i64)> 
    %20 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = llvm.insertvalue %arg7, %20[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %arg8, %21[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.mlir.constant(67 : index) : i64
    %24 = llvm.insertvalue %23, %22[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.mlir.constant(64 : index) : i64
    %26 = llvm.insertvalue %25, %24[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.mlir.constant(66 : index) : i64
    %28 = llvm.insertvalue %27, %26[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.mlir.constant(64 : index) : i64
    %30 = llvm.insertvalue %29, %28[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.mlir.constant(1 : index) : i64
    %32 = llvm.insertvalue %31, %30[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = builtin.unrealized_conversion_cast %32 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg14, %arg15) : i64 = (%1, %1) to (%3, %3) step (%2, %2) collapse(2) {
          %34 = llvm.add %arg14, %4 : i64
          %35 = llvm.mul %34, %0 overflow<nsw, nuw> : i64
          %36 = llvm.add %35, %arg15 overflow<nsw, nuw> : i64
          %37 = llvm.getelementptr inbounds|nuw %arg1[%36] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %38 = llvm.load %37 : !llvm.ptr -> f64
          %39 = llvm.add %arg14, %2 : i64
          %40 = llvm.mul %39, %0 overflow<nsw, nuw> : i64
          %41 = llvm.add %40, %arg15 overflow<nsw, nuw> : i64
          %42 = llvm.getelementptr inbounds|nuw %arg1[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %43 = llvm.load %42 : !llvm.ptr -> f64
          %44 = llvm.add %arg15, %4 : i64
          %45 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %46 = llvm.add %45, %44 overflow<nsw, nuw> : i64
          %47 = llvm.getelementptr inbounds|nuw %arg1[%46] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %48 = llvm.load %47 : !llvm.ptr -> f64
          %49 = llvm.add %arg15, %2 : i64
          %50 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %51 = llvm.add %50, %49 overflow<nsw, nuw> : i64
          %52 = llvm.getelementptr inbounds|nuw %arg1[%51] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %53 = llvm.load %52 : !llvm.ptr -> f64
          %54 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %55 = llvm.add %54, %arg15 overflow<nsw, nuw> : i64
          %56 = llvm.getelementptr inbounds|nuw %arg1[%55] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %57 = llvm.load %56 : !llvm.ptr -> f64
          %58 = llvm.fadd %38, %43 : f64
          %59 = llvm.fadd %48, %53 : f64
          %60 = llvm.fadd %58, %59 : f64
          %61 = llvm.fmul %57, %5 : f64
          %62 = llvm.fadd %61, %60 : f64
          %63 = llvm.extractvalue %32[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %64 = llvm.getelementptr %63[67] : (!llvm.ptr) -> !llvm.ptr, f64
          %65 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %66 = llvm.add %65, %arg15 overflow<nsw, nuw> : i64
          %67 = llvm.getelementptr inbounds|nuw %64[%66] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          llvm.store %62, %67 : f64, !llvm.ptr
          omp.yield
        }
      }
      omp.terminator
    }
    llvm.return
  }
}

