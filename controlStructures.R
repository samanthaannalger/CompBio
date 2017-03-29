# Control structures for R programming
# Logical Operators
# 28 March 2017
# SAA

5 > 3
5 < 3
5 >= 3
5 <= 3
5 == 5 # is something equal to 5, booleon operator
5 != 3

# Compound & for AND
5 > 3 & 1!=2 # answer is TRUE, because both statements are true

# use | for OR
1 == 2 | 1 != 2 # TRUE because 'or' statement

# logicals work with vectors
1:5 > 3

a <- 1:10
b <- 10:1
a > 4 & b > 4

# use "long form" of & and | to find the first comparison that can be evaluated as a true, false, and just use that (to get a single value out)
a > 4 && b > 4

# also "long form" of |
a > 4 | b > 4
a > 4 || b > 4


# can use isTRUE to test whether any statement is a vector of length 1 that has a value of TRUE

z <- 0
isTRUE(z) # zero is a false
z <- 4
isTRUE(z)

# xor for exclusive or testing of vectors
a <- c(0,0,1)
b <- c(0,1,1)
a | b

xor(a,b) # exclusive "or" because both of them are true are on the last one

# Set Operations
# boolean algebra on sets of atomic vectors
# (logical, numeric, character strings)

a <- 1:7
b <- 5:10

# union for all elements
union(a,b)

# intersect to get common elements
intersect(a,b)

# set diff to get distinct elements
setdiff(a,b)
setdiff(b,a)

# set equal to check for identical elements
setequal(a,b)

# more generally to compare two objects
z <- matrix(1:12,nrow=4,byrow=TRUE)
z1 <- matrix(1:12, nrow=4, byrow=FALSE)
z==z1
identical(z,z1) #identical() works on entire object, not individual values
z <- z1
identical(z, z1)

# useful for if statements is %in% or is.element
d <- 12
d %in% union(a,b)
is.element(d,union(a,b))

# if statements-----------------------------------------------

# basic form:
# if (condition) expression

# if (condition) expression1 else
# expression2

# if (condition) expression1 else
# if (condition) expression2 else
# expression3

z <- signif(runif(1),digits=2)
print(z)
z > 0.5
if(z > 0.5) cat(z, "is a bigger than average number","\n")

if(z > 0.8) cat(z,"is a large number", "\n") else
if(z < 0.2) cat(z, "is a small number", "\n") else
{
  cat(z,"is an ordinary-sized number", "\n")
  cat("z^2 =", z^2, "\n")
}

# avoid multiple true false vectors for ifs
z <- 1:10

# this won't do anything
if(z > 7) print(z)

# but probably not what you want
if(z < 7) print(z)

# use subsetting here
print(z[z<7])

# ifelse function
# ifelse(test, yes, no)
# test is an object that can be coerced to yes, no
# yes returns values for true elements of test
# no returns values for the false elements of test

# insect in which each female lays, on average,
# 10.2 eggs (draw from a Poisson!)
# But 35% of females are parasitized and sterile

tester <- runif(1000)
eggs <- ifelse(tester>0.35,
               rpois(n=1000, lambda=10.2),
                     0)
head(eggs)
hist(eggs)
