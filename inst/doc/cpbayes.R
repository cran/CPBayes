## ----install_package, eval=FALSE, collapse = TRUE------------------------
#  install.packages("CPBayes")
#  library("CPBayes")

## ----load_Beta, collapse = TRUE------------------------------------------
library("CPBayes")
# Load the beta hat vector
BetaHatfile <- system.file("extdata", "BetaHat.rda", package = "CPBayes")
load(BetaHatfile)
BetaHat

## ----load_SE, collapse = TRUE--------------------------------------------
# Load the standard error vector
SEfile <- system.file("extdata", "SE.rda", package = "CPBayes")
load(SEfile)
SE

## ----names, collapse = TRUE----------------------------------------------
# Specify the name of the traits and the genetic variant.
traitNames <- paste("Disease", 1:10, sep = "")
SNP1 <- "rs1234"
traitNames
SNP1

## ----uncor_example, collapse = TRUE--------------------------------------
# Run the uncorrelated version of CPBayes.
result <- cpbayes_uncor(BetaHat, SE, Phenotypes = traitNames, Variant = SNP1)

## ----result_structure, collapse= TRUE------------------------------------
# Overall summary of the primary results produced by cpbayes_uncor.
str(result)

## ----post_summary, collapse= TRUE----------------------------------------
# Post summary of the MCMC data produced by cpbayes_uncor.
PleioSumm <- post_summaries(result, level = 0.05)  
str(PleioSumm)

## ----load_cBeta, collapse = TRUE-----------------------------------------
# Load the beta-hat vector
datafile <- system.file("extdata", "cBetaHat.rda", package = "CPBayes")
load(datafile)
cBetaHat

## ----load_cSE, collapse = TRUE-------------------------------------------
# Load the standard error vector
datafile <- system.file("extdata", "cSE.rda", package = "CPBayes")
load(datafile)
cSE

## ----load_cor, collapse = TRUE-------------------------------------------
# Load the correlation matrix of the beta-hat vector (cBetaHat)
datafile <- system.file("extdata", "cor.rda", package = "CPBayes")
load(datafile)
cor

## ----cor_example, collapse = TRUE----------------------------------------
# Run the correlated version of CPBayes.
result <- cpbayes_cor(cBetaHat, cSE, cor, Phenotypes = traitNames, Variant = SNP1)

## ----result_structure_cor, collapse= TRUE--------------------------------
# Overall summary of the primary results produced by cpbayes_cor.
str(result)

## ----post_summary_cor, collapse= TRUE------------------------------------
# Post summary of the MCMC data produced by cpbayes_cor.
PleioSumm <- post_summaries(result, level = 0.05)  
str(PleioSumm)

## ----corln_estimation_example, collapse = TRUE---------------------------
# Example data of sample-overlap matrices
SampleOverlapMatrixFile <- system.file("extdata", "SampleOverlapMatrix.rda", package = "CPBayes")
load(SampleOverlapMatrixFile)
SampleOverlapMatrix

## ----run_corln_estimation, collapse = TRUE-------------------------------
# Estimate the correlation matrix of correlated beta-hat vector
n11 <- SampleOverlapMatrix$n11
n00 <- SampleOverlapMatrix$n00
n10 <- SampleOverlapMatrix$n10
cor <- estimate_corln(n11, n00, n10)
cor

