#' @title Draw from feasible set
#' @description Use `feasiblesads` to generate samples from the feasible set. Building on code from `diazrenata/conditionalsads`
#' @param s how many species
#' @param n how many individuals
#' @param nsamples how many samples to draw
#' @param distinct TRUE/FALSE filter to distinct vectors. If true may not return nsamples samples. 
#' @export
#' @importFrom feasiblesads sample_fs
#' @importFrom feasiblesads tally_sets

sample_feasibleset <- function(s, n, nsamples, distinct = TRUE){
  sims <- feasiblesads::sample_fs(s, n, nsamples, storeyn = FALSE)
  sims <- as.data.frame(sims)
  if(distinct) { 
    sims <- feasiblesads::tally_sets(sims) %>%
    dplyr::select(-set_frequency)
  }
  
  sims <- as.data.frame(t(sims))
  
  return(sims)
}