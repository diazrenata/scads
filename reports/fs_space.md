Mapping FS space
================

``` r
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
small = F
knitr::opts_chunk$set(echo = FALSE)
```

    ## Loading in data version 1.127.0

![](fs_space_files/figure-markdown_github/density%20plot%20perhaps-1.png)

![](fs_space_files/figure-markdown_github/rescaled%20sads%20and%20density%20plots-1.png)

    ## Loading required package: polynom

![](fs_space_files/figure-markdown_github/distance%20to%20centroid-1.png)

Red is Portal, green is the centroid.

    ## Warning: Removed 1 rows containing missing values (geom_path).

![](fs_space_files/figure-markdown_github/generate%20from%20centroid,%20empirical-1.png)

Points are estimates from approximation with 8 polynomials.

SSQE is error of estimation vs. real value. There is no real value for the centroid, but `closest_fs` is the element of the feasible set with the lowest sum-absolute-distance of coefficients to the centroid coefficients.

![](fs_space_files/figure-markdown_github/dist%20to%20centroid%20plot-1.png)

![](fs_space_files/figure-markdown_github/heatmap-1.png)

![](fs_space_files/figure-markdown_github/linecloud-1.png)
