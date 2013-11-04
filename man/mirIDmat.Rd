\docType{data}
\name{mirIDmat}
\alias{mirIDmat}
\title{miRBase ID conversion matrix.}
\description{
  A matrix containing miRBase IDs form different versions.
  Each row of the matrix contains one miRBase Accession.
  Each column of the matrix contains the miRBase ID
  conversion of the corresponding miRBase Accession into a
  different miRBase version.
}
\details{
  This matrix can be used to convert miRBase IDs between
  versions
}
\examples{
mirIDmat[1:3,]
}
\author{
  David Montaner \email{dmontaner@cipf.es}.
}
\seealso{
  \code{\link{buildVersion}} \code{\link{id2mirLast}}
}
\keyword{convert}
\keyword{datasets}
\keyword{id}
\keyword{version}

