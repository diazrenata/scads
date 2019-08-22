fit\_legendre
================
Renata Diaz
8/19/2019

``` r
library(ggplot2)
library(meteR)
library(orthopolynom)
```

    ## Loading required package: polynom

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
get_leg_matrix <- function(n, x) {
  legcoeff <- legendre.polynomials(n = n, normalized = TRUE)
  
  legmat <- as.matrix(as.data.frame(polynomial.values(polynomials=legcoeff,
                                                      x=scaleX(x, u=-1, v=1))))
  legmat <- legmat[, 2:ncol(legmat)]
  
  colnames(legmat) <- c(1:n)
  return(legmat)
}
```

``` r
portal_data <- isds::get_toy_portal_data(download=T)
```

    ## Loading in data version 1.90.0

``` r
portal_sad <- portal_data %>%
  select(species) %>%
  group_by(species) %>%
  summarize(abund = n()) %>%
  ungroup() %>%
  select(abund) %>%
  arrange(abund) %>%
  as.matrix() %>%
  as.vector()

this_esf <- meteESF(S0 = length(portal_sad), N0 = sum(portal_sad))
this_sad <- sad(this_esf)
this_sad_draw <- c(0, 1)

set.seed(1977)

while(sum(this_sad_draw) != sum(portal_sad)) {
  this_sad_draw <- this_sad$r(length(portal_sad))
}

mete_sad <- sort(this_sad_draw)

std_df <- data.frame(x = 1:length(portal_sad), 
                     mete = mete_sad / sum(mete_sad),
                     real = portal_sad/sum(portal_sad),
                     nleg = "Emp")

std_df$x <- std_df$x - mean(std_df$x)
std_df$x <- std_df$x / (max(std_df$x))
```

``` r
real_plot <- ggplot(data = std_df, aes(x = x, y = real)) +
  geom_point(color = "green") +
  geom_point(aes(x = x, y = mete), color = "blue") +
  theme_bw() +
  xlim(-1, 1) +
  ylim(0, 1)
real_plot
```

![](fit_legendre_files/figure-markdown_github/plot%20data-1.png)

    ## Warning in predict.lm(leg_fits[[i]]$real, newdata =
    ## as.data.frame(std_df$x)): prediction from a rank-deficient fit may be
    ## misleading

    ## Warning in predict.lm(leg_fits[[i]]$mete, newdata =
    ## as.data.frame(std_df$x)): prediction from a rank-deficient fit may be
    ## misleading

![](fit_legendre_files/figure-markdown_github/fit%20with%20legendre%20polynomials-1.png)![](fit_legendre_files/figure-markdown_github/fit%20with%20legendre%20polynomials-2.png)![](fit_legendre_files/figure-markdown_github/fit%20with%20legendre%20polynomials-3.png)
