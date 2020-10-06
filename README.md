# Getting-and-Cleaning-Data-Course-Project
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set

El script "run_analysis.R" esta dividido de la siguiente forma:
  - 0. Getting data
  - Cleaning data
    1. Juntar los archivos en un solo data set
    2. Extraer solo las variables de las medidas requeridas
    3. Configurar los nombres descriptivos de las actividades
    4. Configurar los nombres descriptivos de las variables de las medidas
    5. Crear un "data set tidy" final con los promedios de las variables
  - Crear el archivo .txt final para la entrega.
  
Para el paso 0 tenemos lo siguiente:
- Inicialmente se carga la libreria "dplyr", que se utilizará en el paso 4 y 5
- Se obtienen la información requerida mediante el link dado, se baja localmente 
  en el archivo "data.zip" y se descomprime el .zip.
- La descompresión crea la carpeta "UCI HAR Dataset" en el directorio de trabajo
- Lo primero que se realiza es pasar los archivos txt a tablas guardadas localmente
  subtest, xtest, ytest, subtrain, xtrain y ytrain.
  
Para el paso 1 tenemos lo siguiente:
- Agrupamos las tablas de test en "temp1"
- Agrupamos las tablas de train en "temp2"ç
- Agrupamos todo en la variable "finaldf" con una dimension de 10299 x 563

Para el paso 2 tenemos lo siguiente:
- Con base el archivo dado "features.txt" creamos la variable "namesdf"
- Creamos la variable "namesdf3" que contiene los nombres de las columnas
- Una vez la información esta con los nombres de las columnas, procedemos a realizar
  el filtro de las columnas requeridos ("mean()" y "std()") y guardada en la variable "tidydf"
  
Para el paso 3 tenemos lo siguiente:
- Con base en el archivo dado "activity_labels.txt" se crea la variable "namesact"
  que contiene los nombres de las actividades.
- Se crea la variable "tidydf4" con el match entre "namesact" y "tidydf", esto con
  el fin de obtener la columna original de "tiydf" pero con los nombres del archivo
  "activity_labels.txt"
- Se cambia la colunma de tidydf$V1_Activity por la columna tidydf4$V1_Activity

Para el paso 4 tenemos lo siguiente:
- Se crea la variable finaltidydf donde se tiene el dato ya organizado y se cambian
   las nombres de todas las columnas bajo el sigueinte criterio:
   - Quitar los "-"
   - Cambiar la "t" del principio del nombre por "Time."
   - Cambiar la "f" del principio del nombre por "Freq." 
   - Eliminar los "()"
   - Cambiar "mean" por ".mean." y "std" por ".std.", para que el nombre quede 
     separado por puntos.
      
Para el paso 5 tenemos lo siguiente:
- Se crea la variable "finaltidy2" que sale del punto 4
- Se agrupa "finaltidy2" por la primera columna y luego por la segunda columna, 
  conservando la agrupación inicial.
- Se sumariza "finaltidy2" y se genera el "mean" por variable

Finalmente se crear el archivo "finaltidy2.txt" como salida del programa, en el 
directorio raiz de trabajo.


    