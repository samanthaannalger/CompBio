# RandomForest Tutorial
# 2017-04-26
# SAA

install.packages("scatterplot3d")
install.packages('randomForest') 
install.packages('caTools')
install.packages('pROC')
install.packages('MASS')

library("randomForest")
help("randomForest")

# Store iris in a new data fram 

Dframe <- iris

# Let's get started 
set.seed(123) # to get reproducible random results

# Split iris data to training data and testing data
# Train the model with 70% of data and test it 
# with the remaing %30 of the data. 
spl <- sample(2,nrow(Dframe),replace=TRUE,prob=c(0.7,0.3)) 
print(spl)

str(spl)

# define the training data 
trainData <- Dframe[spl==1,]
head(trainData)

# Test data 
testData <- Dframe[spl==2,]
head(testData)

# Generate random forest with training data 
irisRF <- randomForest(Species~.,data=trainData, mtry= 3, ntree=200,proximity=TRUE) 
help(randomForest)

# Print Random Forest model and see the importance features
print(irisRF)

# Confusion matrix for train data
table(predict(irisRF),trainData$Species) 

# Plot random forest 
plot(irisRF)

# Look at importance of independant vars
importance(irisRF)

# Plot importance 
varImpPlot(irisRF)

# Now build random forest for testing data
help("predict.randomForest")

irisPred <- predict(irisRF,newdata=testData)
print(irisPred)

table(irisPred, testData$Species)

#Now, let's look at the margin, positive or negative,
# if positive it means correct classification
help("margin.randomForest")
plot(margin(irisRF,testData$Species))

#------------------------------------------------------
####### EXAMPLE 2: Using MASS package ##################

# Begin by importing two libraries 
library(randomForest)
library(MASS)

# set seed 
#help("set.seed")
set.seed(1234)

# Store data "birthwt" data set from the MASS package into a DataFrame 

#help("birthwt")
dFrame <- birthwt

# Identify predictor variables and target variable
# Identify catagorical target variable 
#head(dFrame)
#str(dFrame)
#View(dFrame)

# see how many unique values are within each variable 
# for "low"
length(unique(dFrame$low))

hist(dFrame$low)

length(unique(dFrame$bwt))

hist(dFrame$bwt) # continuous variable 

# another way to view unique values for all variables
apply(dFrame,2,function(x) length(unique(x))) 

help(apply) # 2 in this function indicates columns

# Now convert catagorical variables using as.factor so 
# they are treated as numerical data by randomForest

# Begin by placing the variables you need to convert into a new placehoder 
# variable cVars (catagorical variables)
cVars <- c("low", "race", "smoke", "ptl", "ht", "ui", "ftv")

# use a for loop to go over data frame (dFrame) 
for(i in cVars){
  dFrame[,i]=as.factor(dFrame[,i])
}
str(dFrame) # we see that the numerical values for the 