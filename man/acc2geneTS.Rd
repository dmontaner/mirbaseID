\docType{data}
\name{acc2geneTS}
\alias{acc2geneTS}
\alias{acc2geneTSc}
\alias{acc2geneTSp}
\alias{acc2tranTSc}
\alias{acc2tranTSp}
\title{miRNA targets from TargetScan}
\description{
  Lists containing the target genes or transcripts of each
  miRNAs.
}
\details{
  Data were downloaded form TargetScan Human; see:
  'http://www.targetscan.org/'. Two versions of the
  predictions are available: \describe{ \item{Predicted
  Conserved Targets Info}{predicted and conserved.}
  \item{Conserved Family Info}{conserved.} }

  Four vectors are available: \describe{
  \item{acc2geneTSp}{miRBase accession id to Gene Symbol
  from the Predicted dataset.} \item{acc2geneTSc}{miRBase
  accession id to Gene Symbol from the Conserved dataset.}
  \item{acc2tranTSp}{miRBase accession id to Transcript ID
  from the Predicted dataset.} \item{acc2tranTSc}{miRBase
  accession id to Transcript ID from the Conserved
  dataset.} }
}
\examples{
acc2geneTSp[1:3]
lapply (acc2tranTSp[1:3])
}
\author{
  David Montaner \email{dmontaner@cipf.es}
}
\seealso{
  \code{\link{targetScanDownloadDate}}
}
\keyword{accession}
\keyword{convert}
\keyword{datasets}
\keyword{gene}
\keyword{id}
\keyword{microRNA}
\keyword{miRNA}
\keyword{target}
\keyword{transcript}

