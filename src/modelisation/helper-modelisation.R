library(glmnet)
library(caret)
# AUTRES PACKAGES -- SELON LE MODÈLE CHOISI






######################
# Modélisation - ID 15 ----------------------------------------------------
# Estimation
######################

# Fonction : glmnet::glmnet
help(glmnet)

# POUR L'INSTANT FIXÉ lambda à UNE SEULE VALEUR.
glm_basic <- glmnet(x = , y = , lambda = 0)

# Quelles-sont les options? À quelle classe "x" doit appartenir?
# (Comment faire une régression?)
# (Comment faire une classification?)



# Les coefficients beta...
coef(glm_basic)


# Faire une prédiction -- predict

predict(object = , newx = )

# Pour la classification, on a une probabilité...
# Comment faire pour la transformer en réponse binaire?








######################
# Modélisation - ID 16 ----------------------------------------------------
# Estimation -- caret
######################

on_y_reviendra <- trainControl(method="none")
glm_basic <- train(x = ,
                   y = ,
                   method = "glmnet", 
                   trControl = on_y_reviendra,
                   lambda = 0,
                   ...)








######################
# Modélisation - ID 17 ----------------------------------------------------
# Validation - sélection
######################


# lambda est particulié... Faisons le pour lambda seulement.
glm_cv <- cv.glmnet() # cv.xgboost

plot(glm_cv)
# On a un modèle par valeur de lambda
# (le nombre variables utilisé est indiqué en haut)
# Pour utiliser predict, il faut spécifier une valeur de lambda
#  avec l'option s.
predict(object = , newx = , s = une_valeur_pour_lambda) # option : s= "lambda.min"




# Difficile de gérer alpha et les autres paramètres...
# Voir le livre pour un exemple
# En gros, on doit se "fixer" des folds à réutiliser pour chaque valeurs
# de alpha testé.


# et/ou (avec caret)

# trainControl permet la validation
# cv pour cross-validation, il y a d'autres options
# 5-fold
val_setup <- trainControl(method="cv", number=5, returnResamp="all")

# Une grille pour le "grid search"
hparam_grid <- expand.grid(alpha = c(0,.5,1), # ridge, elastic net, lasso
                           lambda = seq(0.001, 0.1, 0.001)) # valeurs populaires pour lambda

# Attention, avec trop de données ça peut être long (voir impossible)
glm_cv <- train(x = ,
                y = ,
                method = "glmnet", 
                trControl = val_setup,
                tuneGrid = hparam_grid,
                ...)







######################
# Modélisation - ID 18 ----------------------------------------------------
# Évaluation finale
######################

# Comment calculeriez-vous votre erreur de généralisation?
# predict sur les données test... avec la fonction de perte qui vous intéresse



# Pour la classification : caret::confusionMatrix



# Challenge : Utilisez les graphiques de l'étape d'exploration pour
# visualiser vos erreurs...




# Modélisation - Sauvegarde du modèle final -------------------------------

# saveRDS(votre_modele, "models/model.rds")








