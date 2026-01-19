module {
  func.func @laplace2d(%arg0: memref<66x66xf64>, %arg1: memref<66x66xf64>) {
    %subview = memref.subview %arg1[1, 1] [64, 64] [1, 1] : memref<66x66xf64> to memref<64x64xf64, strided<[66, 1], offset: 67>>
    %subview_0 = memref.subview %arg0[0, 0] [66, 66] [1, 1] : memref<66x66xf64> to memref<66x66xf64, strided<[66, 1]>>
    %c0 = arith.constant 0 : index
    %c0_1 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    %c64 = arith.constant 64 : index
    %c64_3 = arith.constant 64 : index
    %0 = llvm.mlir.constant(1 : i64) : i64
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg2, %arg3) : index = (%c0, %c0_1) to (%c64, %c64_3) step (%c1, %c1_2) collapse(2) {
          memref.alloca_scope  {
            %c-1 = arith.constant -1 : index
            %1 = arith.addi %arg2, %c-1 : index
            %2 = memref.load %subview_0[%1, %arg3] : memref<66x66xf64, strided<[66, 1]>>
            %c1_4 = arith.constant 1 : index
            %3 = arith.addi %arg2, %c1_4 : index
            %4 = memref.load %subview_0[%3, %arg3] : memref<66x66xf64, strided<[66, 1]>>
            %c-1_5 = arith.constant -1 : index
            %5 = arith.addi %arg3, %c-1_5 : index
            %6 = memref.load %subview_0[%arg2, %5] : memref<66x66xf64, strided<[66, 1]>>
            %c1_6 = arith.constant 1 : index
            %7 = arith.addi %arg3, %c1_6 : index
            %8 = memref.load %subview_0[%arg2, %7] : memref<66x66xf64, strided<[66, 1]>>
            %9 = memref.load %subview_0[%arg2, %arg3] : memref<66x66xf64, strided<[66, 1]>>
            %10 = arith.addf %2, %4 : f64
            %11 = arith.addf %6, %8 : f64
            %12 = arith.addf %10, %11 : f64
            %cst = arith.constant -4.000000e+00 : f64
            %13 = arith.mulf %9, %cst : f64
            %14 = arith.addf %13, %12 : f64
            memref.store %14, %subview[%arg2, %arg3] : memref<64x64xf64, strided<[66, 1], offset: 67>>
          }
          omp.yield
        }
      }
      omp.terminator
    }
    return
  }
}

