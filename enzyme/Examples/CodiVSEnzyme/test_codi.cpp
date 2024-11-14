// test_codi.cpp
#include <iostream>
#include <codi.hpp>

using Real = codi::RealForward;

// Function to be differentiated
Real square(const Real& x) {
    return x * x;
}

int main() {
    for (double i = 1; i < 5; i++) {
        Real x = i;             // Initialize x with the current loop value
        x.setGradient(1.0);      // Set the gradient of x to 1 for forward mode

        Real y = square(x);      // Compute y = square(x), which also calculates dy/dx

        std::cout << "square(" << i << ") = " << y.getValue()
                  << ", dsquare(" << i << ") = " << y.getGradient() << std::endl;
    }
    return 0;
}
