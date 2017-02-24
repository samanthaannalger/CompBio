# Samantha Alger
# Basic Data Structures in R
# 2017-02-14

# Use the assignment operator
x <- 5 #preferred
y = 4 #legal but confusing
y = y + 1.1
y <- y + 1.1 #best way of storing the variable

print(y)

# Variable names

z <- 3 # begin lower case
plant_height <- 3.3 #looks gangly
plant.height <- 4 #somtimes used in functions
plantHeight <- 3 #camelCaseFormatting

# the combine function
z <- c(3.2, 5, 5, 6) # making 'z' a vector using combine function
print(z)
typeof(z)
is.numeric(z)
z <- c(c(3,4),c(5,6))
print(z)

# character strings surrounded by single or double quotes

z <- c("perch","bass",'trout') #single or double quotes both work
print(z)

z <- c("This is only 'one' character string", "this is a second")
print(z)
typeof(z)
is.numeric(z)

# building logicals
# no quotes, all caps
z <- c(TRUE, TRUE, FALSE)
typeof(z)

# Three Properties of all vectors:
# type
is.logical(z)
typeof(z)
str(z)

# Length
length(z)

# names
z <- runif(5) # random number generator, generating 5 random values between 0 and 1
print(z)

# names are optional
names(z)
names(z) <- c("chow","pug","beagle","greyhound","akita")
print(z)

# add names with variable creation (with or without quotes)

z2 <- c(gold=3.3, silver=10, lead=2)
names(z2) <-NULL
print(z2)

## Three features of atomic variables
# Coercion

z <- c(3,"eggs")
typeof(z)
print(z)

# hierarchy of coercion

# logical -> integers -> double -> character

# Comparison operators yield a logic variable

a <- runif(10)
a > 0.5
print(a)

# how many elements are greater than 0.5?
sum(a > 0.5)

# what proportion of the elements are greater than 0.5?
mean(a > 0.5)

# Qualifying exam question: What proportion of observations drawn from normal distribution mean 1, variance 1, are larger than 2.0?

mean(rnorm(1000) > 2)

### Vectorization
z <- c(10,20,30) 
z + 1 #adds a one to each value of the vector

y <- c(1,2,3)
z + y #each element in order, has been added

y <- c(1,2)
z^2 + z

#Recycling
y <- c(1,2)
z <- c(10,20,30)
y + z # because vectors are different length, the 1 gets added back to the last value

z <-c(10,20,30,40)
y + z  #Does not give a warning message bc a multiple of shorter length, so the vector added (y) is added twice.

#Creating Vectors
z <- vector(mode="numeric", length=0)
print(z)
# add element to z
z <- c(z,5)

#create vector of predetermined length

z<- rep(0,100)
str(z)

z <- rep(NA,100)
print(z)
typeof(z)

z[1] <- "Washington"
typeof(z) #changes from logical to character. followed coercion rules, mix logical and character- vector becomes character type of vector. 
