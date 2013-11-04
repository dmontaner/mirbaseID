##e030_id2accession_conversion.r
##2013-04-05 dmontaner@cipf.es
##conversion de los identificadored de mirBASE ID a mirBASE Accession

##los hsa son los miRBase ID(s)
##los MIMAT0000001 son los miRBase Accession(s)

date ()
Sys.info ()[c("nodename", "user")]
commandArgs ()
rm (list = ls ())
R.version.string #"R version 3.0.0 RC (2013-03-26 r62418)"

try (source ("job.r")); try (.job)

################################################################################


setwd (file.path (.job$dir$data))
dir ()

##DATOS
load ("mirIDmat.RData")
ls ()


mat <- cbind (ac = rownames (mirIDmat), id = as.vector (mirIDmat))
dim (mat)
mat[1:3,]

touse <- mat[,1] == "MIMAT0000001"
table (touse)
mat[touse,]
mirIDmat[1,]

mat <- unique (mat)
dim (mat)
table (is.na (mat))
table (is.na (mat[,1]))
table (is.na (mat[,2])) ##OK

esna <- is.na (mat[,2])
table (esna)
mat <- mat[!esna,]
dim (mat)
mat[1:10,]

id2accession <- mat[,"ac"]
names (id2accession) <- mat[,"id"]
id2accession[1:3]

touse <- id2accession == "MIMAT0000001"
table (touse)
id2accession[touse]


###SALVAMOS
save (list = "id2accession", file = file.path (.job$dir$data, "id2accession.RData"), compress = "xz")

###EXIT
warnings ()
sessionInfo ()
q ("no")
