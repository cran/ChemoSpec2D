## ----SetUp, echo = FALSE, eval = TRUE, results = "hide"-----------------------

# R options & configuration:
set.seed(9)
rm(list = ls())
suppressMessages(library("knitr"))
desc <- packageDescription("ChemoSpec2D")

# Stuff specifically for knitr:
#opts_chunk$set(eval = FALSE)

## ----array, out.width = "60%", echo = FALSE, fig.cap = "Configuration of the data array. $I$, $J$ and $K$ are array indices; F2 and F1 are standard terms for NMR dimensions. The mode terminology is typically used in the PARAFAC literature.  This structure is also sometimes referred to as a data cube."----
knitr::include_graphics("3Darray.png")

