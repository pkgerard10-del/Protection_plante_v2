
# Statistique descriptive

# -----------Chargement des extensions ------------------------:

library(dplyr)
library(agricolae)

# 1.Nombre de parametres 

nrow(bioagresseurs)
nrow(traitements)
nrow(observations)

# 2.Resumé statistique

summary(bioagresseurs)
summary(traitements)
summary(observations)

# Analyse des fréquences 

## Analyse sur les bioagresseurs

## 1. Comptage des bioagrsseurs par type_bioagresseur

table(bioagresseurs$type_bioagresseur)

## 2.Nombre de bioagresseurs par culture hôte

table(bioagresseurs$cultures_hotes)

## 3.Distribution des seuils d’intervention

hist(bioagresseurs$seuil_intervention_pct,
     main = "Distribution des seuils d’intervention",
     xlab = "Seuil (%)", col = "lightblue")

## Analyse sur le traitements

## 1. Produits les plus utilisés

table(traitements$produit_utilise)

## 2.Efficacité moyenne des traitements

mean(traitements$efficacite_7j_pct)
mean(traitements$efficacite_14j_pct)

## 3.Coût moyen par hectare

mean(traitements$cout_fcfa_ha)

## 4.Relation entre produit et efficacité

traitements %>%
  group_by(produit_utilise) %>%
  summarise(efficacite_moyenne = mean(efficacite_14j_pct))

## Analyses possibles sur observations

## 1. Cultures les plus observées

table(observations$culture)

## 2.Taux moyen d’infestation

mean(observations$taux_infestation_pct)

## 3.Distribution de la sévérité

table(observations$`severite (1-5)`)

## 4.Lien entre culture et bioagresseur

observations %>%
  group_by(culture, id_bioagresseur) %>%
  summarise(nb = n())

# Analyse parametrique

## Comparaison de moyennes (tests t)

###. Exemple : comparer l’efficacité des traitements à 7 jours vs 14 jours

t.test(traitements$efficacite_7j_pct, traitements$efficacite_14j_pct, paired = TRUE)


## . ANOVA (analyse de variance)

### Exemple : comparer l’efficacité moyenne selon la méthode d’application

anova_result <- aov(efficacite_14j_pct ~ methode_application, data = traitements)
summary(anova_result)

snk_result <- SNK.test(anova_result, "methode_application", group = TRUE)  # Test de Newman–Keuls
print(snk_result$groups) # Afficher les résultats 

## Corrélations

### Exemple : relation entre dose et efficacité

cor(traitements$dose_L_ha, traitements$efficacite_14j_pct, method = "pearson")

## Régression linéaire

### Exemple : prédire l’efficacité en fonction de la dose et du volume de bouillie

modele <- lm(efficacite_14j_pct ~ dose_L_ha + volume_bouillie_L_ha, data = traitements)
summary(modele)

## Comparaison de taux d’infestation par culture

###  Exemple : ANOVA sur observations

anova_infest <- aov(taux_infestation_pct ~ culture, data = observations)
summary(anova_infest)








































