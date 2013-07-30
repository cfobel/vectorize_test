#!/usr/bin/env python

from distutils.core import setup, Extension
from Cython.Build import cythonize

core_ext = Extension('vectorize_test.exts.test_func',
                     sources=['vectorize_test/exts/test_func.pyx'],
                     libraries=['test_func_cilk'], language='c++',
                     extra_compile_args=['-O2'],
                     extra_link_args=['-L./vectorize_test/exts/lib'])

setup(name = "vectorize_test",
    version = "0.0.1",
    description = "Vectorized operations compiled extension tests.",
    keywords = "c c++ fortran cilk intel icc ifort vectorize test runtime",
    author = "Christian Fobel",
    url = "https://github.com/cfobel/vectorize_test",
    license = "GPL",
    long_description = """""",
    packages = ['vectorize_test', 'vectorize_test.exts'],

    package_data={'vectorize_test.exts': [ '*.so', ], },
    ext_modules=cythonize([core_ext])
)
