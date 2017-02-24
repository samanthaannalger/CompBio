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

