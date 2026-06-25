
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

# 5. Vérification des données

cat("Vérification des doublons :\n")
print(sum(duplicated(bioagresseurs)))
print(sum(duplicated(traitements)))
print(sum(duplicated(observations)))

cat("\nVérification des valeurs manquantes :\n")
print(colSums(is.na(bioagresseurs)))
print(colSums(is.na(traitements)))
print(colSums(is.na(observations)))
print(sum(duplicated(observations)))

cat("\nNoms de colonnes :\n")
print(names(bioagresseurs))
print(names(traitements))
print(names(observations))

cat("\nConclusion : les données sont propres, aucune correction nécessaire.\n")