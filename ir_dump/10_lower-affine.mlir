module attributes {gpu.container_module} {
  func.func @laplace2d(%arg0: memref<66x66xf64>, %arg1: memref<66x66xf64>) {
    %cst = arith.constant -4.000000e+00 : f64
    %c-1 = arith.constant -1 : index
    %c64 = arith.constant 64 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg1[1, 1] [64, 64] [1, 1] : memref<66x66xf64> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    %c1_0 = arith.constant 1 : index
    %c64_1 = arith.constant 64 : index
    %c64_2 = arith.constant 64 : index
    gpu.launch_func  @laplace2d_kernel::@laplace2d_kernel blocks in (%c64_1, %c64_2, %c1_0) threads in (%c1_0, %c1_0, %c1_0)  args(%c1 : index, %c0 : index, %c-1 : index, %arg0 : memref<66x66xf64>, %cst : f64, %subview : memref<64x64xf64, strided<[66, 1], offset: 67>>)
    return
  }
  gpu.module @laplace2d_kernel [#nvvm.target<chip = "sm_90,triple=nvptx64-nvidia-cuda">] {
    llvm.func @laplace2d_kernel(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: f64, %arg11: !llvm.ptr, %arg12: !llvm.ptr, %arg13: i64, %arg14: i64, %arg15: i64, %arg16: i64, %arg17: i64) attributes {gpu.kernel, gpu.known_block_size = array<i32: 1, 1, 1>, nvvm.kernel, nvvm.maxntid = array<i32: 1, 1, 1>} {
      %0 = builtin.unrealized_conversion_cast %arg1 : i64 to index
      %1 = builtin.unrealized_conversion_cast %arg0 : i64 to index
      %2 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %3 = llvm.insertvalue %arg11, %2[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %4 = llvm.insertvalue %arg12, %3[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %5 = llvm.insertvalue %arg13, %4[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %6 = llvm.insertvalue %arg14, %5[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %7 = llvm.insertvalue %arg16, %6[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %8 = llvm.insertvalue %arg15, %7[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %9 = llvm.insertvalue %arg17, %8[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %10 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %11 = llvm.insertvalue %arg3, %10[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %arg4, %11[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %arg5, %12[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = llvm.insertvalue %arg6, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %15 = llvm.insertvalue %arg8, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %16 = llvm.insertvalue %arg7, %15[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %17 = llvm.insertvalue %arg9, %16[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %18 = nvvm.read.ptx.sreg.ctaid.x : i32
      %19 = llvm.sext %18 : i32 to i64
      %20 = builtin.unrealized_conversion_cast %19 : i64 to index
      %21 = nvvm.read.ptx.sreg.ctaid.y : i32
      %22 = llvm.sext %21 : i32 to i64
      %23 = builtin.unrealized_conversion_cast %22 : i64 to index
      %24 = arith.muli %20, %1 overflow<nsw> : index
      %25 = arith.addi %24, %0 : index
      %26 = builtin.unrealized_conversion_cast %25 : index to i64
      %27 = arith.muli %23, %1 overflow<nsw> : index
      %28 = arith.addi %27, %0 : index
      %29 = builtin.unrealized_conversion_cast %28 : index to i64
      %30 = llvm.add %26, %arg2 : i64
      %31 = llvm.mlir.constant(66 : index) : i64
      %32 = llvm.mul %30, %31 overflow<nsw, nuw> : i64
      %33 = llvm.add %32, %29 overflow<nsw, nuw> : i64
      %34 = llvm.getelementptr inbounds|nuw %arg4[%33] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %35 = llvm.load %34 : !llvm.ptr -> f64
      %36 = llvm.add %26, %arg0 : i64
      %37 = llvm.mlir.constant(66 : index) : i64
      %38 = llvm.mul %36, %37 overflow<nsw, nuw> : i64
      %39 = llvm.add %38, %29 overflow<nsw, nuw> : i64
      %40 = llvm.getelementptr inbounds|nuw %arg4[%39] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %41 = llvm.load %40 : !llvm.ptr -> f64
      %42 = llvm.add %29, %arg2 : i64
      %43 = llvm.mlir.constant(66 : index) : i64
      %44 = llvm.mul %26, %43 overflow<nsw, nuw> : i64
      %45 = llvm.add %44, %42 overflow<nsw, nuw> : i64
      %46 = llvm.getelementptr inbounds|nuw %arg4[%45] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %47 = llvm.load %46 : !llvm.ptr -> f64
      %48 = llvm.add %29, %arg0 : i64
      %49 = llvm.mlir.constant(66 : index) : i64
      %50 = llvm.mul %26, %49 overflow<nsw, nuw> : i64
      %51 = llvm.add %50, %48 overflow<nsw, nuw> : i64
      %52 = llvm.getelementptr inbounds|nuw %arg4[%51] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %53 = llvm.load %52 : !llvm.ptr -> f64
      %54 = llvm.mlir.constant(66 : index) : i64
      %55 = llvm.mul %26, %54 overflow<nsw, nuw> : i64
      %56 = llvm.add %55, %29 overflow<nsw, nuw> : i64
      %57 = llvm.getelementptr inbounds|nuw %arg4[%56] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %58 = llvm.load %57 : !llvm.ptr -> f64
      %59 = llvm.fadd %35, %41 : f64
      %60 = llvm.fadd %47, %53 : f64
      %61 = llvm.fadd %59, %60 : f64
      %62 = llvm.fmul %58, %arg10 : f64
      %63 = llvm.fadd %62, %61 : f64
      %64 = llvm.mlir.constant(67 : index) : i64
      %65 = llvm.getelementptr %arg12[67] : (!llvm.ptr) -> !llvm.ptr, f64
      %66 = llvm.mlir.constant(66 : index) : i64
      %67 = llvm.mul %26, %66 overflow<nsw, nuw> : i64
      %68 = llvm.add %67, %29 overflow<nsw, nuw> : i64
      %69 = llvm.getelementptr inbounds|nuw %65[%68] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      llvm.store %63, %69 : f64, !llvm.ptr
      llvm.return
    }
  }
}

