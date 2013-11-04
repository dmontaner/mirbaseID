\name{idConvert}
\alias{idConvert}
\title{miRBase id conversion to the chosen version.}
\usage{
  idConvert(x, mirversion = 19, includenames = TRUE,
    verbose = TRUE)
}
\arguments{
  \item{x}{character vector of IDs to be converted.}

  \item{mirversion}{miRBase version to convert the IDs to.}

  \item{includenames}{should input ids be used as the names
  in the output vector.}

  \item{verbose}{mode}
}
\value{
  A character vector of converted ids
}
\description{
  A function to convert a vector of miRBase IDs to any
  other version between 10 and 19. Default version to
  convert to is 19.
}
\examples{
conv <- c("cel-lin-4", "cel-miR-1", "mas", NA, "cel-lin-4")
idConvert (conv)
idConvert (conv, verbose = FALSE, includenames = FALSE)
idConvert (conv, mirversion = 18)
}
\author{
  David Montaner <\email{dmontaner@cipf.es}>
}
\seealso{
  \code{\link{id2mir19}} \code{\link{id2mirLast}}
}

