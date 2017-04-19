# Randomization tests
# 11 April 2017
# SAA

# Procedures
# 1) define univariate metric, x
#     (a single number that characterizes a pattern)
# 2) calculate x for observed data x observed
# 3) randomize data subject to some constraints
# 4) calculate x for randomized data, x sim
# 5) repeat (4) many times (n=1000)
#     (generate a distribution of x sim) visualize as a histogram
# 6) compare x observed to x sim
#     p(Xobs|Ho) (probability of x observed, given null hypothesis)
# 7) Draw biological inference

setwd("~/CompBio")

# Compare ant species richness among different New England ecotypes
data <- read.table(file="antcountydata.csv",
                   header=TRUE,
                   sep= ",",
                   stringsAsFactors = FALSE)

data$ecoregion <- as.factor(data$ecoregion) # reclassify existing variable

boxplot(data$n.species~data$ecoregion, col="indianred")
myModel <- aov(n.species~ecoregion, data=data)
summary(myModel)

# define response metric
# use variance among treatment means as X

####################################################################
# FUNCTION: VarMeans
# calculates variance among a group of treatment means
# input: vector of groups, vector of group means
# output: among group variance of means
# ------------------------------------------------------------------
VarMeans <- function(fac=NULL, res=runif(25)) {
  if(is.null(fac)){
    fac <- as.factor(rep(LETTERS[1:5],each=5))
  }
  temp <- aggregate(x=res,by=list(fac),FUN=mean)
  return(var(temp$x))
  # return(var(temp[,2]))
}
VarMeans()

# Specify treatment randomization

###################################################################
# FUNCTION: TreatRan
# randomize treatment (factor) labels
# input: vector of observed treatment labels
# output: vector of randomized treatment labels
# ------------------------------------------------------------------
TreatRan <- function(fac=NULL) {
if(is.null(fac)){
    fac <- as.factor(rep(LETTERS[1:5],each=5))
  }
    fac <- sample(fac, replace=FALSE)
  
  return(fac)
}
TreatRan()

# Now write function for summary and plots
####################################################################
# FUNCTION: randomizeSummary
# give summary stats boxplots, and hisogram plot
# input: vector of simulated values, observed value
# output: list of null model statistics, graphs

# ------------------------------------------------------------------
randomizeSummary <- function(obsX=runif(1),
                             simX=runif(1000),
                             fac=NULL,
                             res=runif(25)) {
  if(is.null(fac)) {
    fac <- as.factor(rep(LETTERS[1:5],each=5))
}

pLow <- mean(simX <= obsX) # gets the proportion of observed values that are greater or equal to the simulated values
pHigh <- mean(simX >= obsX) # gets the proportion of observed values that are less than or equal to the similared values (tail end)
meanSimX <- mean(simX)
varSimX <- var(simX)
SES <- (obsX = mean(simX))/sd(simX) # if the observed is larger than the simulated, than we will generate a positive value. less than, get a negative value.

outList <- list(stats=list(obsX=obsX,
                           meanSimX=meanSimX,
                           varSimX=varSimX,
                           pLow=pLow,
                           pHigh=pHigh,
                           SES=SES,
                           reps=length(simX)),
                           raw=simX)

par(mfrow=c(1,3))

# Show boxplot of real data
boxplot(res~fac,col="indianred")
mtext("Observed Data",side=3,font=2,cex=0.75)

# Show boxplot of simulated data
boxplot(res~sample(fac),col="goldenrod")
mtext("Simulated Data",side=3,font=2,cex=0.75)

# Show histogram of simulated and observed values
hist(simX,breaks=25,
     col="goldenrod",
     main="Null Distribution",
     xlab="Simulated Response",
     xlim=c(0,max(c(simX,obsX))))

# calculating 95% (and 97.5%) conidence intervals
Interval95 <- quantile(x=simX, prob=c(0.05,0.95))
Interval975 <- quantile(x=simX, prob=c(0.025,0.975))


abline(v=obsX,col="indianred", lwd=2)
abline(v=Interval95,col="black", lwd=2, lty="dotted")
abline(v=Interval975,col="black", lwd=2, lty="dashed")
par(mfrow=c(1,1))

return(outList)

}

z <- randomizeSummary()
#-----------------------------------------
# global variables
filename <- "antcountydata.csv"
data <- read.table(file=filename,
                   header=TRUE,
                   sep=",",
                   stringsAsFactors = FALSE)
data$ecoregion <- as.factor(data$ecoregion)
grps <- data$ecoregion
richness <- data$n.species
nreps <- 1000
outVec <- vector(mode="numeric", length=nreps)

obsX <- VarMeans(fac=grps,res=richness)

# for (i in 1:nreps) {
#  outVec[i] <-VarMeans(fac=TreatRan(grps), res=richness)
# }

# runif(1)
# runif(5)
# replicate(5,runif(1))
# replicate(5,runif(3)) # creates a matrix with 5 columns and 3 rows of random numbers between 0 and 1

outVec <- replicate(nreps,VarMeans(fac=TreatRan(grps),
                                   res=richness))

z <- randomizeSummary(obsX=obsX,simX=outVec,fac=grps,
                      res=richness)
