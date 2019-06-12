#' @title Draw from METE prediction
#' @description Use `meteR` to generate the SAD from METE and draw samples from it
#' @param s how many species
#' @param n how many individuals
#' @param nsamples how many samples to draw
#' @return matrix of samples. rows are samples, columns are species
#' @export
#' @importFrom meteR meteESF
#' @importFrom meteR sad
sample_METE <- function(s, n, nsamples){
  sims <- matrix(nrow = nsamples, ncol = s)
  
  if(s==1) {
    for(i in 1:nsamples) {
      sims[i,1] <- n
    }
  }
  
  
  if(n==s) {
    for(i in 1:nsamples) {
      for(j in 1:s) {
        sims[i,j] <- 1
      }
    }
  }
  this_esf <- meteR::meteESF(S0 = s, N0 = n)
  this_sad <- meteR::sad(this_esf)
  
  state.var <- n
  
  
  for(i in 1:nsamples) {
    while(is.na(sims[i, 1])) {
      new.dat <- this_sad$r(s)
      if(sum(new.dat) == state.var) {
        sims[i, ] = sort(new.dat, decreasing = F)
      }
    }
  }
  
  return(sims)
}