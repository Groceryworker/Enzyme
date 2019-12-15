; RUN: %opt < %s %loadEnzyme -enzyme -enzyme_preopt=false -mem2reg -sroa -simplifycfg -instcombine -adce -instsimplify -S | %FileCheck %s

declare dso_local double @__enzyme_autodiff(i8*, double)

define double @caller(double %in) {
entry:
  %call = call double @__enzyme_autodiff(i8* bitcast (double (double)* @foobard to i8*), double %in)
  ret double %call
}

define double @foobard(double %init) {
entry:
  %res = call double @subfn(double %init, void (double*, double*, double)* nonnull @indirect)
  ret double %res
}

define double @subfn(double %init, void (double*, double*, double)* %system) {
entry:
  ret double %init
}

define void @indirect(double* %x, double* %dxdt, double %t) {
entry:
  %a1 = load double, double* %x, align 8
  %call1 = call double* @bad(double* %dxdt)
  store double %a1, double* %call1, align 8
  ret void
}

define double* @bad(double* %this) {
entry:
  ret double* %this
}

; CHECK: define internal { double } @diffefoobard(double %init, double %differeturn) {
; CHECK-NEXT: entry:
; CHECK-NEXT:   %0 = call { double } @diffesubfn(double %init, void (double*, double*, double)* nonnull @indirect, void (double*, double*, double)* bitcast ({ double } (double*, double*, double*, double*, double)* @diffeindirect to void (double*, double*, double)*), double %differeturn)
; CHECK-NEXT:   ret { double } %0
; CHECK-NEXT: }

; CHECK: define internal { double } @diffeindirect(double* %x, double* %"x'", double* %dxdt, double* %"dxdt'", double %t) {
; CHECK-NEXT: entry:
; CHECK-NEXT:   %a1 = load double, double* %x, align 8
; CHECK-NEXT:   %call1_augmented = call { {}, double*, double* } @augmented_bad(double* %dxdt, double* %"dxdt'")
; CHECK-NEXT:   %0 = extractvalue { {}, double*, double* } %call1_augmented, 2
; CHECK-NEXT:   %1 = extractvalue { {}, double*, double* } %call1_augmented, 1
; CHECK-NEXT:   store double %a1, double* %1, align 8
; CHECK-NEXT:   %2 = load double, double* %0
; CHECK-NEXT:   store double 0.000000e+00, double* %0, align 8
; CHECK-NEXT:   %3 = call {} @diffebad(double* %dxdt, double* %"dxdt'", {} undef)
; CHECK-NEXT:   %4 = load double, double* %"x'"
; CHECK-NEXT:   %5 = fadd fast double %4, %2
; CHECK-NEXT:   store double %5, double* %"x'"
; CHECK-NEXT:   ret { double } zeroinitializer
; CHECK-NEXT: }

; CHECK: define internal { {}, double*, double* } @augmented_bad(double* %this, double* %"this'") {
; CHECK-NEXT: entry:
; CHECK-NEXT:   %.fca.1.insert = insertvalue { {}, double*, double* } undef, double* %this, 1
; CHECK-NEXT:   %.fca.2.insert = insertvalue { {}, double*, double* } %.fca.1.insert, double* %"this'", 2
; CHECK-NEXT:   ret { {}, double*, double* } %.fca.2.insert
; CHECK-NEXT: }

; CHECK: define internal {} @diffebad(double* %this, double* %"this'", {} %tapeArg) {
; CHECK-NEXT: entry:
; CHECK-NEXT:   ret {} undef
; CHECK-NEXT: }

; CHECK: define internal { double } @diffesubfn(double %init, void (double*, double*, double)* %system, void (double*, double*, double)* %"system'", double %differeturn) {
; CHECK-NEXT: entry:
; CHECK-NEXT:   %0 = insertvalue { double } undef, double %differeturn, 0
; CHECK-NEXT:   ret { double } %0
; CHECK-NEXT: }