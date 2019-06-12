#' Convert sample dfs to long
#' @param sad_samples result of sample_FS, sample_METE
#' @return long df
#' @export
#' @importFrom tibble rownames_to_column
#' @importFrom dplyr rename
#' @importFrom tidyr gather
make_sad_samples_long <- function(sad_samples) {
  
  colnames(sad_samples) <- sort(c(1:ncol(sad_samples)), decreasing = TRUE)
  
  sad_gathered <- sad_samples %>%
    tibble::rownames_to_column() %>%
    dplyr::rename(sample = rowname) %>%
    tidyr::gather(key = "rank", value = "abund", -sample)
  
  return(sad_gathered)
}


#' Plot SAD samples
#' @param long_sad_samples from `make_sad_samples_long`
#' @param sample_type for plot title
#' @return the plot
#' @export
#' @importFrom ggplot2 ggplot aes labs theme_bw geom_jitter 
plot_sad_samples <- function(long_sad_samples, sample_type = NULL) {
  
  if("sample_source" %in% colnames(long_sad_samples)) {
    sample_plot <- ggplot2::ggplot(data = long_sad_samples, ggplot2::aes(x = rank, y = abund, color = sample_source)) +
      ggplot2::geom_jitter(data = long_sad_samples, inherit.aes = TRUE) +
      ggplot2::labs(x = "Rank", y = "Abundance", title = "METE + FS Samples") +
      ggplot2::theme_bw()
  } else {
    plottitle <- paste0(sample_type, " Samples")
    sample_plot <- ggplot2::ggplot(data = long_sad_samples, ggplot2::aes(x = rank, y = abund)) +
      ggplot2::geom_jitter(data = long_sad_samples, inherit.aes = TRUE) +
      ggplot2::labs(x = "Rank", y = "Abundance", title = plottitle) +
      ggplot2::theme_bw()
  }
  
  return(sample_plot)
  
}
