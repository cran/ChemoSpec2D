#' Evaluate Array Overlap Using MBO
#'
#' @importFrom ChemoSpecUtils rowDist
#' @noRd
#'

#
# This version for use with mlrMBO:
#   1. requires that Ref and Mask are in the global environment
#   2. x is vectorized: x[1] is posx, x[2] is posy (immediately reassigned for consistency)
#
.evalArrayOverlapMBO <- function(x, dist_method) {
  posx <- x[1]
  posy <- x[2]
  Ref <- get("Ref", envir = parent.frame())
  Mask <- get("Mask", envir = parent.frame())

  OF1 <- function(MA, MB, dist_method) rowDist(matrix(c(c(MA), c(MB)), nrow = 2, byrow = TRUE), method = dist_method) # MA, MB are matrices

  OF <- function(MA, MB, dist_method) { # MA, MB are arrays of matrices
    nSa <- dim(MA)[1] # no. samples in array A
    nSb <- dim(MB)[1] # no. samples in array B
    tot <- 0.0
    for (i in 1:nSa) {
      for (j in 1:nSb) {
        tot <- tot + OF1(MA[i, , ], MB[j, , ], dist_method)
      }
    }
    tot <- tot / (nSa * nSb) # average over all comparisons
    tot
  }

  # Conceptually, Mask moves over Ref in x and y directions, evaluate, store positions & results
  # Modified Ref will be put in A1
  # Modified Mask will be put in A2

  # Modify Ref, the reference, in the x-direction (cols)
  if (posx > 0) A1 <- Ref[, -(1:abs(posx)), , drop = FALSE] # mask is to the right of the reference
  if (posx < 0) A1 <- Ref[, -((dim(Ref)[2] - abs(posx) + 1):dim(Ref)[2]), , drop = FALSE] # mask is to the left of the reference
  if (posx == 0) A1 <- Ref # perfect overlap

  # Modify A1, the reference, in the y-direction (rows)
  if (posy > 0) A1 <- A1[, , -((dim(A1)[3] - abs(posy) + 1):dim(A1)[3]), drop = FALSE] # mask is above the reference
  if (posy < 0) A1 <- A1[, , -(1:abs(posy)), drop = FALSE] # mask is below the reference
  if (posy == 0) A1 <- A1 # perfect overlap

  # Modify Mask, the mask, in the x-direction (cols)
  if (posx > 0) A2 <- Mask[, -((dim(Mask)[2] - abs(posx) + 1):dim(Mask)[2]), , drop = FALSE] # mask is to the right of the reference
  if (posx < 0) A2 <- Mask[, -(1:abs(posx)), , drop = FALSE] # mask is to the left of the reference
  if (posx == 0) A2 <- Mask # perfect overlap

  # Modify A2, the mask, in the y-direction (rows)
  if (posy > 0) A2 <- A2[, , -(1:abs(posy)), drop = FALSE] # mask is above the reference
  if (posy < 0) A2 <- A2[, , -((dim(A2)[3] - abs(posy) + 1):dim(A2)[3]), drop = FALSE] # mask is below the reference
  if (posy == 0) A2 <- A2 # perfect overlap

  return(OF(A1, A2, dist_method))
}
