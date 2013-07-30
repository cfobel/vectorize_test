from numpy cimport ndarray
import numpy as np

cdef extern:
    void sqrt_test(float *a, float *b, size_t size)

def py_sqrt_test(float [:] a, float [:] b):
    cdef size_t N = a.shape[0]
    sqrt_test(&a[0], &b[0], N)
