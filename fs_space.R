## ----setup---------------------------------------------------------------
library(dplyr)
library(scads)
library(ggplot2)


## ----get an SAD----------------------------------------------------------
portal_data <- isds::get_toy_portal_data(download=T, years = c(1990:1995))

portal_sad <- portal_data %>%
  select(species) %>%
  group_by(species) %>%
  summarize(abund = n()) %>%
  ungroup() %>%
  select(abund) %>%
  arrange(abund) %>%
  as.matrix() %>%
  as.vector()

nspp = length(portal_sad)
nind = sum(portal_sad)

portal_sad <- data.frame(
  abund = portal_sad,
  source = "emp",
  rank = 1:length(portal_sad)
)



## ----get a BUNCH of fs samples-------------------------------------------

set.seed(1977)

fs_bank <- sample_feasibleset(s = nspp, n = nind, nsamples = 100, distinct = TRUE)

save(fs_bank, file = "fs_bank_small.Rds")

