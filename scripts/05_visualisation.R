
# Visualisation des resultats

#-------packages-------------

library(dplyr)
library(ggplot2)
library(agricolae)
library(FactoMineR)
library(factoextra)

## Barplots pour les fréquences

### Bioagresseurs par type

barplot(table(bioagresseurs$type_bioagresseur),
        main = "Répartition des bioagresseurs par type",
        xlab = "Type de bioagresseur",
        ylab = "Nombre",
        col = "blue",
        las = 2)

##  Courbes temporelles

### Évolution des traitements dans le temps

traitements %>%
  mutate(date_traitement = as.Date(date_traitement),
         mois = format(date_traitement, "%Y-%m")) %>%
  count(mois) %>%
  ggplot(aes(x = mois, y = n, group = 1)) +
  geom_line(color = "green") +
  geom_point(color = "darkgreen") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Nombre de traitements par mois",
       x = "Mois", y = "Nombre de traitements")

## Boxplots pour comparer les moyennes

### Efficacité selon la méthode d’application

boxplot(efficacite_14j_pct ~ methode_application, data = traitements,
        main = "Efficacité des traitements selon la méthode",
        xlab = "Méthode d'application",
        ylab = "Efficacité à 14 jours (%)",
        col = "blue")
## Histogrammes

### Distribution du taux d’infestation

hist(observations$taux_infestation_pct,
     main = "Distribution du taux d’infestation",
     xlab = "Taux d’infestation (%)",
     col = "green", breaks = 10)

## Visualisation des résultats post-hoc (Newman–Keuls)

anova_result <- aov(efficacite_14j_pct ~ methode_application, data = traitements)
snk_result <- SNK.test(anova_result, "methode_application", group = TRUE)

bar.group(snk_result$groups,
          main = "Comparaison des méthodes d'application",
          xlab = "Méthode",
          ylab = "Efficacité moyenne (%)")

## Camemberts (diagrammes circulaires)

###  répartition des bioagresseurs par type

freq <- table(bioagresseurs$type_bioagresseur)   # Comptage par type

pie(freq,
    main = "Répartition des bioagresseurs par type",
    col = rainbow(length(freq)))                          # Camembert

## ACP (Exemple sur le tableau traitements)

res_pca <- PCA(traitements[, c("dose_L_ha", "volume_bouillie_L_ha",
                               "efficacite_7j_pct", "efficacite_14j_pct",
                               "cout_fcfa_ha")],
               scale.unit = TRUE, graph = FALSE)

fviz_pca_biplot(res_pca,
                repel = TRUE,
                col.var = "black",          # Visualisation
                col.ind = "gray")

## Autre ACP 

### Sélection des variables quantitatives dans traitements

donnees <- traitements[, c("dose_L_ha", "volume_bouillie_L_ha",
                           "efficacite_7j_pct", "efficacite_14j_pct",
                           "cout_fcfa_ha")]

res_pca <- PCA(donnees, scale.unit = TRUE, graph = FALSE)  # ACP

### Cercle des corrélations

fviz_pca_var(res_pca,
             col.var = "blue",     # couleur des variables
             repel = TRUE,              # évite le chevauchement des labels
             title = "Cercle des corrélations - ACP")








