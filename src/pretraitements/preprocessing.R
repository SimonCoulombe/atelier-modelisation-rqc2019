#' Fonction qui fait le prétraitement des données
#' Objectif : Partir des données brutes et produire les données prêtes à
#' l'entrainement ou a la prédiction
#' 
#' data: données brutes
#' train_mode: TRUE pour entrainer le modele -> produit une liste d'objets
#' list_objects: Lors de l'entrainement on le laisse a NULL, sinon on passe la liste 
#' pour l'inférence


preprocessing <- function(data, train_mode=TRUE, list_objects=NULL) {
  
  # Nettoyer la variable quartier
  data[, `:=`(start_quartier = tolower(stri_replace_all_regex(start_quartier, "-| ", "")))]
  data[, `:=`(start_quartier = factor(gsub("[[:punct:]]", "", iconv(start_quartier, from="UTF-8", to="ASCII//TRANSLIT"))))]
  
  # TODO: Transformations des données (ID_14)
  # Creer les variables suivantes (suite a l'exploration):
  # start_wday : jour de la semaine
  # start_hour: heure de la journée
  # weekend_flag: indicateur pour la fin de semaine
  # moment_journee: regroupement de la variable start_hour
  # start_quartier_group: regroupement de la variable start_quartier
  # autres variables?
  
  # week_start: 1=Lundi 7=Dimanche
  data[, `:=`(start_wday = lubridate::wday(start_date, week_start = 1),
              start_hour = hour(start_date_time))]
  
  data[, weekend_flag := as.integer(start_wday >= 6)]
  
  data[, moment_journee := "nuit"]
  data[start_hour >= 6 & start_hour < 11, moment_journee := "matin"]
  data[start_hour >= 11 & start_hour < 16, moment_journee := "journee"]
  data[start_hour >= 16 & start_hour < 23, moment_journee := "soir"]
  data[, moment_journee := factor(moment_journee)]
  
  # Regrouper les quartiers (basé sur l'analyse de données)
  data[start_quartier == "leplateaumontroyal", start_quartier_group := "plateau_mont_royal"]
  data[start_quartier == "villemarie", start_quartier_group := "ville_marie"]
  data[start_quartier %in% c("ahuntsiccartierville", "villeraysaintmichelparcextension", "mercierhochelagamaisonneuve", "rosemontlapetitepatrie"), start_quartier_group := "nord_est"]
  data[start_quartier %in% c("outremont", "cotedesneigesnotredamedegrace", "westmount", "lesudouest", "verdun", "lasalle"), start_quartier_group := "sud_ouest"]
  data[, start_quartier_group := factor(start_quartier_group)]
  
  
  if (train_mode) {
    
    # TODO: Definir la variable reponse
    
    # classif: 
    # data[, target := as.integer(start_station_code == end_station_code)]
    # regression: 
    setnames(data, "duration_sec", "target")
    
    
    
    # TODO: Traitement des données aberrantes (ID: 12)
    # A decommenter pour la regression seulement
    
    # valeur_max_outlier <- mean(data$target) + 3 * sd(data$target)
    # print(paste(length(which(data$target >= valeur_max_outlier | data$target <= 0)), 
    #             "outliers ont été enlevés du jeu de données de régression."))
    # data <- data[which(data$target <= valeur_max_outlier & data$target >= 0)]

    
    
    # TODO: Implémentation de l'imputation (ID: 11)
    # Calculer (ou définir) les valeurs les valeurs d'imputation à appliquer aux données manquantes
    # Stocker ces valeurs dans une liste:
    
    variables_a_imputer <- list()
    variables_a_imputer["start_quartier"] <- "autre"
    variables_a_imputer["start_quartier_group"] <- "autre"
    
    # TODO: Imputer les données manquantes (ID: 11)
    # Iterer sur la liste pour remplacer les données manquantes par la valeur stockée dans la liste
    
    for (col in names(variables_a_imputer)){
      data[is.na(get(col)), (col) := variables_a_imputer[[eval(col)]]]
    }
    

    # TODO: Faire le traitement des données catégoriques(ID: 13)
    # Creer un objet a partir de la fonction caret::dummyVars pour one-hot encoder les variables à transformer
    # Apres avoir calculer l'objet, faire le predict sur le data et merger ces données avec le reste des données (sans les variables one-hot encoder)
    
    objet_un_chaud <- dummyVars(as.formula("~ start_quartier_group + moment_journee"), data,
                                fullRank = TRUE)
    data <- cbind(
      predict(objet_un_chaud, data),
      copy(data)[, (c("start_quartier_group", "moment_journee")) := NULL]
    )
    
    
    # Definir les varibles a conserver lors de la prédiction
    vars <- c("target", "is_member", "weekend_flag")
    vars <- c(vars, grep("start_quartier_group|moment_journee", colnames(data), value = TRUE))
    
    # Output de la fonction doit etre une liste contenant ces objets
    list(
      data_preprocess = data[, ..vars], #garder les variables spécifiées
      variables_a_imputer = variables_a_imputer,
      objet_un_chaud = objet_un_chaud, #object permettant de faire la transformation one-hot
      vars_to_keep = vars[-which(vars %in% c("target"))]
    )
    
  } else {
    
    # TODO: Imputer les données manquantes (ID: 11)
    # Iterer sur la liste pour remplacer les données manquantes par la valeur stockée dans la liste
    
    variables_a_imputer <- list_objects$variables_a_imputer
    for (col in names(variables_a_imputer)){
      data[is.na(get(col)), (col) := variables_a_imputer[[eval(col)]]]
    }
    
    
    # TODO: Faire le traitement des données catégoriques(ID: 13)
    
    objet_un_chaud <- list_objects$objet_un_chaud
    data <- cbind(
      predict(objet_un_chaud, data),
      copy(data)[, (c("start_quartier_group", "moment_journee")) := NULL]
    )
    
    
    # Retourner les données pretraitées
    vars <- list_objects$vars_to_keep
    data[, ..vars]
    
  }
  
}