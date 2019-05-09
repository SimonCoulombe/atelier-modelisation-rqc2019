# Modélisation prédictive avec R dans un contexte de production - De l’extraction au déploiement

Cet atelier est présenté dans le cadre de l'événement R à Québec 2019. Ce dépôt servira de base pour que les participants puissent développer leurs programmes.

## Prérequis

Pour l'atelier, nous demandons d'avoir les logiciels suivants:

- [R](http://cran.utstat.utoronto.ca/) (>= 3.5.0)
- [RStudio](https://www.rstudio.com/products/rstudio/download/) (>= 1.0.0)
- [Docker](https://runnable.com/docker/getting-started/)

Nous demandons également d'avoir la liste de packages R suivants d'installés avant la journée de l'événement:

- sf
- data.table
- lubridate
- scales
- ggplot2
- caret
- jsonlite
- glmnet
- xgboost
- magrittr
- dplyr
- tibble
- rgdal
- leaflet
- stringi
- purrr
- plotly
- class
- plumber
- opencpu

Notez que certains de ces packages peuvent demander des installations de librairies de système. Voir les documentations des packages au besoin.

## Démarrage

Nous vous recommendons de partir de cette structure pour les programmes que vous allez développer durant l'atelier. Pour télécharger le dépôt, vous pouvez cliquer sur le bouton "Clone or download" et sur "Download ZIP" pour télécharger le contenu sur votre ordinateur.

Pour ceux qui sont familiers avec Git, vous pouvez cloner le dépot:

```
git clone https://github.com/dot-layer/atelier-modelisation-rqc2019.git
```

## Structure du dépôt

```
├── README.md          <- Document de haut-niveau pour l'atelier.
│
├── data               <- Dossier contenant les données téléchargées localement.
│
├── models             <- Dossier contenant les objets sauvegardés lors de l'entraînement.
│
├── src                <- Codes source utilisé dans le projet.
│   │
│   ├── extraction     <- Codes source qui font l'extraction et la collecte de données.
│   │
│   ├── exploration    <- Codes source qui font l'exploration des données.
│   │
│   ├── pretraitements <- Codes source qui font le prétraitements des données.
│   │
│   ├── modelisation   <- Codes source qui font l'entraînement et le diagnostic des modèles.
│   │
│   └── deploiement    <- Codes source qui font le déploiement du modèle.
│ 
└── atelier-modelisation-rqc2019.Rproj  <- Projet RStudio.
```
