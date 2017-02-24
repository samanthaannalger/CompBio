# Samantha Alger
# Matrices, lists, dataframes
# 2017-02-16

# Matrices
a <- 1:12 #sequence function
print(a)

# creating a matrix from an atomic vector

m <- matrix(data=1:12,nrow=4,ncol=3)
print(m)

m <- matrix(data=1:12,nrow=4,byrow=TRUE)
print(m)

#use dim() 
#this will tell us the number of rows and columns in matrix m:

dim(m)
dim(m) <- c(6,2)
print(m)
dim(m) <-c(4,3)
print(m)

##Basic dimensions of the matrix:

#number of rows?
nrow(m)
#number of columns?
ncol(m)
#length of m?
length(m)

print(m)

#Add names of rows and columns
names(m)
rownames(m)
rownames(m) <- c("a","b","c","d")
print(m)

#Naming columns, the number of columns:
colnames(m) <- LETTERS[1:ncol(m)]
print(m)

#repeat 1, four times in a row
rownames(m) <- LETTERS[rep(1,4)]
print(m)

rownames(m) <-letters[1:nrow(m)]
print(m)
rownames(m) <- letters[nrow(m):1]
print(m)

# simple subsetting
# print a single element, element in the 2nd row and third column
print(m[2,3])

#printing a single element from row "c", column "C"
print(m["c","C"])

# print an entire row or column with empty subscript
#print row 3
print(m[3,])

#print first column
print(m[,1])

#prints entire matrix
print(m)
print(m[,])
print(m[])

#using paste function for automating names
#pastes "Site1", "Site2"... along rows, sep="" means separated by nothing
#pastes columns
rownames(m) <- paste("Site",1:nrow(m),sep="")
colnames(m) <- paste("Species",LETTERS[1:ncol(m)],sep="")
print(m)

#transpose matrix very easily with t
m2 <- t(m)
print(m2)

# Add additional rows or columns to existing matrix
#add row to matrix m

m2 <-rbind(m2,c(10,20,30,40))
print(m2)
rownames(m2) [4] <- "myFix" #changing row name
print(m2)

#to add a column with cbind()

m2 <-cbind(c(0.2,0.4,0.6,0.8),m2)
print(m2)
colnames(m2) [1] <- "myFix2" #changing column name
print(m2)

#calling specific elements in the matrix
m2["SpeciesA","Site2"] #eauals m2[1,3]
m2[c("SpeciesB", "SpeciesC"),c("Site1","Site4")]

# transform matrix back into vector
myVec <- as.vector(m)
print(myVec)

# Lists are atomic vectors
# but each element can be of any type we want and can hold other structures including other lists
myList <- list(1:10,matrix(1:8,nrow=4,byrow=TRUE),
               letters[1:3],pi)
print(myList)
str(myList)
myList[4]
#myList[4]-3
myList[[4]]-3 # double bracket says to go inside and grab the structure that we want (it will subtract 3 from 'pi')

#suppose a list with 10 elements in it
# [[5]] equals the contents of car #5
# [c(4,5,6)] equals a little train of cars 4, 5, and 6

myList[[2]]
myList[[2]][3,2] #can use double bracket to call the name of the element in the list, and [3,2] calls the element.

#pulling out results from stats in R with a list
varY <-runif(10)
varX <-runif(10)
myModel <-lm(varY~varX)
print(myModel)
summary(myModel)
plot(myModel)
plot(x=varX,y=varY)

#figure out structure of myModel so that you can call particular parts of the summary
str(summary(myModel))
names(summary(myModel))
summary(myModel)$coefficients
summary(myModel)$coefficients[2,4]


## Data Frames
# a data frame is a list of equal length atomic vectors
varA <- 1:12
varB <- rep(c("Con", "LowN", "HighN"), each=4) #4 values of each
varC <- runif(12)
dFrame <- data.frame(varA,varB,varC,stringsAsFactors = FALSE)
print(dFrame)
str(dFrame)

# add a row to data frame with rbind
# but we first must create it as a data frame

newData <- data.frame(list(varA=13,varB="HighN",varC=0.668),stringsAsFactors = FALSE)
str(newData) #create new data frame
dFrame <- rbind(dFrame,newData) # using rbind
str(dFrame)
tail(dFrame) # visualizing the end of the new dataframe to see the new row

#adding a column is more simple
newVar <-data.frame(varD=runif(13))
dFrame <-cbind(dFrame,newVar)
head(dFrame)
