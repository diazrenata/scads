#' @title Calculate a single r2
#' From `conditionalsads`
#' @param focal_sad ascending RAD ("empirical")
#' @param compare_sad ascending RAD from samples
#'
#' @return r2
#' @export
#'
r2 <- function(focal_sad, compare_sad) {
  
  r2 = 1 - (
    (sum((log10(focal_sad) - log10(compare_sad))^2)) /
      sum((log10(focal_sad) - mean(log10(focal_sad)))^2)
  )
  
  return(r2)
}

#' R2 wrapper
#' @param list_of_sads result of make_sads_list
#' @return r2
#' @export 
r2_onlist <- function(list_of_sads) {
  focal_sad <- as.numeric(list_of_sads[[1]])
  compare_sad <- as.numeric(list_of_sads[[2]])
  this_r2 <- r2(focal_sad, compare_sad)
  return(this_r2)
}



#' logLik of an sad from METE
#' @param focal_sad sad vector
#' @param mete_sad_dist result of meteR::sad(meteESF)
#' @return loglikelihood
#' @export
loglik_sad <- function(focal_sad, mete_sad_dist) {
  this_ll <- sum(mete_sad_dist$d(focal_sad, log=TRUE))
  return(this_ll)
}