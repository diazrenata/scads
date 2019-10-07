library(drake)
library(scads)
library(feasiblesads)


# load p table
load(file = here::here("drake", "p_table.Rds"))

# source wrapper

source(here::here("drake", "wrapper.R"))

# set up desired S and N combinations

small_s <- c(2:10)
small_n <-  c(2:19, seq(20, 200, by = 10))

small_combinations <- expand.grid(S = small_s, N = small_n) %>%
  dplyr::filter(N > S)

large_s <- c(10, 20, 30, seq(50, 250, by = 50))
moderate_n <- seq(50, 250, by = 50)

ls_mn_combinations <- expand.grid(S = large_s, N = moderate_n) %>%
  dplyr::filter(N > S)

moderate_s <- c(seq(5, 40, by = 5), 50, 75)
large_n <- c(seq(500, 2500, by = 500), 5000, 7500)

ms_ln_combinations <- expand.grid(S = moderate_s, N = large_n) %>%
  dplyr::filter(N > S)

all_combinations <- dplyr::bind_rows(small_combinations, ls_mn_combinations, ms_ln_combinations)


# sample fs


sample_plan <- drake_plan(
  fs = target(sample_fs_wrapper(sval, nval, ptable, nbdraws),
              transform = map(sval = !!all_combinations$S, nval = !!all_combinations$N, nbdraws = 10000, ptable = master_p_table)
  ))
 
# reports

# run


## Set up the cache and config
db <- DBI::dbConnect(RSQLite::SQLite(), here::here("drake", "drake-cache.sqlite"))
cache <- storr::storr_dbi("datatable", "keystable", db)

## View the graph of the plan
if (interactive())
{
  config <- drake_config(sample_plan, cache = cache)
  sankey_drake_graph(config, build_times = "none")  # requires "networkD3" package
  vis_drake_graph(config, build_times = "none")     # requires "visNetwork" package
}

set.seed(1977)

## Run the pipeline
nodename <- Sys.info()["nodename"]
if(grepl("ufhpc", nodename)) {
  library(future.batchtools)
  print("I know I am on SLURM!")
  ## Run the pipeline parallelized for HiPerGator
  future::plan(batchtools_slurm, template = "slurm_batchtools.tmpl")
  make(sample_plan,
       force = TRUE,
       cache = cache,
       cache_log_file = here::here("drake", "cache_log.txt"),
       verbose = 2,
       parallelism = "future",
       jobs = 64,
       caching = "master") # Important for DBI caches!
} else {
  # Run the pipeline on a single local core
  system.time(make(sample_plan, cache = cache, cache_log_file = here::here("drake", "cache_log.txt")))
}


print("Completed OK")
