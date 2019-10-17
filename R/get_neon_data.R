#' Download NEON data
#'
#' Download raw data using neonUtilities.
#'
#' @parameter taxonType "aquatic_plants", etc
#'
#' @export
#' @importFrom neonUtilities zipsByProduct stackByTable
#' @importFrom here here
download_neon_data <- function(taxonType){
  
  save_filepath <- here::here("reports", "datasets", "neon", taxonType)
  
  if(!dir.exists(here::here("reports", "datasets", "neon", taxonType))) {
    dir.create(save_filepath)
  }
  
  if(taxonType == "aquatic_plants") {
    dataProductID <- "DP1.20072.001"
  }
  
  if(taxonType == "ground_beetles") {
    dataProductID <- "DP1.10022.001"
  }
  
  neonUtilities::zipsByProduct(dpID = dataProductID, site = "all",
                               savepath = save_filepath)
  

  filepath_forstack <- file.path(save_filepath, list.dirs(save_filepath, full.names = FALSE)[ which(nchar(list.dirs(save_filepath, full.names = FALSE)) > 2)])
  
  neonUtilities::stackByTable(filepath = filepath_forstack, folder = T)
}
#' 
#' #' Load NEON data
#' #' 
#' #' Load NEON data from downloaded and stacked tables.
#' #' @parameter taxonType "aquatic_plants", etc
#' #' 
#' #' @export
#' load_neon_data <- function(taxonType){
#'   
#'   if(taxonType == "aquatic_plants") {
#'     
#'     
#'     
#'     
#'   }
#'   
#'   
#' }