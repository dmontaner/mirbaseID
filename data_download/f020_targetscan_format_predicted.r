##f020_targetscan_format_predicted.r
##2013-11-07 dmontaner@cipf.es
##Prepare microRNA targets from TargetScan Human

##' As I am working with the Human dataset,
##' I am guessing that the Species.ID refers to the miRNA
##' and that all genes are human.

date ()
Sys.info ()[c("nodename", "user")]
commandArgs ()
rm (list = ls ())
R.version.string ##"R version 3.0.2 (2013-09-25)"
library (mdgsa); packageDescription ("mdgsa", fields = "Version") #"0.3.2"

try (source ("job.r")); try (.job)


##' Family Info
##' ============================================================================

system.time (fam <- read.table (file = file.path (.job$dir$tmp, "targetscan", "miR_Family_Info.txt"),
                                header = TRUE, sep = "\t", quote = "", colClasses = "character"))

colnames (fam)[1] <- "miR.Family"
dim (fam)
colnames (fam)
fam[1:3,]

fam <- fam[,c("miR.Family", "Species.ID", "MiRBase.ID", "MiRBase.Accession")]

table (duplicated (fam))
table (duplicated (fam[,"MiRBase.Accession"]))  ##OK no duplicated
table (duplicated (fam[,"MiRBase.ID"]))         ##OK no duplicated; one to one relationship between them.

table (fam[,"Species.ID"]) ##many species

##table (fam[,"MiRBase.ID"] %in% mirIDmat)  ## OK all in
##guessVersion (fam[,"MiRBase.ID"])         ## seems to be 17



##' Predicted_Targets_Info.txt 
##' ============================================================================

system.time (tgt <- read.table (file = file.path (.job$dir$tmp, "targetscan", "Predicted_Targets_Info.txt"),
                                header = TRUE, sep = "\t", quote = "", colClasses = "character"))

dim (tgt)
#system.time (table (duplicated (tgt))) ##OK no duplicated
colnames (tgt)
tgt[1:3,]

tgt <- tgt[,c("miR.Family", "Species.ID", "Gene.ID", "Gene.Symbol", "Transcript.ID")]
gc ()
gc ()
tgt[1:3,]

system.time (dup <- duplicated (tgt))
table (dup)

tgt <- tgt[!dup,]
dim (tgt)


##' Merge
##' ============================================================================

dim (fam)
dim (tgt)

fam[1:3,]
tgt[1:3,]

system.time (combi <- merge (fam, tgt))
dim (combi) # smaller ????
combi[1:10,]
table (duplicated (combi))  #OK no dup


##' miRNA to gene
##' ============================================================================
combi.g <- combi[,c("Species.ID", "MiRBase.Accession", "Gene.Symbol")]
dup <- duplicated (combi.g)
table (dup)
combi.g <- combi.g[!dup,]
combi.g[1:3,]

table (duplicated (combi.g[,c("MiRBase.Accession", "Gene.Symbol")]))  ##OK no duplicated: the ACCESSION id implies the species.

combi.g <- combi.g[,c("Gene.Symbol", "MiRBase.Accession")]
dim (combi.g)

length (unique (combi.g[,c("MiRBase.Accession")]))


##' list format
system.time (acc2geneTS <- annotMat2list (combi.g))

table (sapply (acc2geneTS, function (x) sum (duplicated (x))))  #OK no duplicates

lapply (acc2geneTS[1:3], head)
lapply (acc2geneTS[100:103], head)



##' miRNA to transcript
##' ============================================================================
combi.t <- combi[,c("Species.ID", "MiRBase.Accession", "Transcript.ID")]
dup <- duplicated (combi.t)
table (dup)
combi.t <- combi.t[!dup,]
combi.t[1:3,]

table (duplicated (combi.t[,c("MiRBase.Accession", "Transcript.ID")]))  ##OK no duplicated: the ACCESSION id implies the species.

combi.t <- combi.t[,c("Transcript.ID", "MiRBase.Accession")]
dim (combi.t)

length (unique (combi.t[,c("MiRBase.Accession")]))


##' list format
system.time (acc2tranTS <- annotMat2list (combi.t))

table (sapply (acc2tranTS, function (x) sum (duplicated (x))))  #OK no duplicates

lapply (acc2tranTS[1:3], head)
lapply (acc2tranTS[100:103], head)



##' SAVE
##' ============================================================================

acc2geneTSp <- acc2geneTS
acc2tranTSp <- acc2tranTS

setwd (.job$dir$data)
dir ()

save (list = "acc2geneTSp", file = "acc2geneTSp.RData", compress = "xz")
save (list = "acc2tranTSp", file = "acc2tranTSp.RData", compress = "xz")

###EXIT
warnings ()
sessionInfo ()
q ("no")
