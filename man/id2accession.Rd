\docType{data}
\name{id2accession}
\alias{id2accession}
\title{miRBase ID conversion to Accession.}
\description{
  A named vector to convert miRBase IDs to miRBase
  Accessions. Values to be converted are in the names of
  the vector. Output conversion values are in the elements
  of the vector.
}
\examples{
v <- c ("hsa-let-7a*", "hsa-miR-105*", "nada")
id2accession[v]
}
\author{
  David Montaner \email{dmontaner@cipf.es}.
}
\keyword{convert}
\keyword{datasets}
\keyword{id}

