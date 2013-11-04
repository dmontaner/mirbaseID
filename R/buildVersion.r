##buildVersion.r
##2013-01-18 dmontaner@cipf.es

##' This package contains a pre-built data matrix containing miRBase IDs form different miRBase versions.
##' Such matrix is called mirIDmat.
##' This function helps converting the mirIDmat matrix into a vector that can afterwords be used to convert miRBase IDs to any desired version.
##' 
##' @author David Montaner <\email{dmontaner@@cipf.es}>
##' @title Build a vector of miRBase id conversions to the chosen version.
##' @seealso \code{\link{mirIDmat}} \code{\link{id2mir19}} \code{\link{id2mirLast}}
##' 
##' @param version the miRBase version to be the output of conversion.
##' @param idmat conversion matrix. See details.
##' @param verbose run verbose mode.

##' @return A character vector of conversion ids. The names of the vector are the keys to be converted.
##' The values of the vector are the conversion values into the desired miRBase version.
##' 
##' @export
##' 
##' @examples
##' ##Builds a conversion vector from any version of miRBase to version 19.
##' to19version <- buildVersion (19)
##' 
##' ##checking
##' table (to19version == id2mir19)
##' 
##' ##Build a conversion vector from miRBase version 12 to version 19.
##' from12to19 <- buildVersion (19, idmat = mirIDmat[,c ("mirBase12", "mirBase19")], verbose = FALSE)

buildVersion <- function (version, idmat = mirIDmat, verbose = TRUE) {##2013-01-18 dmontaner@cipf.es
  
  version <- as.character (version)
  all.versions <- mirbVersions ()
  
  if (!version %in% all.versions) {
    stop (paste (c (version, "is not a valid miRBase version. Currently available versions are:", all.versions), collapse = " "))
  }

  columna <- paste ("mirBase", version, sep = "")
  mat <- cbind (as.vector (idmat), idmat[,columna]) ##create the conversion table
  
  touse <- !is.na (mat[,1]) & !is.na (mat[,2]) ##keep just complete rows
  mat <- mat[touse,]
  
  mat <- unique (mat) ## remove duplicated rows

  ##explore duplicated KEYs
  dup <- duplicated (mat[,1])
  if (any (dup)) {
    esdup <- mat[,1] %in% mat[dup, 1]
    malos <- mat[esdup,]
    M <- length (unique (malos[,1]))
    
    cat (paste ("\n",
                "  ", M, " IDs do not have a unique conversion to mirBase version ",version, ";", "\n",
                "  ", "they will be removed.", "\n",
                sep = ""))    
    
    if (verbose) {##display not unique KEYs
      orden <- order (malos[,1])
      malos <- malos[orden,]
      cat ("\nExcluded conversions are:\n")
      print (malos)
    }
    
    ##remoove not unique KEYs
    mat <- mat[!esdup,]
  }

  ##SORT
  orden <- order (mat[,1])
  mat <- mat[orden,]

  ##VECTOR FORMAT
  out <- mat[,2]
  names (out) <- mat[,1]

  ##OUTPUT
  return (out)
}

## for (ve in mirbVersions ()) {
##   cat ("\n")
##   print (ve)
##   buildVersion (ve, verbose = FALSE)
## }
