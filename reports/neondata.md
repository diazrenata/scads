Investigating NEON data
================

### Aquatic plants

``` r
ap_path <- here::here("reports", "datasets", "neon", "aquatic_plants")
ap_path <- file.path(ap_path, list.dirs(ap_path, full.names = FALSE, recursive = F)[ which(nchar(list.dirs(ap_path, full.names = FALSE, recursive = F)) > 2)]) 
vars <- read.csv(file.path(ap_path, "stackedFiles", "variables.csv"), stringsAsFactors = F)
pointTrans <- read.csv(file.path(ap_path, "stackedFiles", "apc_pointTransect.csv"), stringsAsFactors = F)
perTaxon <- read.csv(file.path(ap_path, "stackedFiles", "apc_perTaxon.csv"), stringsAsFactors = F)


goodSamples <- pointTrans %>%
  filter(is.na(samplingImpractical),
         is.na(dataQF),
         targetTaxaPresent == "Y")

perTaxonPropSpecies <- perTaxon %>%
  filter(eventID %in% goodSamples$eventID) %>%
  select(siteID, namedLocation, eventID, taxonID, class, order, family, genus, specificEpithet) %>%
  group_by(siteID,eventID, namedLocation, taxonID, class, order, family, genus) %>%
  summarize(nobs = n(),
            nspp = sum((specificEpithet == "sp."))) %>%
  ungroup()
```

I'm not really convinced the aquatic plant data is appropriate. This is because \* It appears to be point presence/absence at points in a transect, which are often low and not really abundance counts \* A lot of the taxa are nonspecific, like "PLANT2". Also, things are often not identified to species (specificEpithet = "sp."), and I'm not sure how to differentiate between different unknown species in the same genus.

It might be fine! But I'm not confident in it after a little bit of poking.

``` r
rm(ap_path)
rm(vars)
rm(pointTrans)
rm(perTaxon)
rm(goodSamples) 
rm(perTaxonPropSpecies)
```