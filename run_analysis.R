# Getting and cleaning data course project.

# O. Getting - Obtener la informacion base con la que se trabajara el proyecto:
  
  # La primera parte es obtener la información dada por medio de un enlace dado, el cual se observa
  # que termina en .zip, por lo que primero se baja con la funcion download.file() y se guarda el
  # archivo localmente. Finalmente se descomprime el archivo con la funcion unzip()
library(dplyr) # Libreria adicional utilizada en el script
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./data.zip", method = "curl")
unzip(zipfile = "data.zip", exdir = "./")
  
  # Una vez obtenido los archivos, se guardan en variables locales para su manipulación. 
testfile <- list.files(path = "./UCI HAR Dataset/test", pattern = ".*\\.txt")
setwd("./UCI HAR Dataset/test")
subtest <- read.table(testfile[1])
xtest <- read.table(testfile[2])
ytest <- read.table(testfile[3])
setwd("../")
trainfile <- list.files(path = "./train", pattern = ".*\\.txt")
setwd("./train")
subtrain <- read.table(trainfile[1])
xtrain <- read.table(trainfile[2])
ytrain <- read.table(trainfile[3])
setwd("../"); setwd("../")
  # El proceso de "getting" nos da como resultado 6 variables "subtest", "xtest", "ytest", "subtrain",
  # "xtraain" y "ytrain" con la información requerida.

# Cleaning. Una vez obtenida la información y guardada en variables, se procede con la limpieza respectiva:
  
  # 1. El primer paso es juntar los 3 archivos en uno solo por cada set, "test" y "train", luego se juntan
  # en un solo "finaldf", sobre el cual se procede a la extracción de la información requerida
tem1 <- cbind(subtest, ytest, xtest)
tem2 <- cbind(subtrain, ytrain, xtrain)
finaldf <- rbind(tem1, tem2)

  # 2. Se extrae solo las medidas correspondientes a "mean" y "standard deviation" de "finaldf"
  # Se utiliza el archivo "features.txt" para extraer las columnas con "mean()" o "std()"
setwd("./UCI HAR Dataset")
namesdf <- read.table("features.txt")
setwd("../")
namesdf2 <- namesdf[,"V2"]
namesdf3 <- c("V1Sub", "V1_Activity", namesdf2)
colnames(finaldf) = namesdf3
tidydf1 <- select(finaldf, contains("mean()"))
tidydf2 <- select(finaldf, contains("std()"))
tidydf3 <- select(finaldf, contains("V1"))
tidydf <- cbind(tidydf3, tidydf1, tidydf2)

  # 3. Nombres descriptivos. Se cambia los ID por los nombres descriptivos dados en el archivo
  # "activity_labels.txt
setwd("./UCI HAR Dataset")
namesact <- read.table("activity_labels.txt")
setwd("../")
tidydf4 <- tidydf
tidydf4[] <- namesact$V2[match(unlist(tidydf), namesact$V1)]
tidydf$V1_Activity <- tidydf4$V1_Activity

  # 4. Nombres decriptivos de las diferentes actividades.
finaltidydf <- tidydf
names(finaltidydf) <- gsub("-", "", names(finaltidydf))
names(finaltidydf) <- gsub("^t","Time.",names(finaltidydf))
names(finaltidydf) <- gsub("^f","Freq.",names(finaltidydf))
names(finaltidydf) <- gsub("[:():]","",names(finaltidydf))
names(finaltidydf) <- gsub("mean",".mean.",names(finaltidydf))
names(finaltidydf) <- gsub("std",".std.",names(finaltidydf))

  #5. Segundo "data set tidy" con los promedios de las variables.
finaltidy2 <- finaltidydf
finaltidy2 <- group_by(finaltidy2, V1Sub)
finaltidy2 <- group_by(finaltidy2, V1_Activity, .add = TRUE)
finaltidy2 <- summarise_each(finaltidy2, mean)

# Crear el archivo .txt del paso 5 para envio.
write.table(finaltidy2, file = "./finaltidy2.txt", row.names = FALSE, sep = " ")
