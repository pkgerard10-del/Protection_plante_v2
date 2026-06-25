
#-------------------------------------------------------------------
# SCRIPT DE GESTION DES DONNÉES : PROTECTION DES PLANTES
# Objectif : Importation des données pour analyse
# Développeur : KAKOU-ANINI Tano-Paka Gerard
# Date : 25 Juin 2026
#-----------------------------------------------------------------


# Installation & chargement packages

install.packages("readxl")
install.packages("writexl")
library(readxl)
library(writexl)

# Importation des données brutes du bureau vers R

bioagresseurs <- read_excel("C:/Users/administrateur local/Desktop/Données à analyser/protection_plantes_v2.xlsx",sheet = "bioagresseurs")
traitements <- read_excel("C:/Users/administrateur local/Desktop/Données à analyser/protection_plantes_v2.xlsx",sheet = "traitements")
observations <- read_excel("C:/Users/administrateur local/Desktop/Données à analyser/protection_plantes_v2.xlsx",sheet = "observations")

# Lecture des données importées

View(bioagresseurs)
View(traitements)
View(observations)

# Enregistrement de mes données dans le sous dossier data

write_xlsx(bioagresseurs, path = "Protection_plante_v2/data/bioagresseurs.xlsx")
write_xlsx(traitements, path = "Protection_plante_v2/data/traitements.xlsx")
write_xlsx(observations, path = "Protection_plante_v2/data/observations.xlsx")

# Lecture des 3 fichiers Excel depuis le sous-dossier data

bioagresseurs <- read_excel("Protection_plante_v2/data/bioagresseurs.xlsx")
traitements   <- read_excel("Protection_plante_v2/data/traitements.xlsx")
observations  <- read_excel("Protection_plante_v2/data/observations.xlsx")

# Visualisation des 3 fichiers depuis le sous-dossier data

head(bioagresseurs)
head(traitements)
head(observations)
