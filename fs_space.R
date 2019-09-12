## ----setup---------------------------------------------------------------
library(dplyr)
library(scads)
library(ggplot2)


## ----get an SAD----------------------------------------------------------

portal_sad <- portalr::plant_abundance(level = "Treatment", type = "Winter Annuals", plots = "All", unknowns = F, correct_sp = T, shape = "flat", min_quads = 16) %>%
  filter(treatment == "control") %>%
  select(year, species, abundance) %>%
  filter(year == 1994) %>%
  select(-year) %>%
  rename(abund = abundance) %>%
  select(abund) %>%
  arrange(abund) %>%
  as.matrix() %>%
  as.vector()
nspp = length(portal_sad)
nind = sum(portal_sad)

portal_sad <- data.frame(
  abund = portal_sad,
  source = "emp",
  sim = NA,
  rank = c(1:nspp)
)



## ----get a BUNCH of fs samples-------------------------------------------

set.seed(1977)

fs_bank <- sample_feasibleset(s = nspp, n = nind, nsamples = 1000000, distinct = TRUE)

save(fs_bank, file = "fs_bank_plants.Rds")

