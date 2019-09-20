Sensitivity
================
Renata Diaz
8/22/2019

    ## Loading in data version 1.90.0

    ## Warning in bind_rows_(x, .id): binding factor and character vector,
    ## coercing into character vector

    ## Warning in bind_rows_(x, .id): binding character and factor vector,
    ## coercing into character vector

    ## Loading required package: polynom

![](sensitivity_files/figure-markdown_github/generate%20and%20plot%20Leg%20coeffs-1.png)

![](sensitivity_files/figure-markdown_github/draw%20and%20plot%20fs%20and%20mete%20corpuses-1.png)

![](sensitivity_files/figure-markdown_github/fit%20and%20plot%20sims-1.png)

![](sensitivity_files/figure-markdown_github/coeff%20distances-1.png)

Centroids
---------

This seems to match intuition from the coefficients plot. I'm not completely sure but I think the euclidean distance *to all other points* (above) is weird for a couple reasons; one being it's not actually being calculated to all other points; I just cycled forward two ticks. So every point gets compared to 2 other points, I guess? i + 2 and i - 2.

    ## # A tibble: 6 x 5
    ##   sim_source   sim varname     coefficient varindex
    ##   <chr>      <int> <chr>             <dbl>    <int>
    ## 1 mete           1 (Intercept)      0.0928        1
    ## 2 mete           2 (Intercept)      0.0815        1
    ## 3 mete           3 (Intercept)      0.0856        1
    ## 4 mete           4 (Intercept)      0.0515        1
    ## 5 mete           5 (Intercept)      0.0606        1
    ## 6 mete           6 (Intercept)      0.0489        1

![](sensitivity_files/figure-markdown_github/centroids-1.png)![](sensitivity_files/figure-markdown_github/centroids-2.png)

Centroids on log abundance?
---------------------------

(want to somehow downweight really big abundance values? but euclidean distance in log space seems highly suspect, and I don't really have intuition for interpreting the results)

![](sensitivity_files/figure-markdown_github/abundance%20centroids-1.png)
