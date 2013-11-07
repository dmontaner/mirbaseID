\name{guessVersion}
\alias{guessVersion}
\title{Guess mirbase version.}
\usage{
  guessVersion(x, idmat = mirIDmat, justVersion = FALSE)
}
\arguments{
  \item{x}{a character vector of miRNA IDs.}

  \item{idmat}{the matrix mirIDmat.}

  \item{justVersion}{if TRUE just the version name is
  returned instead of the counts and proportion matrix.}
}
\value{
  A data frame with the counts and proportions of the
  identifiers in each version of miRBase.
}
\description{
  Function to guess the version of miRBase used in a vector
  of miRNA IDs.
}
\examples{
ids <- c("hsa-let-7a", "hsa-let-7b", "hsa-let-7c", "hsa-let-7d", "hsa-let-7e","cel-miR-44-3p")
guessVersion (ids)
}
\author{
  David Montaner \email{dmontaner@cipf.es}
}
\seealso{
  \code{\link{mirIDmat}}
}
\keyword{guess}
\keyword{mirbase}
\keyword{version}

