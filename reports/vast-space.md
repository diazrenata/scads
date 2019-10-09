Exploring S and N space
================
10/8/2019

Combinations of S & N
---------------------

These are the combinations of S and N I ran sampling on. There are three chunks: small, large S, and large N. Small is to get at behavior for very small S and N. Large S and large N explore larger communities in those directions. The bottom right corner is gently constrained because N must be &gt;= to S. I tried to explore the general regions of space filled by the datasets in the Baldridge/White papers. I've done this edges-approach because is computationally expensive to explore the large S-large N corner, and there aren't datasets there.

![](vast-space_files/figure-markdown_github/S%20and%20N%20combos-1.png)![](vast-space_files/figure-markdown_github/S%20and%20N%20combos-2.png)

Number of unique elements (out of 10,000 draws)
-----------------------------------------------

I've drawn 10,000 times from the feasible set for each of these S-N combinations. For some of them, we won't be able to get 10,000 unique elements from the feasible set because the FS is in fact much smaller than that.

![](vast-space_files/figure-markdown_github/unique%20draws-1.png)![](vast-space_files/figure-markdown_github/unique%20draws-2.png)

Shapes represented
------------------

### Skewness

![](vast-space_files/figure-markdown_github/skewness%20min,%20max,%20range%20plot-1.png)

### Shannon

### Simpson

Some sample heatmaps?
---------------------

### Small communities

![](vast-space_files/figure-markdown_github/small%20heatmap-1.png)![](vast-space_files/figure-markdown_github/small%20heatmap-2.png)

### Large S, moderate N

![](vast-space_files/figure-markdown_github/large%20s%20med%20N-1.png)

### Large N, moderate S

![](vast-space_files/figure-markdown_github/large%20n%20med%20S-1.png)
