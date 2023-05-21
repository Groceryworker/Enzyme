; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --include-generated-funcs
; RUN: if [ %llvmver -lt 16 ]; then %opt < %s %loadEnzyme -enzyme -enzyme-preopt=false -mem2reg -instsimplify -S | FileCheck %s; fi
; RUN: %opt < %s %newLoadEnzyme -passes="enzyme,function(mem2reg,instsimplify)" -enzyme-preopt=false -S | FileCheck %s

%struct.Gradients = type { double, double, double }

; Function Attrs: noinline norecurse nounwind uwtable
define dso_local double @f(double* noalias nocapture %out, double %x) #0 {
entry:
  store double %x, double* %out, align 8
  store double 0.000000e+00, double* %out, align 8
  %res = load double, double* %out
  ret double %res
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.Gradients @dsumsquare(double* %x, double* %xp1, double* %xp2, double* %xp3, double %inp, double %in1, double %in2, double %in3) local_unnamed_addr #1 {
entry:
  %call = tail call %struct.Gradients (i8*, ...) @__enzyme_fwddiff(i8* bitcast (double (double*, double)* @f to i8*), metadata !"enzyme_width", i64 3, double* %x, double* %xp1, double* %xp2, double* %xp3, double %inp, double %in1, double %in2, double %in3)
  ret %struct.Gradients %call
}

declare dso_local %struct.Gradients @__enzyme_fwddiff(i8*, ...) local_unnamed_addr

attributes #0 = { noinline norecurse nounwind uwtable }
attributes #1 = { noinline nounwind uwtable }

; CHECK: define {{[^@]+}}@fwddiffe3f(double* noalias nocapture %out, [3 x double*] %"out'", double %x, [3 x double] %"x'")
; CHECK-NEXT:  entry:
; CHECK-NEXT:   store double %x, double* %out, align 8
; CHECK-NEXT:   %0 = extractvalue [3 x double*] %"out'", 0
; CHECK-NEXT:   %1 = extractvalue [3 x double] %"x'", 0
; CHECK-NEXT:   store double %1, double* %0, align 8
; CHECK-NEXT:   %2 = extractvalue [3 x double*] %"out'", 1
; CHECK-NEXT:   %3 = extractvalue [3 x double] %"x'", 1
; CHECK-NEXT:   store double %3, double* %2, align 8
; CHECK-NEXT:   %4 = extractvalue [3 x double*] %"out'", 2
; CHECK-NEXT:   %5 = extractvalue [3 x double] %"x'", 2
; CHECK-NEXT:   store double %5, double* %4, align 8
; CHECK-NEXT:   store double 0.000000e+00, double* %out, align 8
; CHECK-NEXT:   %6 = extractvalue [3 x double*] %"out'", 0
; CHECK-NEXT:   store double 0.000000e+00, double* %6, align 8
; CHECK-NEXT:   %7 = extractvalue [3 x double*] %"out'", 1
; CHECK-NEXT:   store double 0.000000e+00, double* %7, align 8
; CHECK-NEXT:   %8 = extractvalue [3 x double*] %"out'", 2
; CHECK-NEXT:   store double 0.000000e+00, double* %8, align 8
; CHECK-NEXT:   %9 = extractvalue [3 x double*] %"out'", 0
; CHECK-NEXT:   %"res'ipl" = load double, double* %9
; CHECK-NEXT:   %10 = insertvalue [3 x double] undef, double %"res'ipl", 0
; CHECK-NEXT:   %11 = extractvalue [3 x double*] %"out'", 1
; CHECK-NEXT:   %"res'ipl1" = load double, double* %11
; CHECK-NEXT:   %12 = insertvalue [3 x double] %10, double %"res'ipl1", 1
; CHECK-NEXT:   %13 = extractvalue [3 x double*] %"out'", 2
; CHECK-NEXT:   %"res'ipl2" = load double, double* %13
; CHECK-NEXT:   %14 = insertvalue [3 x double] %12, double %"res'ipl2", 2
; CHECK-NEXT:   ret [3 x double] %14
;
