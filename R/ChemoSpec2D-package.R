#'
#'
#'
#' Exploratory Chemometrics for 2D Spectroscopy
#'
#' Description: A collection of functions for exploratory chemometrics of 2D
#' spectroscopic data sets such as COSY and HSQC NMR spectra. ChemoSpec2D deploys
#' methods aimed primarily at classification of samples and the identification of
#' spectral features which are important in distinguishing samples from each other.
#' Each 2D spectrum (a matrix) is treated as the unit of observation, and thus the
#' physical sample in the spectrometer corresponds to the  sample from a statistical
#' perspective.  In addition to chemometric tools, a few tools are provided for
#' plotting 2D spectra, but these are not intended to replace the functionality
#' typically available on the spectrometer. ChemoSpec2D takes many of its cues from
#' ChemoSpec and tries to create consistent graphical output and to be very user friendly.
#' A vignette is available.
#'
#' @name ChemoSpec2D-package
#'
#' @aliases ChemoSpec2D-package ChemoSpec2D
#'
#' @author Bryan A. Hanson.
#'
#' Maintainer: Bryan A. Hanson \email{hanson@@depauw.edu}
#'
#' @keywords package
#'
#  The following import/export business based on stackoverflow.com/a/35118850/633251
#'
#' @importFrom ChemoSpecUtils chkSpectra sumSpectra sumGroups
#' @export                    chkSpectra sumSpectra sumGroups
#'
#' @importFrom ChemoSpecUtils removeFreq removeGroup removeSample
#' @export                    removeFreq removeGroup removeSample
#'
#' @importFrom ChemoSpecUtils plotScree plotScores .chkReqGraphicsPkgs
#' @export                    plotScree plotScores
#'
#' @importFrom ChemoSpecUtils .findNA .getLimits check4Gaps .chkArgs .addLegend
#' @export                    check4Gaps
#'
"_PACKAGE"
