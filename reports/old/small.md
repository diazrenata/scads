Exploring S and N space
================
10/8/2019

Combinations of S & N
---------------------

These are the combinations of S and N I ran sampling on. There are three chunks: small, large S, and large N. Small is to get at behavior for very small S and N. Large S and large N explore larger communities in those directions. The bottom right corner is gently constrained because N must be &gt;= to S. I tried to explore the general regions of space filled by the datasets in the Baldridge/White papers. I've done this edges-approach because is computationally expensive to explore the large S-large N corner, and there aren't datasets there.

![](small_files/figure-markdown_github/S%20and%20N%20combos-1.png)

Number of unique elements (out of 10,000 draws)
-----------------------------------------------

I've drawn 10,000 times from the feasible set for each of these S-N combinations. For some of them, we won't be able to get 10,000 unique elements from the feasible set because the FS is in fact much smaller than that.

![](small_files/figure-markdown_github/unique%20draws-1.png)

![](small_files/figure-markdown_github/sparse%20small-1.png)

Shapes represented - violins
----------------------------

Generally, for the small combinations, it looks like

-   the mean value of whatever index increases with increasing S (2:10)
-   the lower tail of the index gets longer with increasing N (4:200)
-   the tails taper more sharply for Shannon & Simpson than for skewness
-   Skewness seems to behave a little counterintuitively. It appears to *increase* with increasing S; very low S has near-0 skewness. For a given S, the mean skewness decreases with increasing N, and the tail gets longer. Within the scope of strictly increasing RADs, *the larger the skewness, the longer the rare tail in the SAD*.

For S=2, skewness is always 0. I have removed those plots.

    ## Warning: Removed 16 rows containing non-finite values (stat_ydensity).

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

![](small_files/figure-markdown_github/skew%20violins-1.png)

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

![](small_files/figure-markdown_github/skew%20violins-2.png)

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

    ## Warning in max(data$density): no non-missing arguments to max; returning -
    ## Inf

![](small_files/figure-markdown_github/skew%20violins-3.png)

Multipanel heatmaps
-------------------

![](small_files/figure-markdown_github/heatmaps-1.png)![](small_files/figure-markdown_github/heatmaps-2.png)![](small_files/figure-markdown_github/heatmaps-3.png)
