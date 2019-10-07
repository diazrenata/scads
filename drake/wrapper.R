sample_fs_wrapper <- function(nspp, nind, p_table, ndraws) {
  
  max_s <- nrow(p_table)
  
  max_n <- ncol(p_table)
  
  if(all((nspp < max_s), (nind < max_n))) {
    
    p_table <- p_table[1:nspp, 1:(nind + 1)]
    
  } else {
    p_table <- feasiblesads::fill_ps(max_s = nspp + 2,
                                     max_n = nind + 2,
                                     storeyn = FALSE)
  }
    
    fs_samples <- feasiblesads::sample_fs(s = nspp, n = nind, nsamples = ndraws, p_table = p_table) %>%
      unique() %>%
      t() %>%
      as.data.frame() %>%
      tidyr::gather(key = "sim", value = "abund") %>%
      dplyr::mutate(sim = as.integer(substr(sim, 2, nchar(sim)))) %>%
      dplyr::group_by(sim) %>%
      dplyr::arrange(abund) %>%
      dplyr::mutate(rank = dplyr::row_number()) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(source = "sampled")
    
    return(fs_samples)
  
}