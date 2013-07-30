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

    icc -o test_func_cilk.o -c -O2 -static-intel -fPIC -fPIC test_func-cilkplus.cpp -static-intel -static-libgcc -static-libstdc++



# Fortran example #

This example shows the use of Fortran code to calculate the square-root of an
array of `float` values.  The subroutine is exposed as a function callable by C
code using Fortran's `bind(c)` support.

To compile, install the Intel compiler and run the following command from
within `vectorize_test/exts/lib`:

    ifort -O2 -f90 -nofor-main test_func-fortran-c-binding.f90 -o test_func_ifort.o -shared -static-intel -static-libgcc -static-libstdc++


# Cython Extension #

To use the compiled Cilk Plus and Fortran examples, compile the Cython
extension which provides Python wrappers around the corresponding functions.

To compile the Cython extension, run the following from the project root (the
same directory as this file):

    python setup.py build_ext --inplace

Use the extension as shown below:

    >>> from vectorize_test.exts import test_func
    >>> import numpy as np
    >>> a = np.empty(1000000, dtype='f'); a[:] = 25; b = np.empty_like(a)
    >>> # Run the Cilk Plus C function
    >>> test_func.py_c_sqrt_test(a, b)
    >>> b
    array([ 5.,  5.,  5., ...,  5.,  5.,  5.], dtype=float32)
    >>> # Run the Fortran function
    >>> test_func.py_f_sqrt_test(a, b)
    >>> b
    array([ 5.,  5.,  5., ...,  5.,  5.,  5.], dtype=float32)
