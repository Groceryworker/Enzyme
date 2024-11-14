// test.cpp
#include <iostream>
extern "C" double __enzyme_autodiff(void*, double);

double square(double x) {
    return x * x;
}

double dsquare(double x) {
    // This returns the derivative of square or 2 * x
    return __enzyme_autodiff((void*) square, x);
}

int main() {
    for (double i = 1; i < 5; i++) {
        std::cout << "square(" << i << ")=" << square(i)
                  << ", dsquare(" << i << ")=" << dsquare(i) << std::endl;
    }
    return 0;
}

