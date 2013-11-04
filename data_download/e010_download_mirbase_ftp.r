##e010_download_mirbase_ftp.r
##2012-12-16 dmontaner@cipf.es
##descargamos los ficheros del ftp de mirBase para los microRNAs maduros

###NOTA del readme de mirBASE
## ftp://mirbase.org/pub/mirbase/CURRENT/README

## The database_files/ directory contains dumps of the MySQL relational
## database that is used to generate the web pages.  The documentation
## for this subset of files is non-existent - use at your peril!

date ()
Sys.info ()[c("nodename", "user")]
commandArgs ()
rm (list = ls ())
R.version.string #"R version 2.15.1 (2012-06-22)"
#library (); packageDescription ("", fields = "Version") #

try (source ("job.r")); try (.job)

N <- 20 # last version

###descargamos y descomprimimos DATOS para los mature
setwd (file.path (.job$dir$tmp))

for (i in 11:13) { ##en estas versiones los directorios se llaman .0
  directorio <- as.character (i)
  dir.create (directorio, showWarnings = TRUE, recursive = FALSE, mode = "0777")
  ##
  miurl <- paste ("ftp://mirbase.org/pub/mirbase/", directorio, ".0/database_files/mirna_mature.txt.gz", sep = "")
  fichero <- file.path (directorio, "mirna_mature.txt.gz")
  download.file (url = miurl, destfile = fichero)  
  system (paste ("gunzip", fichero))
}


for (i in 14:N) {
  directorio <- as.character (i)
  dir.create (directorio, showWarnings = TRUE, recursive = FALSE, mode = "0777")
  miurl <- paste ("ftp://mirbase.org/pub/mirbase/", directorio, "/database_files/mirna_mature.txt.gz", sep = "")
  fichero <- file.path (directorio, "mirna_mature.txt.gz")
  download.file (url = miurl, destfile = fichero)  
  system (paste ("gunzip", fichero))
}


################################################################################

for (i in 11:N) {
  cat ("\n")
  print (paste ("======", i , "======"))
  fichero <- file.path (i, "mirna_mature.txt")
  ##
  datos <- read.table (file = fichero, header = FALSE, sep = "\t", quote = "", as.is = TRUE)
  print (datos[1:3,])
}  


################################################################################


##DATE keep download date
miRBaseDownloadDate <- date ()

save (list = "miRBaseDownloadDate", file = file.path (.job$dir$data, "miRBaseDownloadDate.RData"))  ##OK with the standard compression


###EXIT
warnings ()
sessionInfo ()
q ("no")
