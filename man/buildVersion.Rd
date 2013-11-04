\name{buildVersion}
\alias{buildVersion}
\title{Build a vector of miRBase id conversions to the chosen version.}
\usage{
  buildVersion(version, idmat = mirIDmat, verbose = TRUE)
}
\arguments{
  \item{version}{the miRBase version to be the output of
  conversion.}

  \item{idmat}{conversion matrix. See details.}

  \item{verbose}{run verbose mode.}
}
\value{
  A character vector of conversion ids. The names of the
  vector are the keys to be converted. The values of the
  vector are the conversion values into the desired miRBase
  version.
}
\description{
  This package contains a pre-built data matrix containing
  miRBase IDs form different miRBase versions. Such matrix
  is called mirIDmat. This function helps converting the
  mirIDmat matrix into a vector that can afterwords be used
  to convert miRBase IDs to any desired version.
}
\examples{
##Builds a conversion vector from any version of miRBase to version 19.
to19version <- buildVersion (19)

##checking
table (to19version == id2mir19)

##Build a conversion vector from miRBase version 12 to version 19.
from12to19 <- buildVersion (19, idmat = mirIDmat[,c ("mirBase12", "mirBase19")], verbose = FALSE)
}
\author{
  David Montaner <\email{dmontaner@cipf.es}>
}
\seealso{
  \code{\link{mirIDmat}} \code{\link{id2mir19}}
  \code{\link{id2mirLast}}
}

