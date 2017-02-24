#Subsetting in R 
#2017-02-21
# Samantha Alger

# control + L clears the Console

# Techniques for subsetting atomic vectors

z <- c(3.1, 9.2, 1.3, 0.4, 7.5)

# positive index values

z[c(2,3)] # will give you the second and third value of the atomic vector
z[-c(2,3)] # will give you all but the second and third value

# create a vector of logical values that are the same length as the target vector
z[z<3] # which values are less than 3?

# Breaking down the process (not actually how you would do it, but shows the process...)
tester <- z<3 #creates a vector of trues/falses for each value in z vector
print(tester)
z[tester]

# which function for index values
which(z<3) #position of values that are less than 3

z[which(z<3)] #gives values for less than 3- but overkill. no need to use 'which' function.

z[-(length(z):(length(z)-2))] #give us all values except (minus sign) the last three values in the dataframe (length of z: length of z -2)

#vector elements can have names
names(z) <- letters[1:5]
z
z[c("b","c")]

# Matrices and Dataframes

m <-matrix(1:12,nrow=3)
dimnames(m) <- list(paste("Species", LETTERS[1:nrow(m)], sep=""), paste("Site", 1:ncol(m),sep=""))
print(m)

# subsetting based on elements
m[1:2,3:4]

# or subset on character strings
m[c("SpeciesA","SpeciesB"), c("Site3","Site4")]

m[1:2,] #give me first two rows and all of the columns

m[ ,3:4] # gie me all the rows only 3 and 4th columns

#e.g. select columns for which the totals are > 15

#try this logical

colSums(m) > 15 #sums all columns and compares it to 15

sum <- colSums(m) #get the sum of each column
print(sum)

m[ ,colSums(m) > 15]

# select all rows for which the row total is 22

rowSums(m)==22 #double equal sign is a logical test! If you use only one, then you are assigning a value to the variable name!!!!!!

m[rowSums(m)==22, ] #gives all rows that equal 22- because the result is only exactly one value, the matrix becomes an atomic vector

m[rowSums(m)!=22, ]# give me the rows NOT equal to 22 "!="

# Choose all the rows for which the numbers for Site1 are less than 3
# And all the columns for which the numbers for SpeciesA are less than 5

#logical for the rows
m[,"Site1"] < 3

#Show this for all the columns
m[m[ ,"Site1"] < 3, ]

#logical for the columns
m["SpeciesA",] < 5

#Show this for all the rows
m[ ,m["SpeciesA",] < 5] 

###WHY IS THERE A COMMA HERE BEFORE m, but not above???

#Now combine the row and column selections
m[m[ ,"Site1"]<3, m["SpeciesA", ] < 5]
m

# caution, dropping down to 1 row or column creates a vector!
z <- m[1, ]
print(z)
str(z) #"named int" means it is now a vector

# use drop= false option to prevent this
z2 <- m[1, ,drop=FALSE]
print(z2) #did not lose the label as we did before when it dropped to a vector
str(z2) #query the structure and we see that z2 is still an integer, but it is a 2 dimentions- meaning it is a matrix. 

# only a few more things for data frames
data <- read.csv(file="antcountydata.csv",head=TRUE,sep=",", stringsAsFactor=FALSE)

#subsetting as usual on elements
data[3,2]

#Specify just column names, which are list elements
dataNames <- data[ ,c("state","county")] #smaller dataframe with only the columns of interest
data2Names <- data[c("state","county")]
str(data2Names)

# be careful to include both dimension in the data matrix

m[2, ]

m[ ,2]

m[2]
m

# Specify both dimensions
m[2,1]
