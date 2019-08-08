R Notebook
================

``` r
library(scads)
```

Choose an S and N and sample METE & the feasible set...

``` r
S = 4
N = 20
nsamples = 100
```

``` r
fs_sims <- sample_feasibleset(s = S, n = N, nsamples = nsamples, distinct = TRUE)
```

``` r
mete_sims <- sample_METE(s = S, n = N, nsamples = nsamples, distinct = TRUE)
```

``` r
fs_sims_long <- make_sad_samples_long(fs_sims)

fs_sims_plot <- plot_sad_samples(fs_sims_long, sample_type = "Feasible set")

fs_sims_plot
```

![](workthrough_files/figure-markdown_github/plot%20samples-1.png)

``` r
mete_sims_long <- make_sad_samples_long(mete_sims)

mete_sims_plot <- plot_sad_samples(mete_sims_long, sample_type = "MaxEnt")

mete_sims_plot
```

![](workthrough_files/figure-markdown_github/plot%20samples-2.png)

``` r
mete_sims_long$sample_source = "METE"
fs_sims_long$sample_source = "FS"


all_sims_long <- rbind(mete_sims_long, fs_sims_long)

all_sims_plot <- plot_sad_samples(all_sims_long)

all_sims_plot
```

![](workthrough_files/figure-markdown_github/plot%20samples-3.png)

``` r
fs_mete_list <- lapply(1:min(nrow(fs_sims), nrow(mete_sims)), make_samples_list, fs_sims, mete_sims, FALSE)

fs_mete_r2 <- vapply(fs_mete_list, FUN = r2_onlist, FUN.VALUE = .8)


fs_fs_list <- lapply(1:nrow(fs_sims), make_samples_list, fs_sims, fs_sims, TRUE)
fs_fs_r2 <- vapply(fs_fs_list, FUN = r2_onlist, FUN.VALUE = .8)

mete_mete_list <- lapply(1:nrow(mete_sims), make_samples_list, mete_sims, mete_sims, TRUE)
mete_mete_r2 <- vapply(mete_mete_list, FUN = r2_onlist, FUN.VALUE = .8)

fs_mete_r2 <- data.frame(r2 = fs_mete_r2, comparison = "fs_mete")
fs_fs_r2 <- data.frame(r2 = fs_fs_r2, comparison = "fs_fs")
mete_mete_r2 <- data.frame(r2 = mete_mete_r2, comparison = "mete_mete")

all_r2 <- rbind(fs_mete_r2, fs_fs_r2, mete_mete_r2)

r2_plot <- ggplot2::ggplot(data = all_r2, ggplot2::aes(x = r2, y = comparison)) + 
  ggplot2::geom_jitter(data = all_r2) + 
  ggplot2::theme_bw()

r2_plot
```

![](workthrough_files/figure-markdown_github/r2%20comparison-1.png)

Trying loglikelihood...

``` r
this_esf <- meteR::meteESF(S0 = S, N0 = N)

this_mete_sad <- meteR::sad(this_esf)

fs_loglik <- apply(fs_sims, MARGIN= 1, FUN = loglik_sad, 
                    mete_sad_dist = this_mete_sad)

mete_loglik <- apply(mete_sims, MARGIN = 1, FUN = loglik_sad,
                      mete_sad_dist = this_mete_sad)
fs_loglik <- data.frame(loglik = fs_loglik,
                        source = "FS")
mete_loglik <- data.frame(loglik = mete_loglik,
                          source = "METE")

all_loglik <- rbind(fs_loglik, mete_loglik)

all_loglik_plot <- ggplot2::ggplot(data = all_loglik, ggplot2::aes(x = loglik, y = source, color = source)) + 
  ggplot2::geom_jitter(data = all_loglik) + 
  ggplot2::theme_bw()

all_loglik_plot
```

![](workthrough_files/figure-markdown_github/loglik%20comparison-1.png)
