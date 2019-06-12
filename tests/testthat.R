library(testthat)
library(scads)
test_dir("testthat", reporter = c("check", "progress"))
test_check("scads")
