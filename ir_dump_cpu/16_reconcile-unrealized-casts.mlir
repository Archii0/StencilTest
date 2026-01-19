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
    %14 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %15 = llvm.insertvalue %arg7, %14[0] : !llvm.struct<(ptr, ptr, i64)> 
    %16 = llvm.insertvalue %arg8, %15[1] : !llvm.struct<(ptr, ptr, i64)> 
    %17 = llvm.mlir.constant(0 : index) : i64
    %18 = llvm.insertvalue %17, %16[2] : !llvm.struct<(ptr, ptr, i64)> 
    %19 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = llvm.insertvalue %arg7, %19[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %arg8, %20[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.mlir.constant(67 : index) : i64
    %23 = llvm.insertvalue %22, %21[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.mlir.constant(64 : index) : i64
    %25 = llvm.insertvalue %24, %23[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.mlir.constant(66 : index) : i64
    %27 = llvm.insertvalue %26, %25[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.mlir.constant(64 : index) : i64
    %29 = llvm.insertvalue %28, %27[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %30 = llvm.mlir.constant(1 : index) : i64
    %31 = llvm.insertvalue %30, %29[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg14, %arg15) : i64 = (%1, %1) to (%3, %3) step (%2, %2) collapse(2) {
          %32 = llvm.add %arg14, %4 : i64
          %33 = llvm.mul %32, %0 overflow<nsw, nuw> : i64
          %34 = llvm.add %33, %arg15 overflow<nsw, nuw> : i64
          %35 = llvm.getelementptr inbounds|nuw %arg1[%34] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %36 = llvm.load %35 : !llvm.ptr -> f64
          %37 = llvm.add %arg14, %2 : i64
          %38 = llvm.mul %37, %0 overflow<nsw, nuw> : i64
          %39 = llvm.add %38, %arg15 overflow<nsw, nuw> : i64
          %40 = llvm.getelementptr inbounds|nuw %arg1[%39] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %41 = llvm.load %40 : !llvm.ptr -> f64
          %42 = llvm.add %arg15, %4 : i64
          %43 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %44 = llvm.add %43, %42 overflow<nsw, nuw> : i64
          %45 = llvm.getelementptr inbounds|nuw %arg1[%44] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %46 = llvm.load %45 : !llvm.ptr -> f64
          %47 = llvm.add %arg15, %2 : i64
          %48 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %49 = llvm.add %48, %47 overflow<nsw, nuw> : i64
          %50 = llvm.getelementptr inbounds|nuw %arg1[%49] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %51 = llvm.load %50 : !llvm.ptr -> f64
          %52 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %53 = llvm.add %52, %arg15 overflow<nsw, nuw> : i64
          %54 = llvm.getelementptr inbounds|nuw %arg1[%53] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %55 = llvm.load %54 : !llvm.ptr -> f64
          %56 = llvm.fadd %36, %41 : f64
          %57 = llvm.fadd %46, %51 : f64
          %58 = llvm.fadd %56, %57 : f64
          %59 = llvm.fmul %55, %5 : f64
          %60 = llvm.fadd %59, %58 : f64
          %61 = llvm.extractvalue %31[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %62 = llvm.getelementptr %61[67] : (!llvm.ptr) -> !llvm.ptr, f64
          %63 = llvm.mul %arg14, %0 overflow<nsw, nuw> : i64
          %64 = llvm.add %63, %arg15 overflow<nsw, nuw> : i64
          %65 = llvm.getelementptr inbounds|nuw %62[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          llvm.store %60, %65 : f64, !llvm.ptr
          omp.yield
        }
      }
      omp.terminator
    }
    llvm.return
  }
}

