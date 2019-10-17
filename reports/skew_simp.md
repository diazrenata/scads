Exploring S and N space - skewness v simpsons
================
10/17/2019

Combinations of S & N
---------------------

These are the combinations of S and N I ran sampling on. There are three chunks: small, large S, and large N. Small is to get at behavior for very small S and N. Large S and large N explore larger communities in those directions. The bottom right corner is gently constrained because N must be &gt;= to S. I tried to explore the general regions of space filled by the datasets in the Baldridge/White papers. I've done this edges-approach because is computationally expensive to explore the large S-large N corner, and there aren't datasets there.

![](skew_simp_files/figure-markdown_github/S%20and%20N%20combos-1.png)![](skew_simp_files/figure-markdown_github/S%20and%20N%20combos-2.png)

Heatmaps
--------

These are a prototypical way to see if the weirdos in terms of skewness map on to weirdos in terms of simpson's. We know the ranks/percentiles aren't 1:1, but do they point in similar directions?

This code needs to be generalized.

![](skew_simp_files/figure-markdown_github/prep%20heatmap%20data-1.png)
