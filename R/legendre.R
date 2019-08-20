#' Perform Legendre approximation
#'
#' @param vec an SAD
#' @param nleg how many polynomials to include
#'
#' @return lm; Legendre approximation
#' @export
legendre_approx <- function(vec, nleg){
  
  scaled_df <- scale_vector(vec)
  
  leg_matrix <- get_leg_matrix(n = nleg, x = 1:length(vec))
  
  leg_fit <- lm(scaled_df$val ~ leg_matrix)

  return(leg_fit)
}