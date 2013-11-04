##mirbVersions.r
##2013-01-16 dmontaner@cipf.es

##' A function to display all available miRBase versions.
##'
##' @author David Montaner <\email{dmontaner@@cipf.es}>
##' @title Show all available miRBase versions
##' @seealso \code{\link{mirIDmat}} \code{\link{id2mirLast}}
##'
##' @return A character vector of available versions.
##'
##' @export
##'
##' @examples
##' mirbVersions ()

mirbVersions <- function () {##2013-01-1 dmontaner@cipf.es
  versiones <- sub ("mirBase", "", colnames (mirIDmat))
  return (versiones)
}
