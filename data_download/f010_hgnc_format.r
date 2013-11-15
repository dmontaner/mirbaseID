##h010_hgnc_format.r
##2013-11-14 dmontaner@cipf.es
##Format Gene Symbol

##' Some Gene Symbol IDs in the mirna targets need to be updated

date ()
Sys.info ()[c("nodename", "user")]
commandArgs ()
rm (list = ls ())
R.version.string ##"R version 3.0.2 (2013-09-25)"
#library (mirbaseID); packageDescription ("mirbaseID", fields = "Version") #"0.0.2"
#library (mdgsa); packageDescription ("mdgsa", fields = "Version") #"0.3.2"
#help (package = mirbaseID)

try (source ("job.r")); try (.job)


##' ============================================================================

hgnc <- read.table (file = file.path (.job$dir$tmp, "hgnc", "mart_export_hgnc.txt"),
                     header = TRUE, sep = "\t", quote = "", colClasses = "character", comment.char = "")

dim (hgnc)
colnames (hgnc)
hgnc[1:3,]

table (duplicated (hgnc[,"Approved.Symbol"])) ##OK no duplicated

touse <- grep ("~", hgnc[,"Approved.Symbol"])
length (touse)
hgnc[touse,][1:10,]
unique (hgnc[touse, c ("Previous.Symbols", "Aliases")]) ## OK empty
hgnc <- hgnc[-touse,]
dim (hgnc)

table (hgnc[,"Approved.Symbol"] == "") ##OK no empty

table (hgnc[,"Approved.Symbol"] == toupper (hgnc[,"Approved.Symbol"])) 
setdiff (hgnc[,"Approved.Symbol"], toupper (hgnc[,"Approved.Symbol"]))[1:10]
grep ("ORF", hgnc[,"Approved.Symbol"], value = TRUE)



##' Aliases
##' ----------------------------------------------------------------------------
alias <- hgnc[,c ("Approved.Symbol", "Aliases")]
touse <- alias[,"Aliases"] != ""
alias <- alias[touse,]

alias.li <- strsplit (alias[,"Aliases"], ", ")
alias.lo <- sapply (alias.li, length)

alias.ma <- cbind (from = unlist (alias.li), to = rep (alias[,"Approved.Symbol"], times = alias.lo))
table (duplicated (alias.ma))
table (duplicated (alias.ma[,"from"]))


##' Previous.Symbols
##' ----------------------------------------------------------------------------
previ <- hgnc[,c ("Approved.Symbol", "Previous.Symbols")]
touse <- previ[,"Previous.Symbols"] != ""
previ <- previ[touse,]

previ.li <- strsplit (previ[,"Previous.Symbols"], ", ")
previ.lo <- sapply (previ.li, length)

previ.ma <- cbind (from = unlist (previ.li), to = rep (previ[,"Approved.Symbol"], times = previ.lo))
table (duplicated (previ.ma))
table (duplicated (previ.ma[,"from"]))

##' Combine
##' ----------------------------------------------------------------------------

mat <- cbind (from = hgnc[,"Approved.Symbol"], to = hgnc[,"Approved.Symbol"])
mat <- rbind (mat, previ.ma, alias.ma)
dim (mat)
table (duplicated (mat))
dup <- duplicated (mat[,"from"])
table (dup)
mat <- mat[!dup,]

hgnc2latest <- mat[,"to"]
names (hgnc2latest) <- mat[,"from"]


##' SAVE
##' ============================================================================

setwd (file.path (.job$dir$tmp, "hgnc"))
dir ()

save (list = "hgnc2latest", file = "hgnc2latest.RData")  ## not to be included in the library

###EXIT
warnings ()
sessionInfo ()
q ("no")
