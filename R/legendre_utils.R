#' Retrieve Legendre polynomials
#'
#' Retrieves the first `n` Legendre polynomials, evaluated on `x` scaled from -1 to 1.
#'
#' @param n integer will retrieve the first n polynomials
#' @param x integer vector will evaluate along x scaled to be from -1:1
#'
#' @return `x` by `n` matrix of n polynomials evaluated at `length(x)` points, without the intercept (0th order polynomial)
#' @export
#'
#' @importFrom orthopolynom legendre.polynomials polynomial.values scaleX
get_leg_matrix <- function(n, x) {
  library(orthopolynom)
  
  if(any(!(dplyr::between(x, left = -1, right = 1)))) {
    x <- orthopolynom::scaleX(x, u = -1, v = 1)
  }
  
  legcoeff <- orthopolynom::legendre.polynomials(n = n, normalized = TRUE)
  
  legmat <- as.matrix(as.data.frame(orthopolynom::polynomial.values(polynomials=legcoeff,
                                                      x=x)))
  legmat <- legmat[, 2:ncol(legmat)]
  
  colnames(legmat) <- c(1:n)
  return(legmat)
}

#' Scale a vector for Legendre approximation
#'
#' @param vec Vector (an SAD) to scale
#'
#' @return dataframe of `x` = `(-1:1, length = length(vec))` and `val` = `vec / sum(vec)`
#' @export
#'
#' @importFrom orthopolynom scaleX
scale_vector <- function(vec) {
  vec <- sort(vec)
  
  x <- 1:length(vec) %>%
    orthopolynom::scaleX(u = -1, v = 1)

  vec <- vec / sum(vec)
  
  return(data.frame(x = x, val = vec))
}

#' Calculate sum squared errorfor two vectors
#'
#' @param a vector
#' @param b vector of `length(b) == length(a)`
#'
#' @return ssq of a and b
#' @export
#'
ssqe <- function(a, b, scale = T) {
  
  a <- sort(a)
  b <- sort(b)
  
  if(scale) {
    a <- a / sum(a)
    b <- b / sum(b)
  }
  
  sqe <- (a - b) ^2
  
  return(sum(sqe))
  
}

#' Euclidean distance between vectors
#'
#' @param v1 row 1
#' @param v2 row 2
#'
#' @return euclidean distance
#' @export
#'
eucl_rows <- function(v1, v2) {
  m <- matrix(data = c(v1, v2), nrow = 2, byrow = T)
  return(dist(m, method = "euclidean")[1])
}