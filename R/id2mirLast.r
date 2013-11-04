##id2mirLast.r
##2012-12-21 dmontaner@cipf.es
##2013-10-31 dmontaner@cipf.es
##id2mir19


##' @name id2mirLast
##' @docType data
##' @author David Montaner \email{dmontaner@@cipf.es}
##'
##' @aliases id2mir20 id2mir19
##'
##' @keywords id convert
##'
##' @seealso \code{\link{buildVersion}}
##' 
##' @title miRBase ID conversion to the latest version.
##'
##' @description A named vector to convert miRBase IDs to the latest version.
##' Values to be converted are in the names of the vector.
##' Output conversion values are in the elements of the vector.
##'
##' Conversion vectors to versions 19 and 20 are also available:
##' \code{id2mir19} and \code{id2mir20}.
##'
##' \code{id2mirLast} is a copy of \code{id2mir20}.
##'
##' @examples
##' v <- c ("hsa-let-7a*", "hsa-miR-105*", "nada")
##' id2mirLast[v]
##' id2mir20[v]
##' id2mir19[v]

NULL
