// filename: test_cilkplus.cpp
// compile: g++ test_cilkplus.cpp -lcilkrts

#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include <cilk/cilk.h>
#include <cilk/reducer_opadd.h>
#include <cilk/reducer_list.h>


void c_star_plus_from_elements_single_k(size_t net_count, int net_block_count,
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


float c_star_plus_from_elements_single_k_total(
                                      size_t net_count, int net_block_count,
                                      float net_elements[2][2][net_count],
                                      float out[2][net_count],
                                      float beta) {
    c_star_plus_from_elements_single_k(net_count, net_block_count, net_elements,
                                      out, beta);
    float total_cost = __sec_reduce_add(out[:][:]);
    return total_cost;
}


float c_star_plus_from_elements_single_k_total_serial(
                                      size_t net_count, int net_block_count,
                                      float net_elements[2][2][net_count],
                                      float out[2][net_count],
                                      float beta) {
    c_star_plus_from_elements_single_k(net_count, net_block_count, net_elements,
                                      out, beta);
    float total_cost = 0;
    for(int i = 0; i < 2; i++) {
        for(int k = 0; k < net_count; k++) {
            total_cost += out[i][k];
        }
    }
    return total_cost;
}


float c_where_2d_lt(size_t shape[2], float *data, float value) {
    cilk::reducer_list_append<int> match_reducer;
    // Build the list in parallel
    cilk_for(int i = 0; i < (shape[0] * shape[1]); i++) {
        if(data[i] < value) {
            match_reducer.push_back(i);
        }
    }
    // Fetch the result of the reducer as a standard STL list
    const std::list<int> &matches = match_reducer.get_value();
    return matches.size();
    //return total_cost;
}


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
    c_star_plus_from_elements_single_k(net_count, net_block_count, net_elements,
                                      out, beta);
}


float star_plus_from_elements_single_k_total(
                                      size_t net_count, int net_block_count,
                                      float net_elements[2][2][net_count],
                                      float out[2][net_count],
                                      float beta) {
    return c_star_plus_from_elements_single_k_total(net_count, net_block_count,
                                                   net_elements, out, beta);
}

float star_plus_from_elements_single_k_total_serial(
                                      size_t net_count, int net_block_count,
                                      float net_elements[2][2][net_count],
                                      float out[2][net_count],
                                      float beta) {
    return c_star_plus_from_elements_single_k_total_serial(net_count, net_block_count,
                                                   net_elements, out, beta);
}

float where_2d_lt(size_t shape[2], float *data, float value) {
    return c_where_2d_lt(shape, data, value);
}

}
/*
#
notes: you can use 'export CILK_NWORKERS=N' to set the max workders of cilk plus runtime.
*/
