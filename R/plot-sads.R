#' Convert sample dfs to long
#' @param sad_samples result of sample_FS, sample_METE
#' @return long df
#' @export
#' @importFrom tibble rownames_to_column
#' @importFrom dplyr rename
#' @importFrom tidyr gather
make_sad_samples_long <- function(sad_samples) {
  
  colnames(sad_samples) <- c(1:ncol(sad_samples))
  
  sad_gathered <- sad_samples %>%
    tibble::rownames_to_column() %>%
    dplyr::rename(sample = rowname) %>%
    tidyr::gather(key = "rank", value = "abund", -sample)
  
  return(sad_gathered)
}