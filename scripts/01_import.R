
# Chargement des packages

library(readxl) 

# Importer un fichier Excel depuis le dossier data

bioagresseurs <- read_excel("data/bioagresseurs.xlsx")
traitements   <- read_excel("data/traitements.xlsx")
observations  <- read_excel("data/observations.xlsx")

# Visualisaton des fichiers

View(bioagresseurs)
View(traitements)
View(observations)
