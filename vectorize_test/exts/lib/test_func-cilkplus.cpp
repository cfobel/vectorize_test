// filename: test_cilkplus.cpp
// compile: g++ test_cilkplus.cpp -lcilkrts

#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include <cilk/cilk.h>

extern "C" {

void float_test(float *a, float *b, size_t size) {
    a[0:size] = 2 * a[0:size] / b[0:size];
}


void sqrt_test(float *a, float *b, size_t size) {
    b[0:size] = sqrtf(a[0:size]);
}


void sqrt_test_a(size_t size, float a[size], float b[size]) {
    b[:] = sqrtf(a[:]);
}


#if 0
void compute_star_plus_from_elements(
        unsigned int *cardinality,
        float *sums,
        float *squared_sums,
        float *output
        size_t *shape) {
    /*
    Compute Star+ cost for each net, given the:
        -sum of all x/y/...-coordinates
        -sum of all x/y/...-coordinates squared
    of all blocks connected to each net.
    */
    //output[0:shape[0], 0:shape[1], 0:shape[2]] =
     //   sqrtf()

        //(np.sqrt(net_elements[:, 1, :] - (net_elements[:, 0, :] *
                                             //net_elements[:, 0, :]) /

    //output[]
        //(np.sqrt(net_elements[:, 1, :] - (net_elements[:, 0, :] *
                                             //net_elements[:, 0, :]) /
                    //cardinality + beta))
}
#endif

}
/*
#
notes: you can use 'export CILK_NWORKERS=N' to set the max workders of cilk plus runtime.
*/
