Legendre polynomial approximation of SADs
================
Renata Diaz based on conv. with RLD
8/8/2019

Some potentially useful aspects of Legendre polynomial approximation:

-   Reduce dimensionality
-   The difference between two fits is the Euclidean distance between the LgP coefficients
-   To fit S species, the maximum nb of coefficients is S. Usually you will need considerably fewer.

A rough workflow:

``` r
library(ggplot2)
library(meteR)
library(orthopolynom)
```

    ## Loading required package: polynom

``` r
get_leg_matrix <- function(n, x) {
  legcoeff <- legendre.polynomials(n = n, normalized = TRUE)
  
  legmat <- as.matrix(as.data.frame(polynomial.values(polynomials=legcoeff,
                                                      x=scaleX(x, u=-1, v=1))))
  legmat <- legmat[, 2:ncol(legmat)]
  
  colnames(legmat) <- c(1:n)
  return(legmat)
}

this_esf <- meteESF(S0 = 10, N0 = 100)
this_sad <- sad(this_esf)
this_sad_draw <- this_sad$r(10)
sum(this_sad_draw)
```

    ## [1] 185

``` r
while(sum(this_sad_draw) != 100) {
  this_sad_draw <- this_sad$r(10)
}

this_sad_draw <- sort(this_sad_draw)


std_draw <- this_sad_draw / (sum(this_sad_draw))

std_df <- data.frame(x = 1:length(std_draw), val = std_draw, nleg = "Real")

std_df$x <- std_df$x - mean(std_df$x)
std_df$x <- std_df$x / (max(std_df$x))

leg_fits <- list()
candidates <- c(3:9)
leg_coeffs <- matrix(nrow = length(candidates), ncol = max(candidates)+ 1)
colnames(leg_coeffs) <- c("Intercept", 1:max(candidates))
for(i in 1:length(candidates)) {
  leg_mat <- get_leg_matrix(n = candidates[i], x = c(1:10))
  leg_fits[[i]] <- lm(std_df$val ~ leg_mat)
  leg_coeffs[i, 1:length(leg_fits[[i]]$coefficients)] <- leg_fits[[i]]$coefficients
}

predPlots <- list()

std_df_pred <- std_df

for(i in 1:length(leg_fits)) {
  leg_mat <- get_leg_matrix(n = candidates[i], x = c(1:10))
  predvals <- predict(leg_fits[[i]], newdata = as.data.frame(std_df$x))
  newmat <- data.frame(x = std_df$x,
                       val = predvals,
                       nleg = as.character(candidates[i]))
std_df_pred <- rbind(std_df_pred, newmat)
}


fit_plot <- ggplot(data = std_df_pred, aes(x = x, y = val, color = nleg)) +
  geom_point() +
  theme_bw()
fit_plot
```

![](legendre_files/figure-markdown_github/legendre%20raw-1.png)

``` r
fit_plots <- list() 

for(i in 1:7) {
  
fit_plots[[i]] <- ggplot(data = dplyr::filter(std_df_pred, nleg %in% c("Real", as.character(unique(std_df_pred$nleg)[i + 1]))), 
                     aes(x = x,
                     y = val,
                     color = nleg)) +
  geom_point() +
  theme_bw()

}

gridExtra::grid.arrange(grobs = fit_plots, nrow = 3)
```

![](legendre_files/figure-markdown_github/legendre%20raw-2.png)

``` r
leg_coeffs_toplot <- data.frame(
  leg <- c(1:9),
coeff_vals <- as.numeric(leg_coeffs[7, 1:9])
)

coeff_plot <- ggplot(data = leg_coeffs_toplot,
                     aes(x = leg, y = coeff_vals)) +
  geom_point() +
  theme_bw()


coeff_plot
```

![](legendre_files/figure-markdown_github/legendre%20raw-3.png)

Some links on Legendre polynomial approximation:

<http://www.math.pitt.edu/~sussmanm/2070/lab_09/index.html#LeastSquares>

<https://math.stackexchange.com/questions/196178/least-square-fit-using-legendre-polynomials>

<https://www.mathworks.com/matlabcentral/fileexchange/20932-legendre-polynomial-fitting>
