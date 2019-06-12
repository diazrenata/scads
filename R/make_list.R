#' Make a list for comparison
#' @param i index
#' @param first_samples first set
#' @param second_samples second set
#' @param random T/F whether to assign pairs randomly
#' @return list of rows as a list
#' @export
make_samples_list <- function(i, first_samples, second_samples, random = FALSE) {
  if(!random) {
  this_list <- list(first_samples[i, ], second_samples[i, ])
  } else {
    index2 <- i
    while(index2 == i) {
    index2 <- sample.int(nrow(second_samples), size = 1) 
    }
    this_list <- list(first_samples[i, ], second_samples[index2, ])
  }
  return(this_list)
}