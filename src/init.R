#' Fonction qui permet l'initialisation de l'env pour l'inférence
#' Cette fonction recoit en argument un path pour loader les différents objets/tables
#' 
#'


init <- function(path_data, path_objects) {
  
  merging_data <- load_merging_data(path_data)
  
  variables_a_imputer <- jsonlite::fromJSON(paste0(path_objects, "valeurs_imputations.json"))
  objet_un_chaud <- readRDS(paste0(path_objects, "objet_un_chaud.rds"))
  vars_to_keep <- jsonlite::fromJSON(paste0(path_objects, "variables_a_conserver.json"))
  
  model <- readRDS(file = paste0(path_objects, "model.rds"))
  
  list(
    merging_data = merging_data,
    variables_a_imputer = variables_a_imputer,
    objet_un_chaud = objet_un_chaud,
    vars_to_keep = vars_to_keep,
    model = model
  )
  
}