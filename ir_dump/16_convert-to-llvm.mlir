module attributes {gpu.container_module} {
  llvm.func @laplace2d(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<66x66xf64>
    %9 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = llvm.insertvalue %arg7, %9[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %arg8, %10[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %arg9, %11[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %arg10, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %arg12, %13[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %arg11, %14[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %arg13, %15[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.mlir.constant(0 : index) : i64
    %18 = llvm.mlir.constant(1 : index) : i64
    %19 = llvm.mlir.constant(64 : index) : i64
    %20 = llvm.mlir.constant(-4.000000e+00 : f64) : f64
    %21 = llvm.mlir.constant(-1 : index) : i64
    %22 = builtin.unrealized_conversion_cast %21 : i64 to index
    %23 = builtin.unrealized_conversion_cast %18 : i64 to index
    %24 = builtin.unrealized_conversion_cast %17 : i64 to index
    %25 = llvm.extractvalue %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %28 = llvm.insertvalue %25, %27[0] : !llvm.struct<(ptr, ptr, i64)> 
    %29 = llvm.insertvalue %26, %28[1] : !llvm.struct<(ptr, ptr, i64)> 
    %30 = llvm.mlir.constant(0 : index) : i64
    %31 = llvm.insertvalue %30, %29[2] : !llvm.struct<(ptr, ptr, i64)> 
    %32 = llvm.extractvalue %16[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.extractvalue %16[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.extractvalue %16[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.extractvalue %16[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.extractvalue %16[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %38 = llvm.extractvalue %31[0] : !llvm.struct<(ptr, ptr, i64)> 
    %39 = llvm.extractvalue %31[1] : !llvm.struct<(ptr, ptr, i64)> 
    %40 = llvm.insertvalue %38, %37[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %41 = llvm.insertvalue %39, %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %42 = llvm.mlir.constant(67 : index) : i64
    %43 = llvm.insertvalue %42, %41[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %44 = llvm.mlir.constant(64 : index) : i64
    %45 = llvm.insertvalue %44, %43[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %46 = llvm.mlir.constant(66 : index) : i64
    %47 = llvm.insertvalue %46, %45[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %48 = llvm.mlir.constant(64 : index) : i64
    %49 = llvm.insertvalue %48, %47[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %50 = llvm.mlir.constant(1 : index) : i64
    %51 = llvm.insertvalue %50, %49[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = builtin.unrealized_conversion_cast %51 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    %53 = builtin.unrealized_conversion_cast %18 : i64 to index
    %54 = builtin.unrealized_conversion_cast %19 : i64 to index
    %55 = builtin.unrealized_conversion_cast %19 : i64 to index
    gpu.launch_func  @laplace2d_kernel::@laplace2d_kernel blocks in (%54, %55, %53) threads in (%53, %53, %53)  args(%23 : index, %24 : index, %22 : index, %8 : memref<66x66xf64>, %20 : f64, %52 : memref<64x64xf64, strided<[66, 1], offset: 67>>)
    llvm.return
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

