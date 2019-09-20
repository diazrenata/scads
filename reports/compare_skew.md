Comparing different skewness calculations
================

Do different methods for calculating skewness give qualitatively similar results?

(For later - evenness?)

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
dataset <- "plants"
```

    ## Loading in data version 1.127.0

This report is for Portal winter annuals 1994, 10000 draws.
===========================================================

Density plots of raw rank abundances
------------------------------------

The y-axis is abundance. Each black dot is an abundance value from a vector drawn from the feasible set. The red line plots the distribution from Portal.

![](compare_skew_files/figure-markdown_github/plot%20rads%20and%20rescaled%20rads-1.png)

Skewness algorithms
-------------------

`e1071` has three algorithms available for skewness. Do they give the same results?

![](compare_skew_files/figure-markdown_github/skewness%20algs-1.png)

![](compare_skew_files/figure-markdown_github/ranked%20skew-1.png)

Are literally all of the ranks exactly the same?

    ## [1] TRUE
