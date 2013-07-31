#!/usr/bin/env python

from distutils.core import setup, Extension
from Cython.Build import cythonize

core_ext = Extension('vectorize_test.exts.test_func',
                     sources=['vectorize_test/exts/test_func.pyx'],
                     extra_objects=['vectorize_test/exts/lib/test_func_cilk.o',
                                    'vectorize_test/exts/lib/test_func_ifort.o'],
                     libraries=['cilkrts'],
                     language='c++',
                     extra_compile_args=['-O2'])

setup(name = "vectorize_test",
    version = "0.0.1",
    description = "Vectorized operations compiled extension tests.",
    keywords = "c c++ fortran cilk intel icc ifort vectorize test runtime",
    author = "Christian Fobel",
    url = "https://github.com/cfobel/vectorize_test",
    license = "GPL",
    long_description = """""",
    packages = ['vectorize_test', 'vectorize_test.exts'],

    package_data={'vectorize_test.exts': ['*.so'], },
    ext_modules=cythonize([core_ext])
)
