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

} # end of for loop
  return(n)
  
} # end of function


head(RanWalk())
plot(RanWalk(),type="o")
