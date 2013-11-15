##j010_mirtarbase_format.r
##2013-11-07 dmontaner@cipf.es
##Prepare microRNA targets from miRTarBase

date ()
Sys.info ()[c("nodename", "user")]
commandArgs ()
rm (list = ls ())
R.version.string ##"R version 3.0.2 (2013-09-25)"
library (mirbaseID); packageDescription ("mirbaseID", fields = "Version") #"0.0.2"
library (mdgsa); packageDescription ("mdgsa", fields = "Version") #"0.3.2"
help (package = mirbaseID)

try (source ("job.r")); try (.job)

load (file.path (.job$dir$tmp, "hgnc", "hgnc2latest.RData"))
ls ()

##' ============================================================================

system.time (datos <- read.table (file = file.path (.job$dir$tmp, "mirtarbase", "miRTarBase_MTI.txt"),
                                  header = TRUE, sep = "\t", quote = "", colClasses = "character"))

dim (datos)
colnames (datos)
datos[1:3,]

datos <- datos[,c ("miRNA", "Target.Gene", "Target.Gene..Entrez.Gene.ID.", "Species..miRNA.", "Species..Target.Gene.")]
table (duplicated (datos))
datos <- unique (datos)
dim (datos)
datos[1:3,]

dif.esp <- datos[,"Species..miRNA."] != datos[,"Species..Target.Gene."]
table (dif.esp)

datos[dif.esp,]

datos <- datos[!dif.esp,]
dim (datos)

sort (table (datos[,"Species..miRNA."]))

##' ============================================================================

guessVersion (datos[,"miRNA"])

ac <- id2accession[datos[,"miRNA"]]
es.na <- is.na (ac)
table (es.na)
unique (datos[es.na, "miRNA"])

datos <- datos[!es.na,]

ac <- id2accession[datos[,"miRNA"]]
es.na <- is.na (ac)
table (es.na)
unique (datos[es.na, "miRNA"])

guessVersion (datos[,"miRNA"])

datos[1:3,]

datos <- datos[,c ("miRNA", "Target.Gene", "Target.Gene..Entrez.Gene.ID.")]
table (duplicated (datos)) ##OK no dup

##' ============================================================================


table (lat = datos[,"Target.Gene"] %in% hgnc2latest,
       nam = datos[,"Target.Gene"] %in% names (hgnc2latest))

touse <- (!datos[,"Target.Gene"] %in% hgnc2latest) & (!datos[,"Target.Gene"] %in% names (hgnc2latest))
table (touse)

table (lat = toupper (datos[touse, "Target.Gene"]) %in% hgnc2latest,           ## Some problems with lower case
       nam = toupper (datos[touse, "Target.Gene"]) %in% names (hgnc2latest))

system.time (datos[,"mySymbol"] <- hgnc2latest[datos[,"Target.Gene"]])

touse <- is.na (datos[,"mySymbol"])
table (touse)
system.time (datos[touse, "mySymbol"] <- hgnc2latest[toupper (datos[touse, "Target.Gene"])])

table (is.na (datos[,"mySymbol"]))

datos <- datos[!is.na (datos[,"mySymbol"]),]
dim (datos)


##' ============================================================================

length (unique (datos[,"Target.Gene"]))
length (unique (datos[,"Target.Gene..Entrez.Gene.ID."]))

datos <- unique (datos[,c ("miRNA", "mySymbol")])
dim (datos)

datos[,"acc"] <- id2accession[datos[,"miRNA"]]
datos <- datos[,c ("mySymbol", "acc")]

table (duplicated (datos))  ##OK no dup

acc2geneMTB <- annotMat2list (datos)


lapply (acc2geneMTB[1:3], head)

acc2geneMTB["MIMAT0000256"]



##' SAVE
##' ============================================================================

setwd (.job$dir$data)
dir ()

save (list = "acc2geneMTB", file = "acc2geneMTB.RData", compress = "xz")

miRTarBaseDownloadDate <- date ()
save (list = "miRTarBaseDownloadDate", file = "miRTarBaseDownloadDate.RData")  ##OK with the standard compression

###EXIT
warnings ()
sessionInfo ()
q ("no")
