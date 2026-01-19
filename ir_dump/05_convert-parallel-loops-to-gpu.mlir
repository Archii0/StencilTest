#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
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
    gpu.launch blocks(%arg2, %arg3, %arg4) in (%arg8 = %0, %arg9 = %1, %arg10 = %c1_0) threads(%arg5, %arg6, %arg7) in (%arg11 = %c1_0, %arg12 = %c1_0, %arg13 = %c1_0) {
      %2 = affine.apply #map1(%arg2)[%c1, %c0]
      %3 = affine.apply #map1(%arg3)[%c1, %c0]
      %4 = arith.addi %2, %c-1 : index
      %5 = memref.load %arg0[%4, %3] : memref<66x66xf64>
      %6 = arith.addi %2, %c1 : index
      %7 = memref.load %arg0[%6, %3] : memref<66x66xf64>
      %8 = arith.addi %3, %c-1 : index
      %9 = memref.load %arg0[%2, %8] : memref<66x66xf64>
      %10 = arith.addi %3, %c1 : index
      %11 = memref.load %arg0[%2, %10] : memref<66x66xf64>
      %12 = memref.load %arg0[%2, %3] : memref<66x66xf64>
      %13 = arith.addf %5, %7 : f64
      %14 = arith.addf %9, %11 : f64
      %15 = arith.addf %13, %14 : f64
      %16 = arith.mulf %12, %cst : f64
      %17 = arith.addf %16, %15 : f64
      memref.store %17, %subview[%2, %3] : memref<64x64xf64, strided<[66, 1], offset: 67>>
      gpu.terminator
    } {SCFToGPU_visited}
    return
  }
}

