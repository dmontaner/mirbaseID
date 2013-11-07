##guessVersion.r
##2013-11-07 dmontaner@cipf.es

##' @name guessVersion
##' @author David Montaner \email{dmontaner@@cipf.es}
##' 
##' @keywords guess mirbase version
##' @seealso \code{\link{mirIDmat}}
##' 
##' @title Guess mirbase version.
##' 
##' @description Function to guess the version of miRBase used in a vector of miRNA IDs.
##' 
## @details
##'
##' @param x a character vector of miRNA IDs.
##' @param idmat the matrix mirIDmat.
##' @param justVersion if TRUE just the version name is returned instead of the counts and proportion matrix.
##' 
##' @return A data frame with the counts and proportions of the identifiers in each version of miRBase.
##' 
##' @examples
##' ids <- c("hsa-let-7a", "hsa-let-7b", "hsa-let-7c", "hsa-let-7d", "hsa-let-7e","cel-miR-44-3p")
##' guessVersion (ids)
##'
##' @export
guessVersion <- function (x, idmat = mirIDmat, justVersion = FALSE) {
  
  versiones <- colnames (mirIDmat)
  
  suma <- rep (NA, times = length (versiones))
  names (suma) <- versiones
  
  for (co in versiones) {
    suma[co] <- sum (x %in% mirIDmat[,co])
  }

  res <- data.frame (verssion = versiones, N = suma,
                     proportion = round (100 * suma / length (x), 2),
                     stringsAsFactors = FALSE)

  res[,"BM"] <- ""
  res[res$N == max (res$N), "BM"] <- "*"

  if (justVersion) {
    res <- res[res$BM == "*", "verssion"]
  }

  return (res)
}
