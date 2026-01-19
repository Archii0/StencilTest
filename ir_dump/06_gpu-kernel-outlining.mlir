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
    gpu.func @laplace2d_kernel(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<66x66xf64>, %arg4: f64, %arg5: memref<64x64xf64, strided<[66, 1], offset: 67>>) kernel attributes {known_block_size = array<i32: 1, 1, 1>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      %0 = affine.apply #map1(%block_id_x)[%arg0, %arg1]
      %1 = affine.apply #map1(%block_id_y)[%arg0, %arg1]
      %2 = arith.addi %0, %arg2 : index
      %3 = memref.load %arg3[%2, %1] : memref<66x66xf64>
      %4 = arith.addi %0, %arg0 : index
      %5 = memref.load %arg3[%4, %1] : memref<66x66xf64>
      %6 = arith.addi %1, %arg2 : index
      %7 = memref.load %arg3[%0, %6] : memref<66x66xf64>
      %8 = arith.addi %1, %arg0 : index
      %9 = memref.load %arg3[%0, %8] : memref<66x66xf64>
      %10 = memref.load %arg3[%0, %1] : memref<66x66xf64>
      %11 = arith.addf %3, %5 : f64
      %12 = arith.addf %7, %9 : f64
      %13 = arith.addf %11, %12 : f64
      %14 = arith.mulf %10, %arg4 : f64
      %15 = arith.addf %14, %13 : f64
      memref.store %15, %arg5[%0, %1] : memref<64x64xf64, strided<[66, 1], offset: 67>>
      gpu.return
    }
  }
}

