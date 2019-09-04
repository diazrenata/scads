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

#' Compute Euclidean distance of Legendre coefficients
#'
#' @param empirical optional empirical vector
#' @param draw_from "mete" or "fs" or "poilog"
#' @param nleg nb of polynomials
#' @param s s0
#' @param n n0
#' @param scale_mu mess with mu
#' @param scale_sig mess with sig
#'
#' @return euclidean distance
#' @export
#'
legendre_distance <- function(empirical = NULL, draw_from = "mete", nleg = 6, s, n, scale_mu = NULL, scale_sig = NULL, compare_sims = T) {
  
  if(compare_sims) {
    samples_to_draw <- 2
  } else {
    samples_to_draw <- 1
  }
  
  if(draw_from == "mete") {
    samples = sample_METE(s = s, n = n, nsamples = 2, distinct = T)
  } else if (draw_from == "fs") {
    samples = sample_feasibleset(s = s, n = n, nsamples = samples_to_draw, distinct = T)
  } else if(draw_from == "poilog") {
    samples = replicate(n = samples_to_draw, expr = draw_poilog_samples())
  }
  
  if(!compare_sims) {
    samples[,2] <- sort(empirical)
  }
  
  coeffs <- apply(samples, MARGIN = 2, FUN = function(a_sample, nleg) return(legendre_approx(a_sample, nleg)$coefficients), nleg = nleg) %>%
    t()
  
  return(dist(coeffs, method = "euclidean"))
  
}


#' Draw samples from poilog
#'
#' @param sad_to_use basis sad
#' @param scale_mu factor to scale mu by - to mess with prediction
#' @param scale_sig factor to scale sig by
#'
#' @return a sample
#' @export
#'
#' @importFrom poilog poilogMLE rpoilog
draw_poilog_samples <- function(sad_to_use, scale_mu = 1, scale_sig = 1) {
  poilog_fit <- poilog::poilogMLE(n = sad_to_use)
  
  nspp = length(sad_to_use)
  nind = sum(sad_to_use)
  
  poilog_samples <- NA
  
  while(any((sum(poilog_samples) != nind), (length(poilog_samples) != nspp))) {
    poilog_samples <- poilog::rpoilog(S = nspp, mu = scale_mu * poilog_fit$par[1], sig = scale_sig * poilog_fit$par[2], keep0 = F)
  }
  return(poilog_samples)
}

#' Generate a (scaled) SAD from Legendre coefficients
#'
#' @param coeff_values coeffcicient values
#' @param nleg how many polynomials to use (for shiny app; otherwise implicit in coeff_values)
#' @param nspp how many speices
#'
#' @return vector of scaled abundances
#' @export
#'
legendre_generate <- function(coeff_values, nleg, nspp, scale_pos = 2400 ) {
  
  intercept <- coeff_values[1]
  
  coeff_values <- coeff_values[2:length(coeff_values)]
  
  nleg <- length(coeff_values)
  
  leg_matrix <- get_leg_matrix(nleg, c(1:nspp))
  
  leg_estimate <- (leg_matrix %*% coeff_values) + intercept
  
  return(leg_estimate)
  
  }