#include <iostream>
#include <cmath>

int enzyme_out;
int enzyme_const;
int enzyme_dup;


template < typename return_type, typename ... T >
return_type __enzyme_fwddiff(void*, T ... );

template < typename return_type, typename ... T >
return_type __enzyme_autodiff(void*, T ... );

double func(double x, double y) {
    return (x * std::sin(y) * std::cos(x)) * (x * std::sin(y) + y * std::cos(x));
}

struct double2{ double x,y;};

int main() {
    double x = 2.0;
    double y = 3.0;

    // Initialize variables to store gradients
    double dfdx = 1.0;
    double dfdy = 1.0;

    // Compute function value
    double f = func(x, y);

    // Compute gradients using Enzyme
    auto [mu_x, mu_y] = __enzyme_autodiff<double2>((void*)func, enzyme_out, x, enzyme_out, y);

    // Print results
    std::cout << "f(x, y) = " << f << std::endl;
    std::cout << "df/dx = " << mu_x << std::endl;
    std::cout << "df/dy = " << mu_y << std::endl;

    return 0;
}
