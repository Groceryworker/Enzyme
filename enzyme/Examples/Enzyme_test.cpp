#include <iostream>  // Required for std::cout

int enzyme_dup;
int enzyme_dupnoneed;
int enzyme_out;
int enzyme_const;

template < typename return_type, typename ... T >
return_type __enzyme_fwddiff(void*, T ... );

template < typename return_type, typename ... T >
return_type __enzyme_autodiff(void*, T ... );

//double f(double x) { return x * x; }
double f(double x, double y) { return x * y + 1.0 / y; }

struct double2{ double x,y;};

int main() {
    //################Simple Example 1
    // double x = 5.0;
    // double dx = 1.0;

    // // Compute forward-mode derivative of f
    // double df_dx = __enzyme_fwddiff<double>((void*)f, enzyme_dup, x, dx); 

    // // Correct usage of std::cout
    // std::cout << "f(x) = " << f(x) << ", f'(x) = " << df_dx << std::endl;

    //return 0;

    //################Simple Example 2
    // double x = 3.0;
    // double y = 2.0;
    // double dx = 1.0;
    // double dy = 1.0;
    // double df = __enzyme_fwddiff<double>((void*)f, enzyme_dup, x, dx, enzyme_dup, y, dy); 
    // std::cout << "f(x,y) = " << f(x,y) << " dff = " << df << std::endl;

    // // double dfdx = __enzyme_fwddiff<double>((void*)f, enzyme_dup, x, 1.0, enzyme_dup, y, 0.0); 
    // // double dfdy = __enzyme_fwddiff<double>((void*)f, enzyme_dup, x, 0.0, enzyme_dup, y, 1.0); 
    // // std::cout << "dfdx = " << dfdx << " dfdy = " << dfdy << std::endl;

    // double dfdx = __enzyme_fwddiff<double>((void*)f, enzyme_dup, x, 1.0, enzyme_const, y); 
    // double dfdy = __enzyme_fwddiff<double>((void*)f, enzyme_const, x, enzyme_dup, y, 1.0); 
    // std::cout << "dfdxx = " << dfdx << " dfdyy = " << dfdy << std::endl;
    // std::cout << enzyme_const << std::endl;

    //################Simple Example 3
    std::cout << enzyme_out << std::endl;
    double x = 3.0;
    double y = 2.0;
    auto [mu_x, mu_y] = __enzyme_autodiff<double2>((void*)f, enzyme_out, x, enzyme_out, y); 
    std::cout << "mu_x = " << mu_x << " mu_y = "<< mu_y << std::endl;

}
