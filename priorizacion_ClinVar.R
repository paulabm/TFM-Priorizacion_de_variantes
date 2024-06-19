
library(dplyr)

directorioDeExomas <- "D:/Paula/Exomas_Cardiotox/hg38" # directorio donde están los exomas a analizar
setwd(directorioDeExomas)
listado_archivos <- list.files(directorioDeExomas, "*tab")
carpetaDeFiltrado <- "filtrado_patogenicidad_ClinVar" # directorio donde se guardarán los archivos de variantes tras la priorización
dir.create(carpetaDeFiltrado)
genes_a_filtrar <- readLines("C:/Users/Paula Boix Martorell/OneDrive - Universitat de Valencia/Classe/MGG/TFM/panel_536_genes.txt") # directorio del archivo del panel de genes

# Crear un dataframe para almacenar los resultados
resultados <- data.frame(Muestra = character(),
                         Total = numeric(),
                         Genes = numeric(),
                         Patogenicidad_ClinVar = numeric())

for (fichero in listado_archivos) { 
  priorizacion <- read.table(fichero, header=TRUE, sep="\t", quote="", fill=FALSE)
  
  # Calcular el número total de variantes en el archivo
  totalVariantesPorArchivo <- nrow(priorizacion)
  
  # Filtrar por el panel de genes
  objeto_genes <- priorizacion %>%
    filter(grepl(paste0("\\b(", paste(genes_a_filtrar, collapse = "|"), ")\\b"), Gene.RefSeq)) 
	
	# Filtrar por la clasificación en ClinVar
	objeto_clinvar <- objeto_genes %>%
	  filter(grepl("Pathogenic", ClinVar_Significance) | grepl("Likely Pathogenic", ClinVar_Significance))
	
	# Extraer el nombre de la muestra a partir del nombre del archivo
	nombre_muestra <- gsub("^(CTOX_[0-9]+)\\.split\\.tab", "\\1", fichero)
	
	# Crear una línea de resultados para esta muestra
	linea_resultado <- data.frame(Muestra = nombre_muestra, # "linea_resultado" es un dataframe que contiene los resultados específicos de un archivo individual tras el filtrado
	                              Total = totalVariantesPorArchivo, 
	                              Genes = nrow(objeto_genes), 
	                              Patogenicidad_ClinVar = nrow(objeto_clinvar))
	
	# Agregar los resultados al dataframe general 
	resultados <- bind_rows(resultados, linea_resultado) # "resultados" es el dataframe que almacena los resultados de todos los archivos procesados hasta el momento
	
	# Escribir los resultados en un archivo
	write.table(objeto_clinvar, quote=FALSE, sep="\t", row.names = FALSE,
	            file=paste(carpetaDeFiltrado, gsub(".tab", ".filtrado.tab", fichero), sep = "/"))
}

# Escribir los resultados en un archivo
write.table(resultados, file = paste(carpetaDeFiltrado, "resultados_numero_variantes.txt", sep="/"), sep="\t", quote=FALSE, row.names = FALSE)
