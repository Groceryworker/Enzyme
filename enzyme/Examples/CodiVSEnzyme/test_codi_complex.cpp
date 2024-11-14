#include <iostream>
#include <codi.hpp>

using Real = codi::RealReverse;
using Tape = typename Real::Tape;

Real func(const Real& x, const Real& y){
    return (x * std::sin(y) * std::cos(x)) * (x * std::sin(y) + y * std::cos(x));
}


int main(int nargs, char** args) {
    
    Real x = 2.0;
    Real y = 3.0;
    
    Tape& tape = Real::getTape();
    tape.setActive();
    // Register variables on the tape
    tape.registerInput(x);
    tape.registerInput(y);

    // Compute the function
    codi::RealReverse f = func(x, y);

    // Register the output variable
    tape.registerOutput(f);

    // Compute gradients (start reverse-mode differentiation)
    f.setGradient(1.0); // Seed the output gradient with 1.0
    tape.evaluate();

    // Retrieve gradients
    double dfdx = x.getGradient();  // df/dx
    double dfdy = y.getGradient();  // df/dy

    // Print results
    std::cout << "f(x, y) = " << f.getValue() << std::endl;
    std::cout << "df/dx = " << dfdx << std::endl;
    std::cout << "df/dy = " << dfdy << std::endl;

    // Clear the tape after use
    tape.reset();

    return 0;
}
