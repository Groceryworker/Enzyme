; RUN: opt < %s %loadEnzyme -enzyme -enzyme_preopt=false -mem2reg -sroa -instsimplify -adce -correlated-propagation -simplifycfg -S | FileCheck %s

; Function Attrs: noinline norecurse nounwind uwtable
define dso_local zeroext i1 @metasubf(double* nocapture %x) local_unnamed_addr #0 {
entry:
  %arrayidx = getelementptr inbounds double, double* %x, i64 1
  store double 3.000000e+00, double* %arrayidx, align 8
  %0 = load double, double* %x, align 8
  %cmp = fcmp fast oeq double %0, 2.000000e+00
  ret i1 %cmp
}

; Function Attrs: noinline norecurse nounwind uwtable
define dso_local zeroext i1 @othermetasubf(double* nocapture %x) local_unnamed_addr #0 {
entry:
  %arrayidx = getelementptr inbounds double, double* %x, i64 1
  store double 4.000000e+00, double* %arrayidx, align 8
  %0 = load double, double* %x, align 8
  %cmp = fcmp fast oeq double %0, 3.000000e+00
  ret i1 %cmp
}

; Function Attrs: noinline norecurse nounwind uwtable
define dso_local zeroext i1 @subf(double* nocapture %x) local_unnamed_addr #0 {
entry:
  %0 = load double, double* %x, align 8
  %mul = fmul fast double %0, 2.000000e+00
  store double %mul, double* %x, align 8
  %call = tail call zeroext i1 @metasubf(double* %x)
  %call1 = tail call zeroext i1 @othermetasubf(double* %x)
  %res = and i1 %call, %call1
  ret i1 %res
}

; Function Attrs: noinline norecurse nounwind uwtable
define dso_local void @f(double* nocapture %x) #0 {
entry:
  %call = tail call zeroext i1 @subf(double* %x)
  store double 2.000000e+00, double* %x, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local double @dsumsquare(double* %x, double* %xp) local_unnamed_addr #1 {
entry:
  %call = tail call fast double @__enzyme_autodiff(i8* bitcast (void (double*)* @f to i8*), double* %x, double* %xp)
  ret double %call
}

declare dso_local double @__enzyme_autodiff(i8*, double*, double*) local_unnamed_addr

; CHECK: define internal {} @diffef(double* nocapture %x, double* %"x'")
; CHECK-NEXT: entry:
; CHECK-NEXT:   %0 = call { { {}, i1, {}, i1 } } @augmented_subf(double* %x, double* %"x'")
; CHECK-NEXT:   %1 = extractvalue { { {}, i1, {}, i1 } } %0, 0
; CHECK-NEXT:   store double 2.000000e+00, double* %x, align 8
; CHECK-NEXT:   store double 0.000000e+00, double* %"x'", align 8
; CHECK-NEXT:   %2 = call {} @diffesubf(double* nonnull %x, double* %"x'", { {}, i1, {}, i1 } %1)
; CHECK-NEXT:   ret {} undef
; CHECK-NEXT: }

; CHECK: define internal { {}, i1 } @augmented_othermetasubf(double* nocapture %x, double* %"x'") 

; CHECK: define internal { {}, i1 } @augmented_metasubf(double* nocapture %x, double* %"x'") 

; CHECK: define internal { { {}, i1, {}, i1 } } @augmented_subf(double* nocapture %x, double* %"x'") 
; CHECK-NEXT: entry:
; CHECK-NEXT:   %0 = load double, double* %x, align 8
; CHECK-NEXT:   %mul = fmul fast double %0, 2.000000e+00
; CHECK-NEXT:   store double %mul, double* %x, align 8
; CHECK-NEXT:   %1 = call { {}, i1 } @augmented_metasubf(double* %x, double* %"x'")
; CHECK-NEXT:   %2 = extractvalue { {}, i1 } %1, 1
; CHECK-NEXT:   %3 = call { {}, i1 } @augmented_othermetasubf(double* %x, double* %"x'")
; CHECK-NEXT:   %4 = extractvalue { {}, i1 } %3, 1
; CHECK-NEXT:   %[[iv1:.+]] = insertvalue { { {}, i1, {}, i1 } } undef, i1 %4, 0, 1
; CHECK-NEXT:   %[[iv2:.+]] = insertvalue { { {}, i1, {}, i1 } } %[[iv1]], i1 %2, 0, 3
; CHECK-NEXT:   ret { { {}, i1, {}, i1 } } %[[iv2]]
; CHECK-NEXT: }

; CHECK: define internal {} @diffesubf(double* nocapture %x, double* %"x'", { {}, i1, {}, i1 } %tapeArg)
; CHECK-NEXT: entry:
; CHECK-NEXT:   %0 = call {} @diffeothermetasubf(double* %x, double* %"x'", {} undef)
; CHECK-NEXT:   %1 = call {} @diffemetasubf(double* %x, double* %"x'", {} undef)
; CHECK-NEXT:   %2 = load double, double* %"x'"
; CHECK-NEXT:   store double 0.000000e+00, double* %"x'"
; CHECK-NEXT:   %m0diffe = fmul fast double %2, 2.000000e+00
; CHECK-NEXT:   %3 = load double, double* %"x'"
; CHECK-NEXT:   %4 = fadd fast double %3, %m0diffe
; CHECK-NEXT:   store double %4, double* %"x'"
; CHECK-NEXT:   ret {} undef
; CHECK-NEXT: }

; CHECK: define internal {} @diffemetasubf(double* nocapture %x, double* %"x'", {} %tapeArg) 
; CHECK-NEXT: entry:
; CHECK-NEXT:   %[[tostore:.+]] = getelementptr inbounds double, double* %"x'", i64 1
; CHECK-NEXT:   store double 0.000000e+00, double* %[[tostore]], align 8
; CHECK-NEXT:   ret {} undef
; CHECK-NEXT: }