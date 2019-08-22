fit\_legendre
================
Renata Diaz
8/19/2019

``` r
library(ggplot2)
library(meteR)
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
```

``` r
load(here::here("reports", "legendre_stash", "all_fits_w_poilog.RData"))

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

nspp = length(portal_sad)
nind = sum(portal_sad)
nsamples = 10


portal_sad <- data.frame(
  sim = as.integer(-99),
  abund = portal_sad,
  source = "emp"
)
n_ssqes <- length(unique(all_sads_fit$ssqe_source))
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Warning: Removed 24 rows containing missing values (geom_bar).

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Warning: Removed 20 rows containing missing values (geom_bar).

![](legendre_ssqe_files/figure-markdown_github/plot%20ssqes-1.png)

![](legendre_ssqe_files/figure-markdown_github/emp%20plot-1.png)

    ## Warning in bind_rows_(x, .id): binding factor and character vector,
    ## coercing into character vector

    ## Warning in bind_rows_(x, .id): binding character and factor vector,
    ## coercing into character vector

    ## Loading required package: polynom

![](legendre_ssqe_files/figure-markdown_github/get%20coefficients-1.png)

``` r
one_sim <- filter(all_sads2, sim %in% c(1, -99)) %>%
  group_by(source) %>%
  mutate(abund = sort(abund)) %>%
  mutate(x = row_number()) %>%
  ungroup()

sads_plot <- ggplot(data = one_sim, aes(x =x, y = abund )) +
  geom_point() +
  theme_bw() +
  facet_grid(cols = vars(source))

sads_plot
```

![](legendre_ssqe_files/figure-markdown_github/plot%20sads%20and%20scaled%20sads-1.png)

![](legendre_ssqe_files/figure-markdown_github/distance%20plot-1.png)
