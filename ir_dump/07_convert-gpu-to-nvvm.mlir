#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module attributes {gpu.container_module} {
  func.func @laplace2d(%arg0: memref<66x66xf64>, %arg1: memref<66x66xf64>) {
    %cst = arith.constant -4.000000e+00 : f64
    %c-1 = arith.constant -1 : index
    %c64 = arith.constant 64 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg1[1, 1] [64, 64] [1, 1] : memref<66x66xf64> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    %c1_0 = arith.constant 1 : index
    %0 = affine.apply #map(%c64)[%c0, %c1]
    %1 = affine.apply #map(%c64)[%c0, %c1]
    gpu.launch_func  @laplace2d_kernel::@laplace2d_kernel blocks in (%0, %1, %c1_0) threads in (%c1_0, %c1_0, %c1_0)  args(%c1 : index, %c0 : index, %c-1 : index, %arg0 : memref<66x66xf64>, %cst : f64, %subview : memref<64x64xf64, strided<[66, 1], offset: 67>>)
    return
  }
  gpu.module @laplace2d_kernel {
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
      %24 = affine.apply #map1(%20)[%1, %0]
      %25 = builtin.unrealized_conversion_cast %24 : index to i64
      %26 = affine.apply #map1(%23)[%1, %0]
      %27 = builtin.unrealized_conversion_cast %26 : index to i64
      %28 = llvm.add %25, %arg2 : i64
      %29 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %30 = llvm.mlir.constant(66 : index) : i64
      %31 = llvm.mul %28, %30 overflow<nsw, nuw> : i64
      %32 = llvm.add %31, %27 overflow<nsw, nuw> : i64
      %33 = llvm.getelementptr inbounds|nuw %29[%32] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %34 = llvm.load %33 : !llvm.ptr -> f64
      %35 = llvm.add %25, %arg0 : i64
      %36 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %37 = llvm.mlir.constant(66 : index) : i64
      %38 = llvm.mul %35, %37 overflow<nsw, nuw> : i64
      %39 = llvm.add %38, %27 overflow<nsw, nuw> : i64
      %40 = llvm.getelementptr inbounds|nuw %36[%39] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %41 = llvm.load %40 : !llvm.ptr -> f64
      %42 = llvm.add %27, %arg2 : i64
      %43 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %44 = llvm.mlir.constant(66 : index) : i64
      %45 = llvm.mul %25, %44 overflow<nsw, nuw> : i64
      %46 = llvm.add %45, %42 overflow<nsw, nuw> : i64
      %47 = llvm.getelementptr inbounds|nuw %43[%46] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %48 = llvm.load %47 : !llvm.ptr -> f64
      %49 = llvm.add %27, %arg0 : i64
      %50 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %51 = llvm.mlir.constant(66 : index) : i64
      %52 = llvm.mul %25, %51 overflow<nsw, nuw> : i64
      %53 = llvm.add %52, %49 overflow<nsw, nuw> : i64
      %54 = llvm.getelementptr inbounds|nuw %50[%53] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %55 = llvm.load %54 : !llvm.ptr -> f64
      %56 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %57 = llvm.mlir.constant(66 : index) : i64
      %58 = llvm.mul %25, %57 overflow<nsw, nuw> : i64
      %59 = llvm.add %58, %27 overflow<nsw, nuw> : i64
      %60 = llvm.getelementptr inbounds|nuw %56[%59] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %61 = llvm.load %60 : !llvm.ptr -> f64
      %62 = llvm.fadd %34, %41 : f64
      %63 = llvm.fadd %48, %55 : f64
      %64 = llvm.fadd %62, %63 : f64
      %65 = llvm.fmul %61, %arg10 : f64
      %66 = llvm.fadd %65, %64 : f64
      %67 = llvm.extractvalue %9[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %68 = llvm.mlir.constant(67 : index) : i64
      %69 = llvm.getelementptr %67[%68] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %70 = llvm.mlir.constant(66 : index) : i64
      %71 = llvm.mul %25, %70 overflow<nsw, nuw> : i64
      %72 = llvm.add %71, %27 overflow<nsw, nuw> : i64
      %73 = llvm.getelementptr inbounds|nuw %69[%72] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      llvm.store %66, %73 : f64, !llvm.ptr
      llvm.return
    }
  }
}

