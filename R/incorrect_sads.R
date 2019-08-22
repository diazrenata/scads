#' Generate an even SAD
#'
#' Generate the most even possible SAD of S species summing to N 
#' @param sad_to_use sad
#'
#' @return even sad
#' @export
#'
generate_even_sad <- function(sad_to_use) {
  even_sad <- rep(floor(sum(sad_to_use) / length(sad_to_use)), times = length(sad_to_use))
  remainder <- sum(sad_to_use) - sum(even_sad)
  even_sad[1:remainder] <- even_sad[1:remainder] + 1
  return(sort(even_sad))
}

#' Generate stepwise sad
#'
#' @param sad_to_use sad
#'
#' @return stepwise increasing sad
#' @export
#'
generate_stepwise_sad <- function(sad_to_use) {
  
  nsteps <- sum(1:length(sad_to_use))
  
  step_size <- sum(sad_to_use) / nsteps
  
  stepwise_sad <- as.integer(1:length(sad_to_use) * step_size)
  
  remainder <- sum(sad_to_use) - sum(stepwise_sad)
  
  stepwise_sad[1:remainder] <- stepwise_sad[1:remainder] + 1
  
  return(sort(stepwise_sad))
}

#' Generate exponential SAD
#'
#' @param sad_to_use sad
#'
#' @return exponential-like SAD
#' @export
#'
generate_exponential_sad <- function(sad_to_use) {
  
  powers <- c(0:(length(sad_to_use) -1))  
  
  coeffs <- 2^powers
  
  units <- sum(sad_to_use) / sum(coeffs)
  
  exp_sad <- as.integer(coeffs * units)
  
  remainder <- sum(sad_to_use) - sum(exp_sad)
  
  exp_sad[1:remainder] <- exp_sad[1:remainder] + 1
  
  return(sort(exp_sad))
}

#' Generate an SAD like a precipice
#'
#' @param sad_to_use sad
#'
#' @return sad with 1 species with almost all the individuals and every other species with 1 individual
#' @export
#'
generate_precipice_sad <- function(sad_to_use) {
  prec_sad <- rep(1, length(sad_to_use))
  prec_sad[1] <- 1 + (sum(sad_to_use) - length(sad_to_use))
  
  return(sort(prec_sad))
}