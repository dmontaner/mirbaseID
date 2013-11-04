##e020_mirbase_id_conversion.r
##2012-12-16 dmontaner@cipf.es
##conversion de los identificadored de mirBASE a la ultima version

###NOTA del readme de mirBASE
## ftp://mirbase.org/pub/mirbase/CURRENT/README

## The database_files/ directory contains dumps of the MySQL relational
## database that is used to generate the web pages.  The documentation
## for this subset of files is non-existent - use at your peril!

##los hsa son los miRBase ID(s)
##los MIMAT0000001 son los miRBase Accession(s)

## we use compress = "xz" when saving the data

date ()
Sys.info ()[c("nodename", "user")]
commandArgs ()
rm (list = ls ())
R.version.string #"R version 2.14.2 (2012-02-29)"

try (source ("job.r")); try (.job)

################################################################################

setwd (file.path (.job$dir$tmp))
dir ()

directorios <- 11:20


###EXPLORAMOS                    el unico que parece que da problemas es el 19
for (i in directorios) {
  cat ("\n")
  print (paste ("======", i , "======"))
  fichero <- file.path (i, "mirna_mature.txt")
  ##
  datos <- read.table (file = fichero, header = FALSE, sep = "\t", quote = "", as.is = TRUE)
  #print (datos[1:3,])
  ##
  accesion.col <- grep ("MIMAT", datos)
  id.col       <- grep ("hsa-",  datos)
  ##
  print (paste ("Accesion Col:", accesion.col))
  print (paste ("ID Col:", id.col ))
}  


###Extraemos todos los Accesion
all.ac <- NULL
for (i in directorios) {
  cat ("\n")
  print (paste ("======", i , "======"))
  fichero <- file.path (i, "mirna_mature.txt")
  ##
  datos <- read.table (file = fichero, header = FALSE, sep = "\t", quote = "", as.is = TRUE)
  ##
  accesion.col <- print (grep ("MIMAT", datos))
  if (length (accesion.col) > 1) stop ("problema: mas de una columna con Accesion")
  
  print (paste (length (setdiff (datos[,accesion.col], all.ac)), "new Accesions"))

  all.ac <- sort (unique (c (all.ac, datos[,accesion.col])))
}  

length (all.ac)

################################################################################


###MATRIZ DE CONVERSION
mirIDmat <- matrix (NA, nrow = length (all.ac), ncol = length (directorios))
colnames (mirIDmat) <- paste ("mirBase", directorios, sep = "")
rownames (mirIDmat) <- all.ac
mirIDmat[1:3,]

###CONVERSIONES
for (i in 11:18) {
  cat ("\n")
  print (i)
  ##
  fichero <- file.path (i, "mirna_mature.txt")
  datos <- read.table (file = fichero, header = FALSE, sep = "\t", quote = "", as.is = TRUE)
  print (datos[1:3,])
  ##
  datos <- datos[,c(3,2)]
  colnames (datos) <- c("ac", "id")
  datos <- unique (datos)
  print (datos[1:3,])
  ##
  if (sum (is.na (datos)) != 0) stop ("hay NAs")
  if (sum (datos == "")   != 0) stop ("hay Vacios")
  ##
  dup.ac <- duplicated (datos[,"ac"])
  dup.id <- duplicated (datos[,"id"])
  exclude <- datos[,"ac"] %in% datos[dup.ac, "ac"] | datos[,"id"] %in% datos[dup.id, "id"]
  if (sum (exclude) > 0) {
    print ("excluimos")
    print (datos[exclude,])
    datos <- datos[!exclude,]
  }
  ##
  vect <- datos[,"id"]
  names (vect) <- datos[,"ac"]
  ##
  columna <- paste ("mirBase", i, sep = "")
  mirIDmat[,columna] <- vect[rownames (mirIDmat)]
}

mirIDmat[1:10,]

################################################################################


###CONVERSION mirbase 19
## no se por que es un poco rarita esta ultima version

for (i in 19: 20) {
  cat ("\n")
  print (i)
  ##
  fichero <- file.path (i, "mirna_mature.txt")
  datos <- read.table (file = fichero, header = FALSE, sep = "\t", quote = "", as.is = TRUE)
  print (datos[1:3,])
  ##
  datos <- datos[,c(4,2)]  ## ESTAS COLUMNAS SOLO SON ASI PARA LAS VERSIONES 19 Y 20. REVISAR QUE NO CAMBIE EN LAS PROXIMAS.
  colnames (datos) <- c("ac", "id")
  datos <- unique (datos)
  print (datos[1:3,])
  ##
  if (sum (is.na (datos)) != 0) stop ("hay NAs")
  if (sum (datos == "")   != 0) stop ("hay Vacios")
  ##
  dup.ac <- duplicated (datos[,"ac"])
  dup.id <- duplicated (datos[,"id"])
  exclude <- datos[,"ac"] %in% datos[dup.ac, "ac"] | datos[,"id"] %in% datos[dup.id, "id"]
  
  
  ##hay muchos duplicados: 450 en la version 19. Tdodo lo que sigue es para recuperar alguno de ellos:
  sum (exclude)
  ##
  duplicados <- datos[exclude,]
  datos <- datos[!exclude,]
  
  buenos <- grep ("p$", duplicados[,"id"], value = TRUE)
  touse <- duplicados[,"id"] %in% buenos
  table (touse)
  duplicados <- duplicados[touse,]
  ##
  datos <- rbind (datos, duplicados)
  
  
  ##
  dup.ac <- duplicated (datos[,"ac"])
  dup.id <- duplicated (datos[,"id"])
  exclude <- datos[,"ac"] %in% datos[dup.ac, "ac"] | datos[,"id"] %in% datos[dup.id, "id"]
  if (sum (exclude) > 0) {
    print ("excluimos")
    print (datos[exclude,])
    datos <- datos[!exclude,]
  }
  ##
  vect <- datos[,"id"]
  names (vect) <- datos[,"ac"]
  ##
  columna <- paste ("mirBase", i, sep = "")
  mirIDmat[,columna] <- vect[rownames (mirIDmat)]
}

mirIDmat[1:10,]

################################################################################

t (apply (mirIDmat, 2, function (x) table (is.na (x))))

##hay bastantes cambios de la version 18 a la 19
from <- "18"
to <- "19"
##
col.from <- paste ("mirBase", from, sep = "")
col.to   <- paste ("mirBase", to ,  sep = "")
##
dif <- mirIDmat[,col.from] != mirIDmat[,col.to]
table (dif)
##
diferentes <- mirIDmat[dif, c(col.from, col.to)]  ##aunque los humanos son pocos
humanos <- grep ("hsa", diferentes[,col.to])
diferentes[humanos,]


##No hay tantos cambios de la version 19 a la 20
from <- "19"
to <- "20"
##
col.from <- paste ("mirBase", from, sep = "")
col.to   <- paste ("mirBase", to ,  sep = "")
##
dif <- mirIDmat[,col.from] != mirIDmat[,col.to]
table (dif)
##
diferentes <- mirIDmat[dif, c(col.from, col.to)]  ##pero los humanos parecen mas
humanos <- grep ("hsa", diferentes[,col.to])
diferentes[humanos,]

################################################################################
################################################################################


##CONSTRUIMOS el vectores de conversion a la version 19.
mirIDmat[1:3,]

N <- ncol (mirIDmat)

## mirBase19
mat <- cbind (as.vector (mirIDmat), mirIDmat[,"mirBase19"])
table (is.na (mat))

exclude <- is.na (mat[,1]) | is.na (mat[,2])
table (exclude)
mat <- mat[!exclude,]

mat <- unique (mat)
dup <- duplicated (mat[,1])
table (dup)

esdup <- mat[,1] %in% mat[dup, 1]
malos <- mat[esdup,]
##
orden <- order (malos[,1])
malos <- malos[orden,]
malos
##
mat <- mat[!esdup,]  ##los quitamos
dim (mat)

table (duplicated (mat[,1]))
table (duplicated (mat[,2])) #NO HAY PROBLEMA CON ESTOS DUPLICADOS

##ordenamos por nombre
orden <- order (mat[,1])
mat <- mat[orden,]
mat[1:10,]

###FORMATO VECTOR
id2mir19 <- mat[,2]
names (id2mir19) <- mat[,1]


##CONSTRUIMOS el vectores de conversion a la version 20
source (file.path ("../../R", "mirbVersions.r"))
source (file.path ("../../R", "buildVersion.r"))
id2mir20 <- buildVersion (20)

##vector con la version ultima
id2mirLast <- id2mir20

##just forchecking
to19version <- buildVersion (19)
table (to19version == id2mir19)  ##OK 


###SALVAMOS
save (list = "mirIDmat",   file = file.path (.job$dir$data, "mirIDmat.RData"), compress = "xz")
save (list = "id2mir19",   file = file.path (.job$dir$data, "id2mir19.RData"), compress = "xz")
save (list = "id2mir20",   file = file.path (.job$dir$data, "id2mir20.RData"), compress = "xz")
save (list = "id2mirLast", file = file.path (.job$dir$data, "id2mirLast.RData"), compress = "xz")

## write.table (cbind (names (id2mir19), id2mir19), file = "id2mir19.txt",
##              append = FALSE, quote = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE)

## write.table (cbind (names (id2mir20), id2mir19), file = "id2mir20.txt",
##              append = FALSE, quote = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE)

###EXIT
warnings ()
sessionInfo ()
q ("no")
