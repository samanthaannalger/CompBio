# Random Subsetting and probability distributions
# 2017-02-23
# Samantha Alger

#grab the ant data
data <- read.table(file="antcountydata.csv", header=TRUE, sep=',', stringsAsFactors = FALSE)
littleData <- data[1:8,3:6]

# running sample with an integer
sample(10)

# applied to a vector, it radomizes the order of the elements
print(littleData$n.species)
sample(littleData$n.species)

sample(x=littleData$n.species,size=3)

# sample with replacement for bootstrapping
sample(x=littleData$n.species,size=20, replace = TRUE)

# sample sizes must match
# sample(x=littleData$n.species,size=20,replace=FALSE)

# suppose elements are not sampled equiprobably?
# community assembly and null models
mainlandSpecies <- paste("Species",1:10,sep="")
popSizes <- c(1000,500,100, 20,10,5,5,5,1,1)

# equiprobable colonization
islandA <- sample(x=mainlandSpecies,size=5)
print(islandA)

# assume colonization potential is proportional to population size
islandB <- sample(x=mainlandSpecies,size=5,prob=popSizes)
print(islandB)

# colonization now of individuals, not species
islandC <- sample(x=mainlandSpecies,size=100,prob=popSizes, replace = TRUE)
head(islandC)
table(islandC) #VERY USEFUL COMMAND TO SUMMARIZE LONG DATASETS
unique(islandC)
length(unique(islandC))

# colonization of equiproable individuals

islandD <-sample(x=mainlandSpecies,size=100,prob=NULL,replace=TRUE)
head(islandD)
table(islandD) #VERY USEFUL COMMAND TO SUMMARIZE LONG DATASETS
unique(islandD)
length(unique(islandD))
length(table(islandD)[table(islandD)>9])


#DISTRIBUTIONS#####################################

#Continuous
#normal, uniform, gamma, beta

#Discrete
#binomial (coin toss), poisson (event that occurs over a certain time interval), negative binomial (how long you have to wait for a particular event to occur).

# "d"= (density) is the height of a distribution
# "p" = (tail probability) - will give the distribution of the tail end 
# "q" = (quantile function)- What's the 95% confidence interval of a distribution
# "r" = (random sampling) - of a distribution

# dunif() give be the denisty values of a uniform distribution
# rbeta() give a random sample of actual numbers from a beta distribution

###########################################################

# Poisson distribution
# #frequency/rate of event occuring, discrete times per time step unit.
# "d" function gives the probability density
MyVec <- dpois(x=seq(0,10), lambda = 2) 
names(MyVec) <- seq(0,10)
barplot(height=MyVec)
sum(MyVec)

MyVec <- dpois(x=seq(0,10), lambda = 0.1)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

MyVec <- ppois(q=seq(0,10), lambda = 2)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

qpois(p=c(0.0275, 0.975), lambda=50)


x <- rpois(n=1000,lambda=1.1) #take a random distribution from a poisson distribtion with lambda of 1.1
hist(x) #plot it


# Binomial
# p = probability of dichotomous outcome
# size = number of trials
# x = possible outcomes

MyVec <- dbinom(x=seq(0,10),size=10,p=0.5) # Fair Coin
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

MyVec <- dbinom(x=seq(0,10),size=10,p=0.75) # Not Fair coin, probability of getting one value is more likley
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

qbinom(p=c(0.025,0.975), size=100, prob = 0.75)

#If the coin has a probablity of 75% of coming up, then you will see a head 66-83% of the time. 

# Negative binomial: number of failures (values of MyVec) in a series of
# Bernouli trials with probability of
# Success p, before we reach a target
# Number of successes
# more heterogeneous ("overdispersed")
# than a Poisson

MyVec <- dnbinom (x=seq(0,40), size=5,prob=0.5)
names(MyVec) <- seq(0,40)
barplot(height=MyVec)

MyVec <- dnbinom (x=seq(0,40), size=1,prob=0.1)
names(MyVec) <- seq(0,40)
barplot(height=MyVec)

# alternatively specify mean = mu
# size is a dispersion parameter
# small values of size give overdispersion

MyVec <- dnbinom (x=seq(0,40), size=5, mu=5)
names(MyVec) <- seq(0,40)
barplot(height=MyVec)

MyVec <- dnbinom (x=seq(0,40), size=10, mu=5)
names(MyVec) <- seq(0,40)
barplot(height=MyVec)

#pbinom for tail distribution
pnbinom(q=3,size=1,mu=5)

#qnorm for actual values for a p
qnbinom(p=0.05,size=10,mu=5)

#confidence interval
qnbinom(p=c(0.025,0.975),prob=0.5,size=10)

#random sample from negative binomial
MyVec <-rnbinom(n=1000, size=1,mu=20)
quantile(MyVec,prob=c(0.025,0.975))
qnbinom(p=c(0.025,0.975),size=1,mu=20)

# uniform
# params for minimum and maximum

limits <- seq(0,10,by=0.01)
z <- dunif(x=limits, min=0,max=5)
names(z) <- limits
plot(x=limits,y=z,type="l",xlim=c(0,10))

# punif for tail probabilities

limits <- seq(0,10,by=0.1)
z <- punif(q=limits,min=0,max=5)
names(z) <- limits
plot(x=limits,y=z,type="l", xlim=c(0,10))

#qunif for quantiles

qunif(p=c(0.025,0.975),min=0,max=5)


# runif to generate data
hist(runif(n=1000,min=0,max=5))

#----------------------------------
# normal distribution

hist(rnorm(n=100,mean=100,sd=2))
hist(rnorm(n=100,mean=2,sd=2))
MyVec <- rnorm(n=100,mean=2,sd=2)
summary(MyVec)

# To grab all values greater than zero:
TossZeroes <- MyVec[MyVec>0]

hist(TossZeroes)
summary (TossZeroes)

# gamma distributions :a normal distribtion bounded at zero (continuous)
# 2 parameters: shape1,shape2
# continuous, positive values

hist(rgamma(n=100,shape=1,scale=10))

#gamma with shape =1 gives an exponential with scale=mean
hist(rgamma(n=100,shape=0.1,scale=10))

#large shape parameter looks like normal
hist(rgamma(n=100,shape=20,scale=1))

# mean=shape*scale
#variance = shape*scale^2

# beta distribution
# continuous
# bounded between 0 and 1 (unique): 
# probability, measuring organisms along an environmental gradient
# parameter shape1 = number of successes + 1
# parameter shape2 = number of failures + 1

# shape1 = 1 shape2 = 1 "no data"
hist(rbeta(n=1000,shape1=1,shape2=1),breaks=seq(0,1,length=100))

# shape1 = 2, shape2 = 1 "1 head"
hist(rbeta(n=1000,shape1=2,shape2=1),breaks=seq(0,1,length=100))


# two tosses, 1 head, 1 tail

hist(rbeta(n=1000,shape1=2,shape2=2),breaks=seq(0,1,length=100))

# two tosses, both heads
hist(rbeta(n=1000,shape1=3,shape2=1),breaks=seq(0,1,length=100))

# more data equal counts
hist(rbeta(n=1000,shape1=20,shape2=20),breaks=seq(0,1,length=100))

# more the data we get, the more the distribution shrinks in to a particular value

# more data unequal counts
hist(rbeta(n=1000,shape1=200,shape2=10),breaks=seq(0,1,length=100))

# shape parameters less than 1?
hist(rbeta(n=1000,shape1=0.4,shape2=0.4),breaks=seq(0,1,length=100))

#------------------------------------------

# In reality, we have real data and we want to generate a distribution using a particular distribution and we want to estimate the parameters, given our real data.

# estimating parameters from data
# maximum likelihood estimation (mean and sd)
# maximize p(data|parameters)

library(MASS)
#create dataset with simulated parameters 
x <- rnorm(1000,mean=92.5,sd=2.5)
hist(x)

#check mean and sd using fitdistr
fitdistr(x,"normal")
#check a different way
mean(x)
sd(x)

# but what should we fit to?
z <- fitdistr(x,"gamma")
str(z)

# rate = 1/scale
# so here is the estimate of the mean
z$estimate[1]/z$estimate[2]

#estimate of variance
z$estimate[1]/z$estimate[2]^2
