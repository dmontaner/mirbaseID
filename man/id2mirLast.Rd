\docType{data}
\name{id2mirLast}
\alias{id2mir19}
\alias{id2mir20}
\alias{id2mirLast}
\title{miRBase ID conversion to the latest version.}
\description{
  A named vector to convert miRBase IDs to the latest
  version. Values to be converted are in the names of the
  vector. Output conversion values are in the elements of
  the vector.

  Conversion vectors to versions 19 and 20 are also
  available: \code{id2mir19} and \code{id2mir20}.

  \code{id2mirLast} is a copy of \code{id2mir20}.
}
\examples{
v <- c ("hsa-let-7a*", "hsa-miR-105*", "nada")
id2mirLast[v]
id2mir20[v]
id2mir19[v]
}
\author{
  David Montaner \email{dmontaner@cipf.es}
}
\seealso{
  \code{\link{buildVersion}}
}
\keyword{convert}
\keyword{datasets}
\keyword{id}

