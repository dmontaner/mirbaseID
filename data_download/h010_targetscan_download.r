##h010_targetscan_download.r
##2013-11-07 dmontaner@cipf.es
##Prepare microRNA targets from TargetScan

date ()
Sys.info ()[c("nodename", "user")]
commandArgs ()
rm (list = ls ())
R.version.string ##"R version 3.0.2 (2013-09-25)"

try (source ("job.r")); try (.job)


##' Family Info
##' ============================================================================

setwd (file.path (.job$dir$tmp, "targetscan"))

system ("wget http://www.targetscan.org/vert_61/vert_61_data_download/miR_Family_Info.txt.zip .")
system ("wget http://www.targetscan.org/vert_61/vert_61_data_download/Predicted_Targets_Info.txt.zip .")
system ("wget http://www.targetscan.org/vert_61/vert_61_data_download/Conserved_Family_Info.txt.zip .")

system ("unzip miR_Family_Info.txt.zip")
system ("unzip Predicted_Targets_Info.txt.zip")
system ("unzip Conserved_Family_Info.txt.zip")

unlink ("miR_Family_Info.txt.zip")
unlink ("Predicted_Targets_Info.txt.zip")
unlink ("Conserved_Family_Info.txt.zip")


##DATE keep download date
targetScanDownloadDate <- date ()

save (list = "targetScanDownloadDate", file = file.path (.job$dir$data, "targetScanDownloadDate.RData"))  ##OK with the standard compression

###EXIT
warnings ()
sessionInfo ()
q ("no")
