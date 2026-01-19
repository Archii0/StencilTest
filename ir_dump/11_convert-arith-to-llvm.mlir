module attributes {gpu.container_module} {
  func.func @laplace2d(%arg0: memref<66x66xf64>, %arg1: memref<66x66xf64>) {
    %0 = llvm.mlir.constant(-4.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(-1 : index) : i64
    %2 = builtin.unrealized_conversion_cast %1 : i64 to index
    %3 = llvm.mlir.constant(64 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = builtin.unrealized_conversion_cast %6 : i64 to index
    %subview = memref.subview %arg1[1, 1] [64, 64] [1, 1] : memref<66x66xf64> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = builtin.unrealized_conversion_cast %8 : i64 to index
    %10 = llvm.mlir.constant(64 : index) : i64
    %11 = builtin.unrealized_conversion_cast %10 : i64 to index
    %12 = llvm.mlir.constant(64 : index) : i64
    %13 = builtin.unrealized_conversion_cast %12 : i64 to index
    gpu.launch_func  @laplace2d_kernel::@laplace2d_kernel blocks in (%11, %13, %9) threads in (%9, %9, %9)  args(%5 : index, %7 : index, %2 : index, %arg0 : memref<66x66xf64>, %0 : f64, %subview : memref<64x64xf64, strided<[66, 1], offset: 67>>)
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
      %24 = llvm.mul %19, %arg0 overflow<nsw> : i64
      %25 = llvm.add %24, %arg1 : i64
      %26 = builtin.unrealized_conversion_cast %25 : i64 to index
      %27 = builtin.unrealized_conversion_cast %26 : index to i64
      %28 = llvm.mul %22, %arg0 overflow<nsw> : i64
      %29 = llvm.add %28, %arg1 : i64
      %30 = builtin.unrealized_conversion_cast %29 : i64 to index
      %31 = builtin.unrealized_conversion_cast %30 : index to i64
      %32 = llvm.add %27, %arg2 : i64
      %33 = llvm.mlir.constant(66 : index) : i64
      %34 = llvm.mul %32, %33 overflow<nsw, nuw> : i64
      %35 = llvm.add %34, %31 overflow<nsw, nuw> : i64
      %36 = llvm.getelementptr inbounds|nuw %arg4[%35] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %37 = llvm.load %36 : !llvm.ptr -> f64
      %38 = llvm.add %27, %arg0 : i64
      %39 = llvm.mlir.constant(66 : index) : i64
      %40 = llvm.mul %38, %39 overflow<nsw, nuw> : i64
      %41 = llvm.add %40, %31 overflow<nsw, nuw> : i64
      %42 = llvm.getelementptr inbounds|nuw %arg4[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %43 = llvm.load %42 : !llvm.ptr -> f64
      %44 = llvm.add %31, %arg2 : i64
      %45 = llvm.mlir.constant(66 : index) : i64
      %46 = llvm.mul %27, %45 overflow<nsw, nuw> : i64
      %47 = llvm.add %46, %44 overflow<nsw, nuw> : i64
      %48 = llvm.getelementptr inbounds|nuw %arg4[%47] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %49 = llvm.load %48 : !llvm.ptr -> f64
      %50 = llvm.add %31, %arg0 : i64
      %51 = llvm.mlir.constant(66 : index) : i64
      %52 = llvm.mul %27, %51 overflow<nsw, nuw> : i64
      %53 = llvm.add %52, %50 overflow<nsw, nuw> : i64
      %54 = llvm.getelementptr inbounds|nuw %arg4[%53] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %55 = llvm.load %54 : !llvm.ptr -> f64
      %56 = llvm.mlir.constant(66 : index) : i64
      %57 = llvm.mul %27, %56 overflow<nsw, nuw> : i64
      %58 = llvm.add %57, %31 overflow<nsw, nuw> : i64
      %59 = llvm.getelementptr inbounds|nuw %arg4[%58] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %60 = llvm.load %59 : !llvm.ptr -> f64
      %61 = llvm.fadd %37, %43 : f64
      %62 = llvm.fadd %49, %55 : f64
      %63 = llvm.fadd %61, %62 : f64
      %64 = llvm.fmul %60, %arg10 : f64
      %65 = llvm.fadd %64, %63 : f64
      %66 = llvm.mlir.constant(67 : index) : i64
      %67 = llvm.getelementptr %arg12[67] : (!llvm.ptr) -> !llvm.ptr, f64
      %68 = llvm.mlir.constant(66 : index) : i64
      %69 = llvm.mul %27, %68 overflow<nsw, nuw> : i64
      %70 = llvm.add %69, %31 overflow<nsw, nuw> : i64
      %71 = llvm.getelementptr inbounds|nuw %67[%70] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      llvm.store %65, %71 : f64, !llvm.ptr
      llvm.return
    }
  }
}

