
## Sobre este repositorio
Este repositorio contiene los scripts y el panel de genes utilizados para la priorización de variantes genéticas en exomas en el TFM del Máster en Genómica y Genética de la Universidade de Santiago de Compostela realizado por Paula Boix Martorell.

## Contenido
- **script_priorización_general.R**: Script para la priorización general de variantes genéticas.

     Aplica sobre cada archivo de variantes genéticas un filtrado basado en genes candidatos, frecuencia poblacional, profundidad de lectura, base de datos interna y tipo de variante, que se detallan en el script. Guarda en una carpeta los archivos de variantes genéticas filtrados y un archivo de texto con la media de variantes genéticas restantes tras cada paso de filtrado en cada uno de los exomas.
- **script_priorización_ClinVar.R**: Script para la priorización de variantes genéticas según su patogenicidad en ClinVar.

    Aplica sobre cada archivo de variantes genéticas un filtrado basado en genes candidatos y la patogenicidad de las variantes en ClinVar, que se detallan en el script. Guarda en una carpeta los archivos de variantes filtrados y un archivo de texto con la media de variantes genéticas restantes tras cada paso de filtrado en cada uno de los exomas.
- **panel_536_genes.txt**: Archivo de texto que contiene un listado de 536 genes asociados a cardiopatías.

## Dependencias
Los scripts están escritos en R versión 4.3.2. Es necesario instalar en R la librería `dplyr` antes de ejecutar los scripts.

Los archivos de variantes sobre los que se realizará la priorización deben contener los campos *Gene.RefSeq*, *MaxPopFreq*, *Depth*, *vardb_Illumina_DRAGEN* y *Annotation.RefSeq* para ejecutar script_priorización_general.R, y los campos *Gene.RefSeq* y *ClinVar_Significance* para ejecutar script_priorización_ClinVar.R.

## Uso de los scripts
1. **Configurar los directorios**. Asegurarse de que las rutas especificadas al inicio del script de los siguientes directorios son las adecuadas, y modificarlas si es necesario.
- `directorioDeExomas`. Este directorio debe contener los archivos de variantes genéticas de los exomas a analizar. 
Ejemplo en el script: 

    ```
    directorioDeExomas <- "D:/Paula/Exomas_Cardiotox/hg38"
    ```
- `genes_a_filtrar`. Este directorio debe contener el archivo "panel_536_genes.txt". 
Ejemplo en el script: 
    ```
    directorioDeExomas <- "genes_a_filtrar <- readLines("C:/Users/Paula Boix Martorell/OneDrive - Universitat de Valencia/Classe/MGG/TFM/panel_536_genes.txt")"
    ```
2. **Nombrar la carpeta de salida**. El nombre dado a la variable `carpetaDeFiltrado` será el nombre de la carpeta que se creará en el mismo directorio especificado para `directorioDeExomas` donde se guardarán los archivos de salida. Ejemplos en los scripts:

    script_priorización_general.R :
    ```
    carpetaDeFiltrado <- "filtrado_general_total"
    ```
    script_priorización_ClinVar.R :
    ```
    carpetaDeFiltrado <- "filtrado_patogenicidad_ClinVar"
    ```
3. **Ejecutar el script en R**. Para ello, utilizar la función `source()` en la consola de R especificando la ruta al directorio donde se encuentra el script. 

    Ejemplo: `source("C:\Users\Paula\Scripts\script_priorización_general.R")`
