module {
  llvm.func @laplace2d(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg7, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg8, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg9, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg10, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg12, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg11, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg13, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<66x66xf64>
    %9 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = llvm.insertvalue %arg0, %9[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %arg1, %10[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %arg2, %11[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %arg3, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %arg5, %13[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %arg4, %14[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %arg6, %15[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.mlir.constant(-4.000000e+00 : f64) : f64
    %18 = llvm.mlir.constant(-1 : index) : i64
    %19 = llvm.mlir.constant(64 : index) : i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.mlir.constant(0 : index) : i64
    %subview = memref.subview %8[1, 1] [64, 64] [1, 1] : memref<66x66xf64> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    %22 = builtin.unrealized_conversion_cast %subview : memref<64x64xf64, strided<[66, 1], offset: 67>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg14, %arg15) : i64 = (%21, %21) to (%19, %19) step (%20, %20) collapse(2) {
          %23 = llvm.add %arg14, %18 : i64
          %24 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %25 = llvm.mlir.constant(66 : index) : i64
          %26 = llvm.mul %23, %25 overflow<nsw, nuw> : i64
          %27 = llvm.add %26, %arg15 overflow<nsw, nuw> : i64
          %28 = llvm.getelementptr inbounds|nuw %24[%27] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %29 = llvm.load %28 : !llvm.ptr -> f64
          %30 = llvm.add %arg14, %20 : i64
          %31 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %32 = llvm.mlir.constant(66 : index) : i64
          %33 = llvm.mul %30, %32 overflow<nsw, nuw> : i64
          %34 = llvm.add %33, %arg15 overflow<nsw, nuw> : i64
          %35 = llvm.getelementptr inbounds|nuw %31[%34] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %36 = llvm.load %35 : !llvm.ptr -> f64
          %37 = llvm.add %arg15, %18 : i64
          %38 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %39 = llvm.mlir.constant(66 : index) : i64
          %40 = llvm.mul %arg14, %39 overflow<nsw, nuw> : i64
          %41 = llvm.add %40, %37 overflow<nsw, nuw> : i64
          %42 = llvm.getelementptr inbounds|nuw %38[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %43 = llvm.load %42 : !llvm.ptr -> f64
          %44 = llvm.add %arg15, %20 : i64
          %45 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %46 = llvm.mlir.constant(66 : index) : i64
          %47 = llvm.mul %arg14, %46 overflow<nsw, nuw> : i64
          %48 = llvm.add %47, %44 overflow<nsw, nuw> : i64
          %49 = llvm.getelementptr inbounds|nuw %45[%48] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %50 = llvm.load %49 : !llvm.ptr -> f64
          %51 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %52 = llvm.mlir.constant(66 : index) : i64
          %53 = llvm.mul %arg14, %52 overflow<nsw, nuw> : i64
          %54 = llvm.add %53, %arg15 overflow<nsw, nuw> : i64
          %55 = llvm.getelementptr inbounds|nuw %51[%54] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %56 = llvm.load %55 : !llvm.ptr -> f64
          %57 = llvm.fadd %29, %36 : f64
          %58 = llvm.fadd %43, %50 : f64
          %59 = llvm.fadd %57, %58 : f64
          %60 = llvm.fmul %56, %17 : f64
          %61 = llvm.fadd %60, %59 : f64
          %62 = llvm.extractvalue %22[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %63 = llvm.mlir.constant(67 : index) : i64
          %64 = llvm.getelementptr %62[%63] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %65 = llvm.mlir.constant(66 : index) : i64
          %66 = llvm.mul %arg14, %65 overflow<nsw, nuw> : i64
          %67 = llvm.add %66, %arg15 overflow<nsw, nuw> : i64
          %68 = llvm.getelementptr inbounds|nuw %64[%67] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          llvm.store %61, %68 : f64, !llvm.ptr
          omp.yield
        }
      }
      omp.terminator
    }
    llvm.return
  }
}

