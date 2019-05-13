#' Programme qui entraine les modeles de A a Z
#' On fait essentiellement les etapes suivantes:
#' - Load data
#' - Split
#' - Preprocessing
#' - Entrainement
#' 
#' Parametre a changer: path_objects dans la section output
#' Ce parametre indique ou est-ce que les objets calculés seront sauvergarder
#' 

# Load les packages -------------------------------------------------------

library(sf)
library(data.table)
library(caret)
library(fst)
library(stringi)
library(lubridate)
library(xgboost)
library(glmnet)


# Source les fonctions ----------------------------------------------------

source("src/collecte/load-historical-data.R")
source("src/collecte/load-merging-data.R")
source("src/collecte/merge-data.R")


# Output les objets -------------------------------------------------------

path_objects <- "data/models/"


# Importer les données ----------------------------------------------------

# Doit avoir le fichier 'LIMADMIN.shp' dans le repertoire passer en argument
# a la fonction load_data()
historical_data <- load_historical_data("data/")
merging_data <- load_merging_data("data/")
merge_data(historical_data, merging_data$data_stations)