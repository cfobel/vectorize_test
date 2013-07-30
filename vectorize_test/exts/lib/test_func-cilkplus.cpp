// filename: test_cilkplus.cpp
// compile: g++ test_cilkplus.cpp -lcilkrts

#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include <cilk/cilk.h>


extern "C" {


void sqrt_test_1d(size_t size, float a[size], float b[size]) {
    b[:] = sqrtf(a[:]);
}


void sqrt_test_2d(size_t size[2], float a[size[0]][size[1]], float b[size[0]][size[1]]) {
    b[:][:] = sqrtf(a[:][:]);
}


void sqrt_test_3d(size_t size[3], float a[size[0]][size[1]][size[2]],
                 float b[size[0]][size[1]][size[2]]) {
    b[:][:][:] = sqrtf(a[:][:][:]);
}


void star_plus_from_elements_single_k(size_t net_count, int net_block_count,
                                      float net_elements[2][2][net_count],
                                      float out[2][net_count],
                                      float beta) {
    /*
    Compute Star+ cost for each net, given the:
        -sum of all x/y/...-coordinates
        -sum of all x/y/...-coordinates squared
    of all blocks connected to each net.
    */
    out[:][:] = sqrtf(net_elements[:][1][:] - (net_elements[:][0][:] *
                                               net_elements[:][0][:]) /
                      net_block_count + beta);
}

}
/*
#
notes: you can use 'export CILK_NWORKERS=N' to set the max workders of cilk plus runtime.
*/
