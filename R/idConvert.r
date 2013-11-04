##idConvert.r
##2013-01-16 dmontaner@cipf.es

##' A function to convert a vector of miRBase IDs to any other version between 10 and 19.
##' Default version to convert to is 19.
##' 
##' @author David Montaner <\email{dmontaner@@cipf.es}>
##' @title miRBase id conversion to the chosen version.
##' @seealso \code{\link{id2mir19}} \code{\link{id2mirLast}}
##' 
##' @param x character vector of IDs to be converted.
##' @param mirversion miRBase version to convert the IDs to.
##' @param includenames should input ids be used as the names in the output vector.
##' @param verbose mode
##' 
##' @return A character vector of converted ids
##' 
##' @export
##' 
##' @examples
##' conv <- c("cel-lin-4", "cel-miR-1", "mas", NA, "cel-lin-4")
##' idConvert (conv)
##' idConvert (conv, verbose = FALSE, includenames = FALSE)
##' idConvert (conv, mirversion = 18)

idConvert <- function (x, mirversion = 19, includenames = TRUE, verbose = TRUE) {

  if (as.character (mirversion) == "19") {
    id2mir <- id2mir19
  } else {
    id2mir <- buildVersion (version = mirversion, verbose = verbose)
  }
  
  y <- id2mir[x]
  if (includenames) {
    names (y) <- x
  } else {
    names (y) <- NULL
  }
  if (verbose) {
    cat (paste ("\n\t", sum (is.na (y)), "IDs could not be converted\n\n"))
  }
  return (y)
}
