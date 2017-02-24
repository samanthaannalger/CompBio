#' "Special" roxygen comment that will render as markdown
# Demo of R scripts
# 26 January 2017
# SAA

# hard set working directory:
setwd("~/ComputationalBiology/CompBio")

# New plot to show up in view
plot(runif(10))

# Show some data in the console
z <-rnorm(n=3, mean=10, sd=2)
print(z)

#Command Shift Enter- to run all code at once
#Command Enter- to run each line separately
#Control L will clean out console line

library(knitr)

#"purl" takes previous chunks in markdown file and puts them in one place and turns it into a R script\

purl("lecture_notes.Rmd")


