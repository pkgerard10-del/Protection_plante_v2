
# Nettoyage des données

# 1. Vérifier les dimensions

dim(bioagresseurs)
dim(traitements)
dim(observations)

# 2. Identifier les doublons 

duplicated(bioagresseurs)        
sum(duplicated(bioagresseurs)) 

duplicated(traitements)        
sum(duplicated(traitements))

duplicated(observations)        
sum(duplicated(observations))

# 3.Identifier les valeurs manquantes

sum(is.na(bioagresseurs))        # nombre total de valeurs manquantes
colSums(is.na(bioagresseurs))    # nombre de NA par colonne

sum(is.na(traitements))        
colSums(is.na(traitements)) 

sum(is.na(observations))        
colSums(is.na(observations))

# 4.Identification des noms des colonnes des tables

names(bioagresseurs)
names(traitements)
names(observations)

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

