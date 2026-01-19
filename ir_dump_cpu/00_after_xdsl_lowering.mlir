builtin.module {
  func.func @laplace2d(%in : memref<66x66xf64>, %out : memref<66x66xf64>) {
    %out_storeview = memref.subview %out[1, 1] [64, 64] [1, 1] : memref<66x66xf64> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    %in_loadview = memref.subview %in[0, 0] [66, 66] [1, 1] : memref<66x66xf64> to memref<66x66xf64, strided<[66, 1]>>
    %0 = arith.constant 0 : index
    %1 = arith.constant 0 : index
    %2 = arith.constant 1 : index
    %3 = arith.constant 1 : index
    %4 = arith.constant 64 : index
    %5 = arith.constant 64 : index
    "scf.parallel"(%0, %1, %4, %5, %2, %3) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%6 : index, %7 : index):
      %l = arith.constant -1 : index
      %l_1 = arith.addi %6, %l : index
      %l_2 = memref.load %in_loadview[%l_1, %7] : memref<66x66xf64, strided<[66, 1]>>
      %r = arith.constant 1 : index
      %r_1 = arith.addi %6, %r : index
      %r_2 = memref.load %in_loadview[%r_1, %7] : memref<66x66xf64, strided<[66, 1]>>
      %d = arith.constant -1 : index
      %d_1 = arith.addi %7, %d : index
      %d_2 = memref.load %in_loadview[%6, %d_1] : memref<66x66xf64, strided<[66, 1]>>
      %u = arith.constant 1 : index
      %u_1 = arith.addi %7, %u : index
      %u_2 = memref.load %in_loadview[%6, %u_1] : memref<66x66xf64, strided<[66, 1]>>
      %c = memref.load %in_loadview[%6, %7] : memref<66x66xf64, strided<[66, 1]>>
      %s0 = arith.addf %l_2, %r_2 : f64
      %s1 = arith.addf %d_2, %u_2 : f64
      %sum = arith.addf %s0, %s1 : f64
      %neg4 = arith.constant -4.000000e+00 : f64
      %c2m = arith.mulf %c, %neg4 : f64
      %lap = arith.addf %c2m, %sum : f64
      memref.store %lap, %out_storeview[%6, %7] : memref<64x64xf64, strided<[66, 1], offset: 67>>
      scf.reduce
    }) : (index, index, index, index, index, index) -> ()
    func.return
  }
}
