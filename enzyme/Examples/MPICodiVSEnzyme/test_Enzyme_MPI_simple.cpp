#include <mpi.h>
#include <iostream>

int enzyme_out;
int enzyme_const;
int enzyme_dup;

template < typename return_type, typename ... T >
return_type __enzyme_autodiff(void*, T ... );

// Enzyme requires a `__enzyme_autodiff` decorated function.
// Define a wrapper function for the Enzyme AD function to differentiate.

double compute(double a) {
    return a * 2.0;  // Simple operation to differentiate
}

int main(int nargs, char** args) {
    MPI_Init(&nargs, &args);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (size != 2) {
        if (rank == 0) {
            std::cout << "Please start the tutorial with two processes." << std::endl;
        }
    } else {
        double a = 3.0;
        double adjoint_a = 0.0; // Storage for adjoint of `a`

        if (rank == 0) {
            MPI_Send(&a, 1, MPI_DOUBLE, 1, 42, MPI_COMM_WORLD);
        } else if (rank == 1) {
            MPI_Recv(&a, 1, MPI_DOUBLE, 0, 42, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

            // Enzyme autodiff of `compute` with respect to `a`
            adjoint_a = __enzyme_autodiff<double>((void*)compute, enzyme_dup, a, adjoint_a);
        }

        // Print out adjoint result in rank 1
        if (rank == 1) {
            std::cout << "Adjoint of 'a' on rank 1 is: " << adjoint_a << std::endl;
        }
    }

    MPI_Finalize();
    return 0;
}