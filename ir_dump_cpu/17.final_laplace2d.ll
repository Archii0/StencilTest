; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

%struct.ident_t = type { i32, i32, i32, i32, ptr }

@0 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@1 = private unnamed_addr constant %struct.ident_t { i32 0, i32 2, i32 0, i32 22, ptr @0 }, align 8
@2 = private unnamed_addr constant %struct.ident_t { i32 0, i32 66, i32 0, i32 22, ptr @0 }, align 8

define void @laplace2d(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13) {
  %structArg = alloca { ptr, ptr }, align 8
  %.reloaded = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, align 8
  %15 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %7, 0
  %16 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %15, ptr %8, 1
  %17 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, i64 %9, 2
  %18 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, i64 %10, 3, 0
  %19 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %18, i64 %12, 4, 0
  %20 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %19, i64 %11, 3, 1
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, i64 %13, 4, 1
  %22 = insertvalue { ptr, ptr, i64 } poison, ptr %7, 0
  %23 = insertvalue { ptr, ptr, i64 } %22, ptr %8, 1
  %24 = insertvalue { ptr, ptr, i64 } %23, i64 0, 2
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %7, 0
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, ptr %8, 1
  %27 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, i64 67, 2
  %28 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %27, i64 64, 3, 0
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, i64 66, 4, 0
  %30 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, i64 64, 3, 1
  %31 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, i64 1, 4, 1
  br label %entry

entry:                                            ; preds = %14
  %omp_global_thread_num = call i32 @__kmpc_global_thread_num(ptr @1)
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, ptr %.reloaded, align 8
  br label %omp_parallel

omp_parallel:                                     ; preds = %entry
  %gep_.reloaded = getelementptr { ptr, ptr }, ptr %structArg, i32 0, i32 0
  store ptr %.reloaded, ptr %gep_.reloaded, align 8
  %gep_ = getelementptr { ptr, ptr }, ptr %structArg, i32 0, i32 1
  store ptr %1, ptr %gep_, align 8
  call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @1, i32 1, ptr @laplace2d..omp_par, ptr %structArg)
  br label %omp.par.exit

omp.par.exit:                                     ; preds = %omp_parallel
  ret void
}

; Function Attrs: nounwind
define internal void @laplace2d..omp_par(ptr noalias %tid.addr, ptr noalias %zero.addr, ptr %0) #0 {
omp.par.entry:
  %gep_.reloaded = getelementptr { ptr, ptr }, ptr %0, i32 0, i32 0
  %loadgep_.reloaded = load ptr, ptr %gep_.reloaded, align 8, !align !1
  %gep_ = getelementptr { ptr, ptr }, ptr %0, i32 0, i32 1
  %loadgep_ = load ptr, ptr %gep_, align 8, !align !2
  %p.lastiter = alloca i32, align 4
  %p.lowerbound = alloca i64, align 8
  %p.upperbound = alloca i64, align 8
  %p.stride = alloca i64, align 8
  %tid.addr.local = alloca i32, align 4
  %1 = load i32, ptr %tid.addr, align 4
  store i32 %1, ptr %tid.addr.local, align 4
  %tid = load i32, ptr %tid.addr.local, align 4
  %2 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %loadgep_.reloaded, align 8
  br label %omp.region.after_alloca2

omp.region.after_alloca2:                         ; preds = %omp.par.entry
  br label %omp.region.after_alloca

omp.region.after_alloca:                          ; preds = %omp.region.after_alloca2
  br label %omp.par.region

omp.par.region:                                   ; preds = %omp.region.after_alloca
  br label %omp.par.region1

omp.par.region1:                                  ; preds = %omp.par.region
  br label %omp.wsloop.region

omp.wsloop.region:                                ; preds = %omp.par.region1
  br label %omp_loop.preheader

omp_loop.preheader:                               ; preds = %omp.wsloop.region
  br label %omp_collapsed.preheader

omp_collapsed.preheader:                          ; preds = %omp_loop.preheader
  store i64 0, ptr %p.lowerbound, align 4
  store i64 4095, ptr %p.upperbound, align 4
  store i64 1, ptr %p.stride, align 4
  %omp_global_thread_num15 = call i32 @__kmpc_global_thread_num(ptr @1)
  call void @__kmpc_for_static_init_8u(ptr @1, i32 %omp_global_thread_num15, i32 34, ptr %p.lastiter, ptr %p.lowerbound, ptr %p.upperbound, ptr %p.stride, i64 1, i64 0)
  %3 = load i64, ptr %p.lowerbound, align 4
  %4 = load i64, ptr %p.upperbound, align 4
  %5 = sub i64 %4, %3
  %6 = add i64 %5, 1
  br label %omp_collapsed.header

omp_collapsed.header:                             ; preds = %omp_collapsed.inc, %omp_collapsed.preheader
  %omp_collapsed.iv = phi i64 [ 0, %omp_collapsed.preheader ], [ %omp_collapsed.next, %omp_collapsed.inc ]
  br label %omp_collapsed.cond

omp_collapsed.cond:                               ; preds = %omp_collapsed.header
  %omp_collapsed.cmp = icmp ult i64 %omp_collapsed.iv, %6
  br i1 %omp_collapsed.cmp, label %omp_collapsed.body, label %omp_collapsed.exit

omp_collapsed.exit:                               ; preds = %omp_collapsed.cond
  call void @__kmpc_for_static_fini(ptr @1, i32 %omp_global_thread_num15)
  %omp_global_thread_num16 = call i32 @__kmpc_global_thread_num(ptr @1)
  call void @__kmpc_barrier(ptr @2, i32 %omp_global_thread_num16)
  br label %omp_collapsed.after

omp_collapsed.after:                              ; preds = %omp_collapsed.exit
  br label %omp_loop.after

omp_loop.after:                                   ; preds = %omp_collapsed.after
  br label %omp.region.cont3

omp.region.cont3:                                 ; preds = %omp_loop.after
  br label %omp.region.cont

omp.region.cont:                                  ; preds = %omp.region.cont3
  br label %omp.par.pre_finalize

omp.par.pre_finalize:                             ; preds = %omp.region.cont
  br label %.fini

.fini:                                            ; preds = %omp.par.pre_finalize
  br label %omp.par.exit.exitStub

omp_collapsed.body:                               ; preds = %omp_collapsed.cond
  %7 = add i64 %omp_collapsed.iv, %3
  %8 = urem i64 %7, 64
  %9 = udiv i64 %7, 64
  br label %omp_loop.body

omp_loop.body:                                    ; preds = %omp_collapsed.body
  %10 = mul i64 %9, 1
  %11 = add i64 %10, 0
  br label %omp_loop.preheader4

omp_loop.preheader4:                              ; preds = %omp_loop.body
  br label %omp_loop.body7

omp_loop.body7:                                   ; preds = %omp_loop.preheader4
  %12 = mul i64 %8, 1
  %13 = add i64 %12, 0
  br label %omp.loop_nest.region

omp.loop_nest.region:                             ; preds = %omp_loop.body7
  %14 = add i64 %11, -1
  %15 = mul nuw nsw i64 %14, 66
  %16 = add nuw nsw i64 %15, %13
  %17 = getelementptr inbounds nuw double, ptr %loadgep_, i64 %16
  %18 = load double, ptr %17, align 8
  %19 = add i64 %11, 1
  %20 = mul nuw nsw i64 %19, 66
  %21 = add nuw nsw i64 %20, %13
  %22 = getelementptr inbounds nuw double, ptr %loadgep_, i64 %21
  %23 = load double, ptr %22, align 8
  %24 = add i64 %13, -1
  %25 = mul nuw nsw i64 %11, 66
  %26 = add nuw nsw i64 %25, %24
  %27 = getelementptr inbounds nuw double, ptr %loadgep_, i64 %26
  %28 = load double, ptr %27, align 8
  %29 = add i64 %13, 1
  %30 = mul nuw nsw i64 %11, 66
  %31 = add nuw nsw i64 %30, %29
  %32 = getelementptr inbounds nuw double, ptr %loadgep_, i64 %31
  %33 = load double, ptr %32, align 8
  %34 = mul nuw nsw i64 %11, 66
  %35 = add nuw nsw i64 %34, %13
  %36 = getelementptr inbounds nuw double, ptr %loadgep_, i64 %35
  %37 = load double, ptr %36, align 8
  %38 = fadd double %18, %23
  %39 = fadd double %28, %33
  %40 = fadd double %38, %39
  %41 = fmul double %37, -4.000000e+00
  %42 = fadd double %41, %40
  %43 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, 1
  %44 = getelementptr double, ptr %43, i32 67
  %45 = mul nuw nsw i64 %11, 66
  %46 = add nuw nsw i64 %45, %13
  %47 = getelementptr inbounds nuw double, ptr %44, i64 %46
  store double %42, ptr %47, align 8
  br label %omp.region.cont14

omp.region.cont14:                                ; preds = %omp.loop_nest.region
  br label %omp_loop.after10

omp_loop.after10:                                 ; preds = %omp.region.cont14
  br label %omp_collapsed.inc

omp_collapsed.inc:                                ; preds = %omp_loop.after10
  %omp_collapsed.next = add nuw i64 %omp_collapsed.iv, 1
  br label %omp_collapsed.header

omp.par.exit.exitStub:                            ; preds = %.fini
  ret void
}

; Function Attrs: nounwind
declare i32 @__kmpc_global_thread_num(ptr) #0

; Function Attrs: nounwind
declare void @__kmpc_for_static_init_8u(ptr, i32, i32, ptr, ptr, ptr, ptr, i64, i64) #0

; Function Attrs: nounwind
declare void @__kmpc_for_static_fini(ptr, i32) #0

; Function Attrs: convergent nounwind
declare void @__kmpc_barrier(ptr, i32) #1

; Function Attrs: nounwind
declare !callback !3 void @__kmpc_fork_call(ptr, i32, ptr, ...) #0

attributes #0 = { nounwind }
attributes #1 = { convergent nounwind }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{i64 8}
!2 = !{i64 1}
!3 = !{!4}
!4 = !{i64 2, i64 -1, i64 -1, i1 true}
