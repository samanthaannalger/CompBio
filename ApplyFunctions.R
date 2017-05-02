# The Map function
# set up parameter sweep for species-area model
# first illustrate with for loop

setwd("~/CompBio")

# global variables
c <- c(0.1, 0.2, 0.5)
z <- c(0.16, 0.26)
A <- c(1,10,100,1000)
noise <- c(0,0.01,0.1)
nrep <- 100 # must be of length 1 to use the Map function

# set up parameter/output grid
modelSum <- expand.grid(nrep=nrep,c=c,z=z,A=A,noise=noise)
modelSum$meanS <- NA
modelSum$sdS <- NA
print(modelSum)
# create simple Species Area calculator function
SAcalc <- function(c=0.1,z=0.16,A=100,noise=0.1) {
  S <- c*(A)^z + rnorm(n=1,mean=0,sd=noise)
  return(S)
}
SAcalc()
# cycle through parameters with a for loop
for (i in 1:nrow(modelSum)) {
  pars <- list(modelSum[i,2],
               modelSum[i,3],
               modelSum[i,4],
               modelSum[i,5])
  temp <-replicate(n=modelSum[i,1],do.call(SAcalc,pars))
  modelSum$meanS[i] <- mean(temp)
  modelSum$sdS[i]<- sd(temp)
}  
print(modelSum) 

# illustrate the basic map function
Map(SAcalc,modelSum$c,modelSum$z,modelSum$A,modelSum$noise)

# now repeat model calculations using only map, no for loops
temp <- replicate(nrep,unlist(Map(SAcalc,modelSum$c,modelSum$z,modelSum$A,modelSum$noise)))
modelSum$meanS[i] <- mean(temp)
modelSum$sdS[i]<- sd(temp)
print(modelSum) 