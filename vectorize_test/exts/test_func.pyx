from numpy cimport ndarray
import numpy as np

cdef extern:
    void sqrt_test(float *a, float *b, size_t size)
    void sqrt_test_a(size_t size, float *a, float *b)
    void f_sqrt_test(float *a, float *b, size_t size)


def py_c_sqrt_test(float [:] a, float [:] b):
    cdef size_t N = a.shape[0]
    sqrt_test(&a[0], &b[0], N)


def py_c_sqrt_test_sized(float [:] a, float [:] b):
    cdef size_t N = a.shape[0]
    sqrt_test_a(N, &a[0], &b[0])


def py_f_sqrt_test(float [:] a, float [:] b):
    cdef size_t N = a.shape[0]
    f_sqrt_test(&a[0], &b[0], N)
