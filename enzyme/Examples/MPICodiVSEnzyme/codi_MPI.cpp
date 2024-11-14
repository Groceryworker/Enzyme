#include <mpi.h>
#include <codi.hpp>
#include <medi/medi.hpp>
#include <iostream>
using namespace medi;
#include <codi/tools/mpi/codiMpiTypes.hpp>

using Real = codi::RealReverse; // Reverse mode automatic differentiation
using MpiTypes = codi::CoDiMpiTypes<Real>;
MpiTypes* mpiTypes;

// Function to compute x^2, y^3, or z^4 (depending on the rank)
Real compute_x(const Real& x) {
    return x * x;  // x^2
}

Real compute_y(const Real& y) {
    return y * y * y;  // y^3
}

Real compute_z(const Real& z) {
    return z * z * z * z;  // z^4
}

int main(int nargs, char** args) {
    AMPI_Init(&nargs, &args);  // Initialize MeDi MPI

    int rank, size;
    AMPI_Comm_rank(AMPI_COMM_WORLD, &rank);
    AMPI_Comm_size(AMPI_COMM_WORLD, &size);

    if (size != 3) {
        if (rank == 0) {
            std::cout << "Please start the program with three processes." << std::endl;
        }
        AMPI_Finalize();
        return 0;
    }

    // Tape initialization: Create and activate tape for reverse-mode differentiation
    typename Real::Tape& tape = Real::getTape();
    tape.setActive(); // Activate the tape to track operations

    Real x, y, z, result;

    // Initialize variables x, y, and z with some values for each rank
    if (rank == 0) {
        x = 2.0;
        x.setGradient(1.0);  // Set the gradient (tangent) for x
    } else if (rank == 1) {
        y = 3.0;
        y.setGradient(1.0);  // Set the gradient for y
    } else if (rank == 2) {
        z = 4.0;
        z.setGradient(1.0);  // Set the gradient for z
    }

    // Perform computations locally on each rank (independently)
    if (rank == 0) {
        result = compute_x(x);
        // Register the output on the tape
        tape.registerOutput(result);
        // Set the gradient (adjoint) for result (arbitrary set for testing)
        result.setGradient(100.0);  // This acts as the adjoint seed for reverse-mode
    } else if (rank == 1) {
        result = compute_y(y);
        tape.registerOutput(result);
        result.setGradient(100.0);  // Reverse-mode adjoint seed for y^3
    } else if (rank == 2) {
        result = compute_z(z);
        tape.registerOutput(result);
        result.setGradient(100.0);  // Reverse-mode adjoint seed for z^4
    }

    // Deactivate the tape after computations
    tape.setPassive();

    // Gather results back to rank 0
    Real final_result;
    AMPI_Gather(&result, 1, mpiTypes->MPI_TYPE, &final_result, 1, mpiTypes->MPI_TYPE, 0, AMPI_COMM_WORLD);

    // Rank 0 prints the results
    if (rank == 0) {
        Real x_grad, y_grad, z_grad;
        AMPI_Gather(x.getGradient(), 1, mpiTypes->MPI_TYPE, x_grad, 1, mpiTypes->MPI_TYPE, 0, AMPI_COMM_WORLD);
        AMPI_Gather(y.getGradient(), 1, mpiTypes->MPI_TYPE, y_grad, 1, mpiTypes->MPI_TYPE, 0, AMPI_COMM_WORLD);
        AMPI_Gather(z.getGradient(), 1, mpiTypes->MPI_TYPE, z_grad, 1, mpiTypes->MPI_TYPE, 0, AMPI_COMM_WORLD);

        // Combine the results
        final_result = compute_x(x) + compute_y(y) + compute_z(z);
        
        std::cout << "Final result (f(x, y, z)): " << final_result << std::endl;
        std::cout << "Gradient of x: " << x_grad << std::endl;
        std::cout << "Gradient of y: " << y_grad << std::endl;
        std::cout << "Gradient of z: " << z_grad << std::endl;
    }

    AMPI_Finalize();  // Finalize MeDi MPI
    return 0;
}
