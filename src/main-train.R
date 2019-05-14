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
source("src/pretraitements/preprocessing.R")


# Output les objets -------------------------------------------------------

path_objects <- "models/"


# Importer les données ----------------------------------------------------

# Doit avoir le fichier 'LIMADMIN.shp' dans le repertoire passer en argument
# a la fonction load_data()
historical_data <- load_historical_data("data/")
merging_data <- load_merging_data("data/")
merge_data(historical_data, merging_data$data_stations)


# Séparer les données -----------------------------------------------------

ind_test <- sample(nrow(historical_data), 0.25 * nrow(historical_data))


# Prétraitements de données -----------------------------------------------

# Faire le pretraitements des données d'entrainement en appelant la fonction: preprocessing()
# On veut rouler le prétraitement en mode entrainement
# Le ouput de la fonction est une liste d'objets qu'on doit stocker dans "data_preprocessed"


# Sauvergarder les objets calculés à l'étape précédente
# write(jsonlite::toJSON(data_preprocessed$variables_a_imputer, pretty = TRUE), paste0(path_objects, "valeurs_imputations.json"))
# saveRDS(data_preprocessed$objet_un_chaud, paste0(path_objects, "objet_un_chaud.rds"))
# write(jsonlite::toJSON(data_preprocessed$vars_to_keep, pretty = TRUE), paste0(path_objects, "variables_a_conserver_classif.json"))


# Definir les matrices de données et réponses pour le modele
# X_train <- copy(data_preprocessed$data_preprocess)[, target := NULL]
# y_train <- data_preprocessed$data_preprocess$target
# 
# X_test <- preprocessing(historical_data[ind_test,],
#                         train_mode = FALSE,
#                         list_objects = list(variables_a_imputer = data_preprocessed$variables_a_imputer,
#                                             objet_un_chaud = data_preprocessed$objet_un_chaud,
#                                             vars_to_keep = data_preprocessed$vars_to_keep))
# y_test <- as.integer(historical_data[ind_test,]$start_station_code == historical_data[ind_test,]$end_station_code)



# Modelisation ------------------------------------------------------------







