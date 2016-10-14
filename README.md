
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/types)](https://cran.r-project.org/package=types) [![Travis-CI Build Status](https://travis-ci.org/jimhester/types.svg?branch=master)](https://travis-ci.org/jimhester/types) [![Coverage Status](https://img.shields.io/codecov/c/github/jimhester/types/master.svg)](https://codecov.io/github/jimhester/types?branch=master) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/jimhester/types?branch=master&svg=true)](https://ci.appveyor.com/project/jimhester/types)

Types for R
-----------

This package provides a simple type annotation for R that is usable in scripts, in the R console and in packages. It is intended as a convention to allow other packages or IDE's to use the type information to provide error checking, automatic documentation or optimizations.

The annotations are syntactically valid R code rather than comments, which provides additional assurance they are specified properly. However this package does not do anything with the type annotations, they have no effect on the calculated result.

`?` when used on the command line continues to work as before, accessing the R help pages for the topic requested.

Examples
--------

Function arguments can be annotated with types

``` r
f <- function(x = 1 ? numeric) {
  x + 1
}
```

Default arguments can also be annotated (the `=` is required however)

``` r
f <- function(x = ? numeric) {
  x + 1
}
```

Function statements can be annotated with types

``` r
f <- function(x = "Yay") {
  paste(x, "types!") ? character
}
```

Function return values can be annotated with types

``` r
f <- function(x = 1) {
  x %% 2 == 0
} ? boolean
```

Prior work
----------

The [argufy package](https://github.com/gaborcsardi/argufy#readme) by Gábor Csárdi was an exploration of typed arguments and was the original impetus of the `?` syntax.
