Sensitivity of skewness to singletons
================

``` r
knitr::opts_chunk$set(echo = FALSE)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(scads)
library(ggplot2)
```

    ## Loading in data version 1.127.0

This report is for Portal control rodents 1990=95, 10000 draws.
===============================================================

Density plots of raw rank abundances
------------------------------------

Each black dot is an abundance value from a vector drawn from the feasible set. The red line plots the distribution from Portal.

The black dots are semi-transparent, which makes it a little easier to see the density distribution.

![](singletons_files/figure-markdown_github/plot%20rads%20and%20rescaled%20rads-1.png)

There are `2` singleton species.
