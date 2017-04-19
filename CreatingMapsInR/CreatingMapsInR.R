# Spatial Data tutorial
# https://cran.r-project.org/doc/contrib/intro-spatial-rl.pdf
# 2017-04-18


# PACKAGES AND DATA READ IN------------------------------------
x <- c("ggmap", "rgdal", "rgeos", "maptools", "dplyr", "tidyr", "tmap")
#install.packages(x)
lapply(x, library, character.only = TRUE)

setwd("~/CompBio/CreatingMapsInR/Creating-maps-in-R-master") # setting working directory

lnd <- readOGR(dsn = "data", layer = "london_sport") # Read in the data

# STRUCTURE OF SPATIAL DATA IN R------------------------------

# spatial objects such as lnd are made up of different 'slots', key slots being '@data' (non geographic attribute data) and @polygons (or @lines for line data) (polygons that make up the physicial boundaries). Specific slots are accessed using the '@' symbol.

head(lnd@data, n = 2) # use the @ symbol to refer to the data slot of the lnd object
mean(lnd$Partic_Per) # use the $ symbol to refer to the Partic_Per column (a variable within the table) in the data slot, which was identified from the result of running the first line of code.

sapply(lnd@data, class) # To check the classes of all the variabes in a spatial dataset, you can use this command

lnd$Pop_2001 <- as.numeric(as.character(lnd$Pop_2001)) # Unexpectedly, Pop_2001 is a factor, coerce the variable into the correct, numeric format...

# type "lnd@" and then tab to see which slots are in lnd...

#check number of rows and columns...
nrow(lnd)
ncol(lnd)

# BASIC PLOTTING-------------------------------------------
plot(lnd)

# select rows of lnd@data where sports participation is less than 15
lnd@data[lnd$Partic_Per < 15, ] # This is interrogating the attribute data slot only of the lnd object..

#Using the same logic to subset and plot spatial objects (gometry slot)...

# Select zones where sports participation is between 20 and 25%
sel <- lnd$Partic_Per > 20 & lnd$Partic_Per < 25
plot(lnd[sel, ]) # output not shown here
head(sel) # test output of previous selection (not shown)

# To see these areas in context with other areas of the maps... use add= TRUE..

plot(lnd, col = "lightgrey") # plot the london_sport object
sel <- lnd$Partic_Per > 25
plot(lnd[ sel, ], col = "turquoise", add = TRUE) # add selected zones to map

#BLUE areas represent areas of high sports participation highlighted in blue

# Find the centre of the london area
lat <- coordinates(gCentroid(lnd))[[1]]
lng <- coordinates(gCentroid(lnd))[[2]]
# arguments to test whether or not a coordinate is east or north of the centre
east <- sapply(coordinates(lnd)[,1], function(x) x > lat)
north <- sapply(coordinates(lnd)[,2], function(x) x > lng)
# test if the coordinate is east and north of the centre
lnd@data$quadrant[east & north] <- "northeast"

# CREATING AND MANIPULATING SPATIAL DATA--------
