#Bringing data into R
# 2 February 2017
# SAA

#Importing county ant data
z <-read.table ("antcountydata.csv", header=TRUE, row.names=1, sep=",",stringsAsFactors = FALSE)

#tell us the structure of variable 'z'
str(z)

#Control+Return= runs a single line

#Look through the str(z) results to make sure no numerical data have 'chr' associated with it. meaning that a letter or comma is mixed into a cell of that column and making it read as character instead of a number or integer.

#Use summary to summarize numeric variables
summary(z)

#use table to check character strings
table(z$state)
table(z$ecoregion)

#create a contingency table to look at two variables!
table(z$state,z$ecoregion)

#creating regular expressions... NEXT class....