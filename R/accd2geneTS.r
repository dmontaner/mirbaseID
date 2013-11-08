##acc2geneTS.r
##2013_11-08 dmontaner@cipf.es

##' @name acc2geneTS
##' @docType data
##' @author David Montaner \email{dmontaner@@cipf.es}
##' 
##' @aliases acc2geneTSp acc2geneTSc
##' @aliases acc2tranTSp acc2tranTSc
##' 
##' @keywords accession id miRNA microRNA target gene transcript convert
##' @seealso \code{\link{targetScanDownloadDate}}
##' 
##' @title miRNA targets from TargetScan
##'
##' @description Lists containing the target genes or transcripts of each miRNAs.
##'
##' @details Data were downloaded form TargetScan Human; see: 'http://www.targetscan.org/'. 
##' Two versions of the predictions are available:
##' \describe{
##'   \item{Predicted Conserved Targets Info}{predicted and conserved.}
##'   \item{Conserved Family Info}{conserved.}
##' }
##' 
##' Four vectors are available:
##' \describe{
##'   \item{acc2geneTSp}{miRBase accession id to Gene Symbol from the Predicted dataset.}
##'   \item{acc2geneTSc}{miRBase accession id to Gene Symbol from the Conserved dataset.}
##'   \item{acc2tranTSp}{miRBase accession id to Transcript ID from the Predicted dataset.}
##'   \item{acc2tranTSc}{miRBase accession id to Transcript ID from the Conserved dataset.}
##' }
##' 
##' @examples
##' acc2geneTSp[1:3]
##' lapply (acc2tranTSp[1:3])

NULL
