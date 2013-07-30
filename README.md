vectorize_test
==============

Test project demonstrating vectorization using CilkPlus and Fortran.


# CilkPlus example #

This example shows the use of C++ code using Intel's CilkPlus Array Notation to
calculate the square-root of an array of `float` values.  Note that CilkPlus
Array Notation is currently only supported by Intel's compiler, `icc`.
However, Cilk Plus Array Notation has been accepted into GCC mainline for the
next release (as of July 30, 2013):

    http://software.intel.com/en-us/articles/cilk-plus-array-notation-for-c-accepted-into-gcc-mainline

To compile, install the Intel compiler and run the following command from
within `vectorize_test/exts/lib`:

    icc -o libtest_func_cilk.so -c -O2 -shared -static-intel -fPIC -fPIC test_func-cilkplus.cpp

Then, run the following from the project root (the same directory as this file):

    python setup.py build_ext --inplace

Use the extension as shown below:

    >>> from vectorize_test.exts import test_func
    >>> import numpy as np
    >>> a = np.empty(1000000, dtype='f'); a[:] = 25; b = np.empty_like(a)
    >>> test_func.py_sqrt_test(a, b)
    >>> b
    array([ 5.,  5.,  5., ...,  5.,  5.,  5.], dtype=float32)
