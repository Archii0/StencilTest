module {
  func.func @laplace2d(%arg0: memref<66x66xf64>, %arg1: memref<66x66xf64>) {
    %cst = arith.constant -4.000000e+00 : f64
    %c-1 = arith.constant -1 : index
    %c64 = arith.constant 64 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg1[1, 1] [64, 64] [1, 1] : memref<66x66xf64> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    scf.parallel (%arg2, %arg3) = (%c0, %c0) to (%c64, %c64) step (%c1, %c1) {
      %0 = arith.addi %arg2, %c-1 : index
      %1 = memref.load %arg0[%0, %arg3] : memref<66x66xf64>
      %2 = arith.addi %arg2, %c1 : index
      %3 = memref.load %arg0[%2, %arg3] : memref<66x66xf64>
      %4 = arith.addi %arg3, %c-1 : index
      %5 = memref.load %arg0[%arg2, %4] : memref<66x66xf64>
      %6 = arith.addi %arg3, %c1 : index
      %7 = memref.load %arg0[%arg2, %6] : memref<66x66xf64>
      %8 = memref.load %arg0[%arg2, %arg3] : memref<66x66xf64>
      %9 = arith.addf %1, %3 : f64
      %10 = arith.addf %5, %7 : f64
      %11 = arith.addf %9, %10 : f64
      %12 = arith.mulf %8, %cst : f64
      %13 = arith.addf %12, %11 : f64
      memref.store %13, %subview[%arg2, %arg3] : memref<64x64xf64, strided<[66, 1], offset: 67>>
      scf.reduce 
    }
    return
  }
}

