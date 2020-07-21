# R-SPAS source
# https://github.com/cschwarz-stat-sfu-ca/SPAS

#install and load package
library(devtools)
devtools::install_github("cschwarz-stat-sfu-ca/SPAS", dependencies = TRUE,
                         build_vignettes = TRUE)

require(SPAS)
# note: overwrites 3 functions from {Matrix} package cov2cor(),toeplitz(), and update()

# get a list of all the objects
ls("package:SPAS")

# open the documentation
help(package = SPAS)


# go straight to the vignettes
# vignette(package="SPAS")
# vignette("HarrisonF2011",package="SPAS")
# vignette("Conne1991",package="SPAS")
# vignette("Conne1992",package="SPAS")




###################################
# RUN ONE OF THE VIGNETTE EXAMPLES
##################################


harrison.2011.chinook.F.csv <- textConnection("
  4   ,      2   ,      1   ,     1   ,     0   ,     0   ,   130
 12   ,      7   ,     14   ,     1   ,     3   ,     0   ,   330
  7   ,     11   ,     41   ,     9   ,     1   ,     1   ,   790
  1   ,     13   ,     40   ,    12   ,     9   ,     1   ,   667
  0   ,      1   ,      8   ,     8   ,     3   ,     0   ,   309
  0   ,      0   ,      0   ,     0   ,     0   ,     1   ,    65
744   ,   1187   ,   2136   ,   951   ,   608   ,   127   ,     0")

har.data <- as.matrix(read.csv(harrison.2011.chinook.F.csv, header=FALSE))
har.data


mod1 <- SPAS.fit.model(har.data,
                       model.id="No restrictions",
                       row.pool.in=1:6, col.pool.in=1:6)

## NOTE: warning messages as per vignette, but also: unsucessful convergence!


# check output
names(mod1)


mod1$version
mod1$date    
mod1$input  
mod1$fit.setup  
mod1$conditional

# What are the convergence tracking codes?
# 0 = successful convergence 
# 1 = ???
# 2= not converged, max evals exceeded

mod1$conditional$res$optim.info$convergence

mod1$model.info
mod1$est.red.star
mod1$est.star
mod1$real


 
SPAS.print.model(mod1)










