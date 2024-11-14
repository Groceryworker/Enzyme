; ModuleID = 'input.ll'
source_filename = "test_Enzyme_complex.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { ptr, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", ptr, i8, i8, ptr, ptr, ptr, ptr }
%"class.std::ios_base" = type { ptr, i64, i64, i32, i32, i32, ptr, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, ptr, %"class.std::locale" }
%"struct.std::ios_base::_Words" = type { ptr, i64 }
%"class.std::locale" = type { ptr }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], ptr, i8, [7 x i8], ptr, ptr, ptr, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ ptr, i32 }>

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@enzyme_out = dso_local local_unnamed_addr global i32 0, align 4
@enzyme_const = dso_local local_unnamed_addr global i32 0, align 4
@enzyme_dup = dso_local local_unnamed_addr global i32 0, align 4
@_ZSt4cout = external global %"class.std::basic_ostream", align 8
@.str = private unnamed_addr constant [11 x i8] c"f(x, y) = \00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"df/dx = \00", align 1
@.str.2 = private unnamed_addr constant [9 x i8] c"df/dy = \00", align 1
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @_GLOBAL__sub_I_test_Enzyme_complex.cpp, ptr null }]

declare void @_ZNSt8ios_base4InitC1Ev(ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nofree nounwind
declare i32 @__cxa_atexit(ptr, ptr, ptr) local_unnamed_addr #2

; Function Attrs: mustprogress nofree nounwind willreturn writeonly uwtable
define dso_local noundef double @_Z4funcdd(double noundef %0, double noundef %1) #3 {
  %3 = tail call double @sin(double noundef %1) #9
  %4 = fmul double %3, %0
  %5 = tail call double @cos(double noundef %0) #9
  %6 = fmul double %4, %5
  %7 = tail call double @sin(double noundef %1) #9
  %8 = tail call double @cos(double noundef %0) #9
  %9 = fmul double %8, %1
  %10 = tail call double @llvm.fmuladd.f64(double %0, double %7, double %9)
  %11 = fmul double %6, %10
  ret double %11
}

; Function Attrs: mustprogress nofree nounwind willreturn writeonly
declare double @sin(double noundef) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nounwind willreturn writeonly
declare double @cos(double noundef) local_unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #5

; Function Attrs: mustprogress norecurse uwtable
define dso_local noundef i32 @main() local_unnamed_addr #6 {
  %1 = load i32, ptr @enzyme_out, align 4, !tbaa !5
  %2 = call { double, double } @diffe_Z4funcdd(double 2.000000e+00, double 3.000000e+00, double 1.000000e+00)
  %3 = extractvalue { double, double } %2, 0
  %4 = extractvalue { double, double } %2, 1
  %5 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr noundef nonnull @.str, i64 noundef 10)
  %6 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo9_M_insertIdEERSoT_(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, double noundef 0x3FBD0D3FF5FCD268)
  %7 = load ptr, ptr %6, align 8, !tbaa !9
  %8 = getelementptr i8, ptr %7, i64 -24
  %9 = load i64, ptr %8, align 8
  %10 = getelementptr inbounds i8, ptr %6, i64 %9
  %11 = getelementptr inbounds %"class.std::basic_ios", ptr %10, i64 0, i32 5
  %12 = load ptr, ptr %11, align 8, !tbaa !11
  %13 = icmp eq ptr %12, null
  br i1 %13, label %14, label %15

14:                                               ; preds = %0
  tail call void @_ZSt16__throw_bad_castv() #10
  unreachable

15:                                               ; preds = %0
  %16 = getelementptr inbounds %"class.std::ctype", ptr %12, i64 0, i32 8
  %17 = load i8, ptr %16, align 8, !tbaa !21
  %18 = icmp eq i8 %17, 0
  br i1 %18, label %22, label %19

19:                                               ; preds = %15
  %20 = getelementptr inbounds %"class.std::ctype", ptr %12, i64 0, i32 9, i64 10
  %21 = load i8, ptr %20, align 1, !tbaa !24
  br label %27

22:                                               ; preds = %15
  tail call void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570) %12)
  %23 = load ptr, ptr %12, align 8, !tbaa !9
  %24 = getelementptr inbounds ptr, ptr %23, i64 6
  %25 = load ptr, ptr %24, align 8
  %26 = tail call noundef signext i8 %25(ptr noundef nonnull align 8 dereferenceable(570) %12, i8 noundef signext 10)
  br label %27

27:                                               ; preds = %22, %19
  %28 = phi i8 [ %21, %19 ], [ %26, %22 ]
  %29 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8) %6, i8 noundef signext %28)
  %30 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8) %29)
  %31 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr noundef nonnull @.str.1, i64 noundef 8)
  %32 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo9_M_insertIdEERSoT_(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, double noundef %3)
  %33 = load ptr, ptr %32, align 8, !tbaa !9
  %34 = getelementptr i8, ptr %33, i64 -24
  %35 = load i64, ptr %34, align 8
  %36 = getelementptr inbounds i8, ptr %32, i64 %35
  %37 = getelementptr inbounds %"class.std::basic_ios", ptr %36, i64 0, i32 5
  %38 = load ptr, ptr %37, align 8, !tbaa !11
  %39 = icmp eq ptr %38, null
  br i1 %39, label %40, label %41

40:                                               ; preds = %27
  tail call void @_ZSt16__throw_bad_castv() #10
  unreachable

41:                                               ; preds = %27
  %42 = getelementptr inbounds %"class.std::ctype", ptr %38, i64 0, i32 8
  %43 = load i8, ptr %42, align 8, !tbaa !21
  %44 = icmp eq i8 %43, 0
  br i1 %44, label %48, label %45

45:                                               ; preds = %41
  %46 = getelementptr inbounds %"class.std::ctype", ptr %38, i64 0, i32 9, i64 10
  %47 = load i8, ptr %46, align 1, !tbaa !24
  br label %53

48:                                               ; preds = %41
  tail call void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570) %38)
  %49 = load ptr, ptr %38, align 8, !tbaa !9
  %50 = getelementptr inbounds ptr, ptr %49, i64 6
  %51 = load ptr, ptr %50, align 8
  %52 = tail call noundef signext i8 %51(ptr noundef nonnull align 8 dereferenceable(570) %38, i8 noundef signext 10)
  br label %53

53:                                               ; preds = %48, %45
  %54 = phi i8 [ %47, %45 ], [ %52, %48 ]
  %55 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8) %32, i8 noundef signext %54)
  %56 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8) %55)
  %57 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr noundef nonnull @.str.2, i64 noundef 8)
  %58 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo9_M_insertIdEERSoT_(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, double noundef %4)
  %59 = load ptr, ptr %58, align 8, !tbaa !9
  %60 = getelementptr i8, ptr %59, i64 -24
  %61 = load i64, ptr %60, align 8
  %62 = getelementptr inbounds i8, ptr %58, i64 %61
  %63 = getelementptr inbounds %"class.std::basic_ios", ptr %62, i64 0, i32 5
  %64 = load ptr, ptr %63, align 8, !tbaa !11
  %65 = icmp eq ptr %64, null
  br i1 %65, label %66, label %67

66:                                               ; preds = %53
  tail call void @_ZSt16__throw_bad_castv() #10
  unreachable

67:                                               ; preds = %53
  %68 = getelementptr inbounds %"class.std::ctype", ptr %64, i64 0, i32 8
  %69 = load i8, ptr %68, align 8, !tbaa !21
  %70 = icmp eq i8 %69, 0
  br i1 %70, label %74, label %71

71:                                               ; preds = %67
  %72 = getelementptr inbounds %"class.std::ctype", ptr %64, i64 0, i32 9, i64 10
  %73 = load i8, ptr %72, align 1, !tbaa !24
  br label %79

74:                                               ; preds = %67
  tail call void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570) %64)
  %75 = load ptr, ptr %64, align 8, !tbaa !9
  %76 = getelementptr inbounds ptr, ptr %75, i64 6
  %77 = load ptr, ptr %76, align 8
  %78 = tail call noundef signext i8 %77(ptr noundef nonnull align 8 dereferenceable(570) %64, i8 noundef signext 10)
  br label %79

79:                                               ; preds = %74, %71
  %80 = phi i8 [ %73, %71 ], [ %78, %74 ]
  %81 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8) %58, i8 noundef signext %80)
  %82 = tail call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8) %81)
  ret i32 0
}

declare { double, double } @_Z17__enzyme_autodiffI7double2JididEET_PvDpT0_(ptr noundef, i32 noundef, double noundef, i32 noundef, double noundef) local_unnamed_addr #0

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(ptr noundef nonnull align 8 dereferenceable(8), ptr noundef, i64 noundef) local_unnamed_addr #0

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo9_M_insertIdEERSoT_(ptr noundef nonnull align 8 dereferenceable(8), double noundef) local_unnamed_addr #0

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8), i8 noundef signext) local_unnamed_addr #0

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8)) local_unnamed_addr #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() local_unnamed_addr #7

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570)) local_unnamed_addr #0

; Function Attrs: uwtable
define internal void @_GLOBAL__sub_I_test_Enzyme_complex.cpp() #8 section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(ptr noundef nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(ptr nonnull @_ZNSt8ios_base4InitD1Ev, ptr nonnull @_ZStL8__ioinit, ptr nonnull @__dso_handle) #9
  ret void
}

; Function Attrs: mustprogress nofree nounwind willreturn writeonly uwtable
define internal { double, double } @diffe_Z4funcdd(double noundef %0, double noundef %1, double %differeturn) #3 {
  %"'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de", align 8
  %"'de1" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de1", align 8
  %"'de2" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de2", align 8
  %"'de3" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de3", align 8
  %"'de4" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de4", align 8
  %"'de5" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de5", align 8
  %"'de6" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de6", align 8
  %"'de7" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de7", align 8
  %"'de8" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de8", align 8
  %"'de9" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de9", align 8
  %"'de10" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de10", align 8
  %3 = tail call double @sin(double noundef %1) #11
  %4 = fmul double %3, %0
  %5 = tail call double @cos(double noundef %0) #11
  %6 = fmul double %4, %5
  %7 = tail call double @sin(double noundef %1) #11
  %8 = tail call double @cos(double noundef %0) #11
  %9 = fmul double %8, %1
  %10 = tail call double @llvm.fmuladd.f64(double %0, double %7, double %9) #12
  br label %invert

invert:                                           ; preds = %2
  store double %differeturn, ptr %"'de", align 8
  %11 = load double, ptr %"'de", align 8
  store double 0.000000e+00, ptr %"'de", align 8
  %12 = fmul fast double %11, %10
  %13 = load double, ptr %"'de1", align 8
  %14 = fadd fast double %13, %12
  store double %14, ptr %"'de1", align 8
  %15 = fmul fast double %11, %6
  %16 = load double, ptr %"'de2", align 8
  %17 = fadd fast double %16, %15
  store double %17, ptr %"'de2", align 8
  %18 = load double, ptr %"'de2", align 8
  store double 0.000000e+00, ptr %"'de2", align 8
  %19 = fmul fast double %18, %7
  %20 = load double, ptr %"'de3", align 8
  %21 = fadd fast double %20, %19
  store double %21, ptr %"'de3", align 8
  %22 = fmul fast double %18, %0
  %23 = load double, ptr %"'de4", align 8
  %24 = fadd fast double %23, %22
  store double %24, ptr %"'de4", align 8
  %25 = load double, ptr %"'de5", align 8
  %26 = fadd fast double %25, %18
  store double %26, ptr %"'de5", align 8
  %27 = load double, ptr %"'de5", align 8
  store double 0.000000e+00, ptr %"'de5", align 8
  %28 = fmul fast double %27, %1
  %29 = load double, ptr %"'de6", align 8
  %30 = fadd fast double %29, %28
  store double %30, ptr %"'de6", align 8
  %31 = fmul fast double %27, %8
  %32 = load double, ptr %"'de7", align 8
  %33 = fadd fast double %32, %31
  store double %33, ptr %"'de7", align 8
  %34 = load double, ptr %"'de6", align 8
  store double 0.000000e+00, ptr %"'de6", align 8
  %35 = call fast double @llvm.sin.f64(double %0)
  %36 = fneg fast double %35
  %37 = fmul fast double %34, %36
  %38 = load double, ptr %"'de3", align 8
  %39 = fadd fast double %38, %37
  store double %39, ptr %"'de3", align 8
  %40 = load double, ptr %"'de4", align 8
  store double 0.000000e+00, ptr %"'de4", align 8
  %41 = call fast double @llvm.cos.f64(double %1)
  %42 = fmul fast double %40, %41
  %43 = load double, ptr %"'de7", align 8
  %44 = fadd fast double %43, %42
  store double %44, ptr %"'de7", align 8
  %45 = load double, ptr %"'de1", align 8
  store double 0.000000e+00, ptr %"'de1", align 8
  %46 = fmul fast double %45, %5
  %47 = load double, ptr %"'de8", align 8
  %48 = fadd fast double %47, %46
  store double %48, ptr %"'de8", align 8
  %49 = fmul fast double %45, %4
  %50 = load double, ptr %"'de9", align 8
  %51 = fadd fast double %50, %49
  store double %51, ptr %"'de9", align 8
  %52 = load double, ptr %"'de9", align 8
  store double 0.000000e+00, ptr %"'de9", align 8
  %53 = call fast double @llvm.sin.f64(double %0)
  %54 = fneg fast double %53
  %55 = fmul fast double %52, %54
  %56 = load double, ptr %"'de3", align 8
  %57 = fadd fast double %56, %55
  store double %57, ptr %"'de3", align 8
  %58 = load double, ptr %"'de8", align 8
  store double 0.000000e+00, ptr %"'de8", align 8
  %59 = fmul fast double %58, %0
  %60 = load double, ptr %"'de10", align 8
  %61 = fadd fast double %60, %59
  store double %61, ptr %"'de10", align 8
  %62 = fmul fast double %58, %3
  %63 = load double, ptr %"'de3", align 8
  %64 = fadd fast double %63, %62
  store double %64, ptr %"'de3", align 8
  %65 = load double, ptr %"'de10", align 8
  store double 0.000000e+00, ptr %"'de10", align 8
  %66 = call fast double @llvm.cos.f64(double %1)
  %67 = fmul fast double %65, %66
  %68 = load double, ptr %"'de7", align 8
  %69 = fadd fast double %68, %67
  store double %69, ptr %"'de7", align 8
  %70 = load double, ptr %"'de3", align 8
  %71 = load double, ptr %"'de7", align 8
  %72 = insertvalue { double, double } undef, double %70, 0
  %73 = insertvalue { double, double } %72, double %71, 1
  ret { double, double } %73
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.sin.f64(double) #5

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.cos.f64(double) #5

attributes #0 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind }
attributes #3 = { mustprogress nofree nounwind willreturn writeonly uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree nounwind willreturn writeonly "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #6 = { mustprogress norecurse uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { noreturn "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { nounwind }
attributes #10 = { noreturn }
attributes #11 = { mustprogress nounwind willreturn }
attributes #12 = { mustprogress willreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 15.0.7"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"vtable pointer", !8, i64 0}
!11 = !{!12, !17, i64 240}
!12 = !{!"_ZTSSt9basic_iosIcSt11char_traitsIcEE", !13, i64 0, !17, i64 216, !7, i64 224, !20, i64 225, !17, i64 232, !17, i64 240, !17, i64 248, !17, i64 256}
!13 = !{!"_ZTSSt8ios_base", !14, i64 8, !14, i64 16, !15, i64 24, !16, i64 28, !16, i64 32, !17, i64 40, !18, i64 48, !7, i64 64, !6, i64 192, !17, i64 200, !19, i64 208}
!14 = !{!"long", !7, i64 0}
!15 = !{!"_ZTSSt13_Ios_Fmtflags", !7, i64 0}
!16 = !{!"_ZTSSt12_Ios_Iostate", !7, i64 0}
!17 = !{!"any pointer", !7, i64 0}
!18 = !{!"_ZTSNSt8ios_base6_WordsE", !17, i64 0, !14, i64 8}
!19 = !{!"_ZTSSt6locale", !17, i64 0}
!20 = !{!"bool", !7, i64 0}
!21 = !{!22, !7, i64 56}
!22 = !{!"_ZTSSt5ctypeIcE", !23, i64 0, !17, i64 16, !20, i64 24, !17, i64 32, !17, i64 40, !17, i64 48, !7, i64 56, !7, i64 57, !7, i64 313, !7, i64 569}
!23 = !{!"_ZTSNSt6locale5facetE", !6, i64 8}
!24 = !{!7, !7, i64 0}
