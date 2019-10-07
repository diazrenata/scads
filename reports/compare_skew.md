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
dataset <- "large"
```

    ## Loading in data version 1.127.0

This report is for Portal control rodents 1990-95, 10000 draws.
===============================================================

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

Diversity indices
-----------------

Moving forward, we'll just use one skewness alogrithm. Comparing the ranks for skewness and diversity indices calculated using `vegan`:

-   Skewness
-   Shannon-Weiner diversity, natural log base
-   Simpson's index (1-D)
-   Fisher's alpha (not bringing this one forward - for fixed S and N, alpha does not change. This is expected because the logseries is entirely determined by S and N)

<!-- -->

    ## Loading required package: permute

    ## Loading required package: lattice

    ## This is vegan 2.5-4

### Diversity index 1:1 plots

![](compare_skew_files/figure-markdown_github/rank%201%20to%201%20plots-1.png)

    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]

There is a general, but not perfect, relationship between skewness and other diversity indices.

### Position of empirical within sim distributions

<img src="compare_skew_files/figure-markdown_github/sim emp plots-1.png" style="display: block; margin: auto;" />
