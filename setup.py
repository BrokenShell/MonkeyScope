from setuptools import setup, Extension
from Cython.Build import cythonize


with open("README.md", "r") as file:
    long_description = file.read()


setup(
    name="MonkeyScope",
    ext_modules=cythonize(
        Extension(
            name="MonkeyScope",
            sources=["MonkeyScope.pyx"],
            language=["c++"],
        ),
        compiler_directives={
            'embedsignature': True,
            'language_level': 3,
        },
    ),
    author="Robert Sharp",
    author_email="webmaster@sharpdesigndigital.com",
    version="1.4.1",
    description="Distributions & Timer for Non-deterministic Value Generators",
    long_description=long_description,
    long_description_content_type="text/markdown",
    license="Free for non-commercial use",
    platforms=["Darwin", "Linux"],
    classifiers=[
        "Development Status :: 5 - Production/Stable",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Cython",
        "Operating System :: MacOS :: MacOS X",
        "Operating System :: POSIX :: Linux",
        "Topic :: Software Development :: Libraries :: Python Modules",
    ],
    keywords=[
        "MonkeyScope", "distribution tests", "function timer",
        "performance testing", "statistical analysis",
    ],
    python_requires='>=3.7',
)
