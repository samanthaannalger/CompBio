# Working with functions
# 2 March 2017
# SAA

# everything in R is a function
sum(3,2) # "prefix" function
3 + 2 # "operator" is a function
`+`(3,2) # "infix" function
y <- 3
`<-`(yy,3) # infix
print(yy)

# to see the contents of a funciton, print it
print(read.table)
sum(3,2)
print(sum)
sum()

###############################################
# FUNCTION: HardyWeinberg
# input: p, an allelic frequency (0,1)
# output: p and three genotype frequencies
#---------------------------------------------------------
HardyWeinberg <- function(p=runif(1)) {
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2

  vecOut <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
  return(vecOut)
}
##################################################
HardyWeinberg()
pp <- 0.7
HardyWeinberg(pp)

HardyWeinberg(1.2)

# Use multiple return() statements to generate
# different possible outcomes

###############################################
# FUNCTION: HardyWeinberg2
# input: p, an allelic frequency (0,1)
# output: p and three genotype frequencies
#---------------------------------------------------------
HardyWeinberg2 <- function(p=runif(1)) {
  if(p > 1.0 | p < 0.0) {
    return("Function failure: p must be >=0 and <=1")
  }
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  
  vecOut <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
  return(vecOut)
}

##################################################

HardyWeinberg2()
HardyWeinberg2(0.5)
HardyWeinberg2(1.2)
z <- HardyWeinberg2(1.2) # This way of returning a failure message can cause insidious error messages way down the road, especiallly when you assign a variable to the answer of the function like this.

# A better way would be for the function to not run at all....and use the stop() function instead of return()

###############################################
# FUNCTION: HardyWeinberg3
# input: p, an allelic frequency (0,1)
# output: p and three genotype frequencies
#---------------------------------------------------------
# Use stop function for true error trapping
HardyWeinberg3 <- function(p=runif(1)) {
  if(p > 1.0 | p < 0.0) {
    stop("Function failure: p must be >=0 and <=1")
  }
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  
  vecOut <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
  return(vecOut)
}
##################################################
HardyWeinberg3(1.2)
z <- HardyWeinberg3(1.2)

# Scoping in functions
# global variables: not in functions, visible to
# all parts of code, declared in main body
# local variables visible only within function
# created in function or passed through as parameter

myFunc <- function(a=3,b=4) {
  z <- a + b
  return(z)
}

myFunc()
print(a)

myFuncBad <- function(a=3) {
  z <- a + b
  return(z)
}
myFuncBad() # function fails because b is not assigned

b <- 10 # now put b into the global environment
myFuncBad() # and it runs. This is not the best way to code, Do not want to have functions reaching out into the global environment to find the variable. Have all variables defined the function in the local environment

myFuncOK <- function(a=3) {
  bb <- 100
  z <- a + bb
  return(z)
}
myFuncOK() # This runs because all variables are defined locally. 

# Simple linear regression function

#########################################################
# FUNCTION: fitLinear
# fits a simple OLS regression
# inputs: numeric vector of predictor (x) and response (y)
# outputs: slope and p-value
#_____________________________________________________________

fitLinear <- function(x=runif(10),y=runif(10)){
  myMod <- lm(y~x)
  myOut <- c(slope=summary(myMod)$coefficients[2,1],
             pvalue=summary(myMod)$coefficients[2,4])
  plot(x=x,y=y)
  return(myOut)
          }
fitLinear()

#########################################################
# FUNCTION: fitLinear2
# fits a simple OLS regression
# inputs: numeric vector of predictor (x) and response (y)
# outputs: slope and p-value
#_____________________________________________________________
fitLinear2 <- function(x=NULL,y=NULL){ # we can make the defaults as complicated as we                                              want by adding another line after... 
  if(is.null(x) & is.null(y)) {
    x <- runif(20)
    y <- 0.5 + 2*x + rnorm(n=20, mean=0,sd=0.2)
  }
  
  myMod <- lm(y~x)
  myOut <- c(slope=summary(myMod)$coefficients[2,1],
             pvalue=summary(myMod)$coefficients[2,4])
  plot(x=x,y=y)
  return(myOut)
}
fitLinear2()

# passing a parameter list with do.call
z <- c(runif(99),NA)
mean(z)
mean(x=z,na.rm=TRUE)
mean(x=z, na.rm=TRUE,trim=0.05)
parList <- list(x=z,na.rm=TRUE,trim=0.05)
do.call(mean.parList)





