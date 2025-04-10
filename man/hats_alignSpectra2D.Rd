% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hats_alignSpectra2D.R
\name{hats_alignSpectra2D}
\alias{hats_alignSpectra2D}
\title{Align the Spectra in a Spectra2D Object using the HATS algorithm.}
\usage{
hats_alignSpectra2D(
  spectra,
  maxF2 = NULL,
  maxF1 = NULL,
  dist_method = "cosine",
  minimize = FALSE,
  thres = 0.99,
  no.it = 20L,
  restarts = 2L,
  method = "MBO",
  fill = "noise",
  plot = FALSE,
  debug = 1
)
}
\arguments{
\item{spectra}{An object of S3 class \code{\link{Spectra2D}}.}

\item{maxF2}{Integer.  The most extreme positive \code{F2step} to allow during the
alignment process (units are data points).  Search for the optimal alignment will
cover the region \code{-maxF2} \ldots \code{maxF2} and \code{-maxF1}
\ldots \code{maxF1}.  Defaults to about 10\% of the number of points.}

\item{maxF1}{Integer.  As for \code{maxF2}, but for F1.}

\item{dist_method}{Character. The distance method to use in the objective function.
See \code{\link[ChemoSpecUtils]{rowDist}} for options.}

\item{minimize}{Logical. Is the goal to minimize the objective function?  If so, use \code{TRUE}.}

\item{thres}{Numeric. Prior to launching the optimization, the objective function is evaluated
for no shift in case this is actually the best alignment (saving a great deal of time).
If this initial check exceeds the value of \code{thres} (when \code{minimize = FALSE}),
or is below \code{thres} when \code{minimize = TRUE}, no optimization is performed
and the unshifted spectra are returned.}

\item{no.it}{Integer. The maximum number of iterations in the optimization.}

\item{restarts}{Integer. The maximum number of independent rounds of optimization.}

\item{method}{Character. Currently only \code{method = "MBO"} is available which uses
the HATS algorithm plus model based optimization (aka Bayesian optimization) method to
align the spectra. Use \code{plot = TRUE} to see this in action.}

\item{fill}{Aligning spectra requires that at least some spectra be shifted left/right
      and up/down.  When a spectrum is shifted, spaces are opened that must be filled with something:
\itemize{
  \item If \code{fill = "zeros"} the spaces are filled with zeros.
  \item If \code{fill = "noise"} the spaces are filled with an estimate of the noise from the
    original spectrum.
}}

\item{plot}{Logical. Shall a plot of the alignment progress be made?  The plot is useful for
diagnostic purposes.  Every step of the alignment has a corresponding plot so you should
probably direct the output to a pdf file.}

\item{debug}{Integer.
\itemize{
  \item Values >= 1 give messages about alignment progress in black text.
  \item Values >= 2 print the merge matrix from the \code{hclust} object, if \code{plot}
        is also \code{TRUE}.  This is the guide tree.
  \item For \code{method = "MBO"} values less than 2 suppress some messages and warnings from
       the underlying functions.  If the alignment doesn't work well, set \code{debug = 2}.
  \item Setting \code{plot = TRUE} also gives a view of alignment diagnostics.
}}
}
\value{
An object of S3 class \code{\link{Spectra2D}}.
}
\description{
Align the spectra in a \code{\link{Spectra2D}} object using an implementation
of the HATS algorithm described by Robinette \emph{et al.}.  Currently, only
global, not local, alignment is carried out.
}
\section{Advice}{

\itemize{
  \item I suggest that you plot your possibly mis-aligned spectra first, zooming in on a small region where
        alignment might be an issue, and get an idea of the size of the alignment problem.  This will help
        you choose good values for \code{maxF1} and \code{maxF2} which will speed up the search.
  \item The algorithm uses random numbers to initialize the search, so set the seed for reproducible results.
        Different seeds may give different results; you may find it useful to experiment a bit and see how
        the alignment turns out.
  \item Be sure that your choice of \code{thres}, \code{minimize} and \code{dist_method} are self-consistent.
        Some \code{dist_method} choices are bounded, others unbounded, and some should be minimized, others maximized.
  \item You should use \code{\link{sampleDist}} to visualize the distances ahead of time.  The method
        chosen should return a wide numerical range between samples or it won't give a good alignment result.
}
}

\examples{
\dontrun{
set.seed(123)
library("ggally") # for diagnostic plots
data(MUD2)
sumSpectra(MUD2)
mylvls <- seq(3, 30, 3)

# Plot before alignment
plotSpectra2D(MUD2,
  which = c(2, 3, 5, 6), showGrid = TRUE,
  lvls = LofL(mylvls, 4),
  cols = LofC(c("black", "red", "blue", "green"), 4, 10, 2)
)

# Carry out alignment
# You might want to direct the diagnostic output here to a pdf file
# This alignment takes about 90 seconds including the plotting overhead
MUD2a <- hats_alignSpectra2D(MUD2, method = "MBO", debug = 1, plot = TRUE)

# Plot after alignment
plotSpectra2D(MUD2a,
  which = c(2, 3, 5, 6), showGrid = TRUE,
  lvls = LofL(mylvls, 4),
  cols = LofC(c("black", "red", "blue", "green"), 4, 10, 2)
)
}

}
\references{
Roughly follows the algorithm described in Robinette et al. 2011
  \emph{Anal. Chem.} vol. 83, 1649-1657 (2011) dx.doi.org/10.1021/ac102724x
}
\author{
Bryan A. Hanson, DePauw University.
}
\keyword{multivariate}
