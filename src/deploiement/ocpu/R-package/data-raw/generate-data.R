# Generate data for inference
# Models should be imported from previous steps of the tutorial

library(usethis)
library(xgboost)
library(data.table)
library(sf)

########################
# Bixi
########################
source("../../../../src/collecte/load-merging-data.R")
source("../../../../src/init.R")
init_objects <- init(path_data = "../../../../data/", path_objects = "../../../../models/")
usethis::use_data(init_objects, internal = T, overwrite = T)
