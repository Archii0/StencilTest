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
    %15 = llvm.extractvalue %13[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.extractvalue %13[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %18 = llvm.insertvalue %15, %17[0] : !llvm.struct<(ptr, ptr, i64)> 
    %19 = llvm.insertvalue %16, %18[1] : !llvm.struct<(ptr, ptr, i64)> 
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.insertvalue %20, %19[2] : !llvm.struct<(ptr, ptr, i64)> 
    %22 = llvm.extractvalue %13[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.extractvalue %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.extractvalue %13[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.extractvalue %13[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.extractvalue %13[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %28 = llvm.extractvalue %21[0] : !llvm.struct<(ptr, ptr, i64)> 
    %29 = llvm.extractvalue %21[1] : !llvm.struct<(ptr, ptr, i64)> 
    %30 = llvm.insertvalue %28, %27[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.insertvalue %29, %30[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.mlir.constant(67 : index) : i64
    %33 = llvm.insertvalue %32, %31[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.mlir.constant(64 : index) : i64
    %35 = llvm.insertvalue %34, %33[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.mlir.constant(66 : index) : i64
    %37 = llvm.insertvalue %36, %35[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.mlir.constant(64 : index) : i64
    %39 = llvm.insertvalue %38, %37[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.insertvalue %40, %39[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %42 = builtin.unrealized_conversion_cast %41 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    %43 = builtin.unrealized_conversion_cast %42 : memref<64x64xf64, strided<[66, 1], offset: 67>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg14, %arg15) : i64 = (%1, %1) to (%3, %3) step (%2, %2) collapse(2) {
          %44 = llvm.add %arg14, %4 : i64
          %45 = llvm.mul %44, %0 overflow<nsw, nuw> : i64
          %46 = llvm.add %45, %arg15 overflow<nsw, nuw> : i64
          %47 = llvm.getelementptr inbounds|nuw %arg1[%46] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %48 = llvm.load %47 : !llvm.ptr -> f64
          %49 = llvm.add %arg14, %2 : i64
          %50 = llvm.mul %49, %0 overflow<nsw, nuw> : i64
          %51 = llvm.add %50, %arg15 overflow<nsw, nuw> : i64
          %52 = llvm.getelementptr inbounds|nuw %arg1[%51] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %53 = llvm.load %52 : !llvm.ptr -> f64
          %54 = llvm.add %arg15, %4 : i64
          %55 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %56 = llvm.add %55, %54 overflow<nsw, nuw> : i64
          %57 = llvm.getelementptr inbounds|nuw %arg1[%56] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %58 = llvm.load %57 : !llvm.ptr -> f64
          %59 = llvm.add %arg15, %2 : i64
          %60 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %61 = llvm.add %60, %59 overflow<nsw, nuw> : i64
          %62 = llvm.getelementptr inbounds|nuw %arg1[%61] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %63 = llvm.load %62 : !llvm.ptr -> f64
          %64 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %65 = llvm.add %64, %arg15 overflow<nsw, nuw> : i64
          %66 = llvm.getelementptr inbounds|nuw %arg1[%65] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %67 = llvm.load %66 : !llvm.ptr -> f64
          %68 = llvm.fadd %48, %53 : f64
          %69 = llvm.fadd %58, %63 : f64
          %70 = llvm.fadd %68, %69 : f64
          %71 = llvm.fmul %67, %5 : f64
          %72 = llvm.fadd %71, %70 : f64
          %73 = llvm.extractvalue %43[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %74 = llvm.getelementptr %73[67] : (!llvm.ptr) -> !llvm.ptr, f64
          %75 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %76 = llvm.add %75, %arg15 overflow<nsw, nuw> : i64
          %77 = llvm.getelementptr inbounds|nuw %74[%76] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          llvm.store %72, %77 : f64, !llvm.ptr
          omp.yield
        }
      }
      omp.terminator
    }
    llvm.return
  }
}

