cimport cython
from numpy cimport ndarray
import numpy as np


cdef extern:
    void sqrt_test_1d(size_t size, float *a, float *b)
    void sqrt_test_2d(size_t size[2], float *a, float *b)
    void sqrt_test_3d(size_t size[3], float *a, float *b)
    void f_sqrt_test_1d(float *a, float *b, size_t size)
    void f_sqrt_test_2d(float *a, float *b, size_t M, size_t N)
    void f_sqrt_test_3d(float *a, float *b, size_t K, size_t M, size_t N)


ctypedef fused nd_view:
    float[:]
    float[:, :]
    float[:, :, :]


def py_c_sqrt_test_3d(float [:, :, :] a, float [:, :, :] b):
    cdef size_t[3] N
    N[0] = a.shape[0]
    N[1] = a.shape[1]
    N[2] = a.shape[2]
    sqrt_test_3d(N, &a[0, 0, 0], &b[0, 0, 0])


def py_c_sqrt_test_2d(float [:, :] a, float [:, :] b):
    cdef size_t[2] N
    N[0] = a.shape[0]
    N[1] = a.shape[1]
    sqrt_test_2d(N, &a[0, 0], &b[0, 0])


def py_c_sqrt_test_1d(float [:] a, float [:] b):
    cdef size_t N = a.shape[0]
    sqrt_test_1d(N, &a[0], &b[0])


def py_f_sqrt_test_3d(float [:, :, :] a, float [:, :, :] b):
    cdef size_t K = a.shape[0]
    cdef size_t M = a.shape[1]
    cdef size_t N = a.shape[2]
    f_sqrt_test_3d(&a[0, 0, 0], &b[0, 0, 0], K, M, N)


def py_f_sqrt_test_2d(float [:, :] a, float [:, :] b):
    cdef size_t M = a.shape[0]
    cdef size_t N = a.shape[1]
    f_sqrt_test_2d(&a[0, 0], &b[0, 0], M, N)


def py_f_sqrt_test_1d(float [:] a, float [:] b):
    cdef size_t N = a.shape[0]
    f_sqrt_test_1d(&a[0], &b[0], N)
