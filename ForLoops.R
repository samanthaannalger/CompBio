# Care and feeding of for loops
# 2017 03 30
# SAA

# var is a counter variable, it increase by one each time of the loop
# sequence is the start and end 
# var i, j, k

# 1:10
# given vector x from values 1:1000

# for (i in seq_along(x)) { begin function
# function body
#}  end funcion


# simple example

myDat <- round(runif(10), digits=2)
for (i in seq_along(myDat)) {
  cat("loop number = ",i,
      "vector element = ", myDat[i], "\n")
}

# getting code out of your loop will help to speed things up.
# this is the long way: notice the myDat[i] inside the loop. T
# This should be pulled out.
myDat <- vector(mode="numeric", length = 10)
for (i in seq_along(myDat)) {
  myDat[i] <- round(runif(1), digits=2)
  cat("loop number = ",i,
      "vector element = ", myDat[i], "\n")
}

# do not change object dimensions in a loop
# (c, rbind, cbind, list)
myDat <- runif (1)
for (i in 2:10) {
  temp <- round(runif(1), digits=2)
  myDat <- c(myDat,temp)
  cat("loops number = ",i, "vector element = "
  ,myDat[i], "\n")
  }

# do not use a loops if you don't need to

myDat <- 1:10
for (i in seq_along(myDat)){
  myDat[i] <- myDat[i] + myDat [i]^2
  cat("loops number = ",i, "vector element = "
      ,myDat[i], "\n")
}

# Much simpler to use vectorized computation:
z <- 1:10
z <- z + z^2
z

# be aware of i versus z[i]

z <- c(10,2,4)
for (i in seq_along(z)) {
  cat("i = ",i, "z[i] =",z[i],"\n")
}

# use next in the loops to skip certain elements
z <- 1:20

# can we operate on the odd-number elements? 
# %% give you the remainder from a division operation

for (i in seq_along(z)) {
  if (i %% 2 == 0) next #if you divide by 2 and are left with 0, then even number, go to next number and 
  print(i) # print the odd number
}


# a faster better way to do this
z <- 1:20

zsub <- z[z %% 2!=0] # subsetting to pick the odd cases
z %% 2!=0
zsub <- z[z %% 2!=0] 
print(zsub)

for (i in seq_along(zsub)) {
  cat("i = ",i, "zsub[i] =",zsub[i],"\n")
}


##############################################################################
# Using the break function to get our of the loop
# FUNCTION: RanWalk
# stochastic random walk
# input: times = number of time steps
#        n1 = initial population size
#       lamda = finite rate of increase (constant multiplier of current population size)
#       noiseSD = sd of normal distribution
#       with mean = 0
# output: vector n with population sizes > 0
#         until extinction NA
#----------------------------------------------------------------------------

library(tcltk)
RanWalk <- function(times=100,
                    n1=50,
                    lambda=1.0001,
                    noiseSD=10){

  n <- rep(NA,times)
  n[1] <- n1
  noise <- rnorm(n=times,mean=0,sd=noiseSD)


for (i in 1:(times-1)) {
  n[i + 1] <- lambda*n[i] + noise[i]
  if(n[i+1] <= 0) {
    n[i+1] <- NA
    cat("Population extinction at time",
        i-1, "\n")
        tkbell() # computer makes a noise if population crashes to 0
        break} # end of conditional statement
} # end of for loop
  return(n)
  
 }# end of function

head(RanWalk())
plot(RanWalk(lambda = 1, noiseSD=5),type="o")

# Using double for loops
# loop over rows
m <- matrix(round(runif(20), digits=3), nrow=5)
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
  }
print(m)

# loop over columns
m <- matrix(round(runif(20), digits=3), nrow=5)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)

# doublt loop over rows and columns
m <- matrix(round(runif(20), digits=3), nrow=5)
for (i in 1:nrow(m)){
  for (j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j
    } # end of column loop j
} # end of row loop i
print(m)

# write function to sweep pver model parameters
####################################################################
# FUNCTION: SpeciesAreaCurve
# power function for S and A
# input:  A is a vector of island areas
#         c is the intercept constant
#         z is the slope constant
# output: S a vector of predicted species richness
# ------------------------------------------------------------------
SpeciesAreaCurve <- function(A=1:5000,
                             c=0.5,
                             z=0.26) {
  S <- c*(A^z)
  
return(S)
}
head(SpeciesAreaCurve())

####################################################################
# FUNCTION: SpeciesAreaPlot
# plot the species area curve
# input: A = vector of island areas
#       c = single paramter for constant
#       z = single parameter for slope
# output: smoothed graph with parameters shown
# ------------------------------------------------------------------
SpeciesAreaPlot <- function(A=1:5000,
                            c= 0.5,
                            z=0.26) {
  plot(x=A,y=SpeciesAreaCurve(A, c, z),
       type="l",xlab="Island Area",
       ylab="S",ylim=c(0,1000))
  mtext(paste("c = ", c,"z = ",z),cex=0.7)
  return()
}
SpeciesAreaPlot()

# now sweep and build a grid of plots

#global variables
cPars <- c(100,150,175)
zPars <- c(0.10,0.16,0.26,0.3)
par(mfrow=c(3,4))  #change graphic pallette to create 3X4 graphs, 3 values for c and 4 values of z

for (i in seq_along(cPars)) {
  for (j in seq_along(zPars)) {
    SpeciesAreaPlot(c=cPars[i],z=zPars[j])
  }
}

# looping with for
cutPoint <- 0.001
z <- NA
ranData <- runif(100)
for (i in seq_along(ranData)) {
  z <- ranData[i]
  if (z < cutPoint) break
}
print(z)

# looping with while

z <- NA
cycleNumber <- 0
while (is.na(z) | z >= cutPoint) { # will loop until those conditions are met
  z <- runif(1) # code that will run if conditions are met
  cycleNumber <- cycleNumber + 1
}
print(z)
print(cycleNumber)

# looping with repeat
z <- NA
cycleNumber <- 0
repeat {
  z <- runif(1) # code that will run until if statement is satisfied
  cycleNumber <- cycleNumber + 1
  if (z <= cutPoint) break # if statement will get us out of the loop
}
print(z)
print(cycleNumber)

# expand.grd to create a dataframe
# with all parameter combinations

expand.grid(cPars,zPars)
expand.grid(c=cPars,z=zPars)




  
