
--------------------------------------------------------------------------------

# Exportation des resultats et graphiques  
  
--------------------------------------------------------------------------------
  
# 1. Création de dossier d'export d'exportation resultats

if(!dir.exists("exports")) dir.create("exports")

library(openxlsx)
wb <- createWorkbook()

## Résumé bioagresseurs

addWorksheet(wb, "Resume_Bioagresseurs")
writeData(wb, "Resume_Bioagresseurs", summary(bioagresseurs))

## Résumé traitements

addWorksheet(wb, "Resume_Traitements")
writeData(wb, "Resume_Traitements", summary(traitements))

# Résumé observations

addWorksheet(wb, "Resume_Observations")
writeData(wb, "Resume_Observations", summary(observations))

## Résultats ANOVA

### Résumé ANOVA
anova_summary <- summary(anova_result)

### Extraire le premier élément (le tableau des résultats)
anova_table <- anova_summary[[1]]

### Convertir en data.frame
anova_df <- as.data.frame(anova_table)

### Exporter vers Excel
writeData(wb, "ANOVA", anova_df)

## Résultats Newman–Keuls

addWorksheet(wb, "Newman_Keuls")
writeData(wb, "Newman_Keuls", snk_result$groups)

## Sauvegarde du fichier Excel

saveWorkbook(wb, "exports/Analyse_Resultats.xlsx", overwrite = TRUE)


# 2. Créer un dossier d'export pour les graphiques

if(!dir.exists("exports")) dir.create("exports")

## Exporter barplot bioagresseurs par type

png("exports/barplot_bioagresseurs.png", width = 800, height = 600)
barplot(table(bioagresseurs$type_bioagresseur),
        main = "Répartition des bioagresseurs par type",
        xlab = "Type de bioagresseur",
        ylab = "Nombre",
        col = "blue", las = 2)
dev.off()

## Exporter courbe temporelle des traitements

png("exports/traitements_temps.png", width = 800, height = 600)
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
dev.off()

## Exporter cercle ACP

png("exports/acp_cercle.png", width = 800, height = 600)
fviz_pca_var(res_pca,
             col.var = "cos2",
             gradient.cols = c("red","yellow","green"),
             repel = TRUE,
             title = "Cercle des corrélations - ACP")
dev.off()

## Export cammerbert

## 1. Exporter en PNG

png("exports/camembert_bioagresseurs.png", width = 800, height = 600)
pie(freq,
    main = "Répartition des bioagresseurs par type",
    col = rainbow(length(freq)))
dev.off()

## 2. Exporter en PDF (optionnel)

pdf("exports/camembert_bioagresseurs.pdf", width = 8, height = 6)
pie(freq,
    main = "Répartition des bioagresseurs par type",
    col = rainbow(length(freq)))
dev.off()


