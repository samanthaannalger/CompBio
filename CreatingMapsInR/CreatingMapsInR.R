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

# create a vector and dataframe
vec <- vector(mode = "numeric", length = 3)
df <- data.frame(x = 1:3, y = c(1/2, 2/3, 3/4))

#check the class of these objects:
class(vec)
class(df)

# Create a spatial points object with the dataframe:
sp1 <- SpatialPoints(coords = df)

# spatial points object is one of the fundamental data types for spatial data. 
# Others: lines, polygons, and pixels and can be created
# with 'SpatialLines, SpatialPolygons, SpatialPixels etc.'

class(sp1)

# Adding DataFrame allows you to add data from the df... HOW IS THIS DIFFERENT FROM THE ABOVE????

spdf <- SpatialPointsDataFrame(sp1, data = df) class(spdf)

# Projections--------------------
# CRS = Coordinate Reference System

proj4string(lnd) <- NA_character_ # remove CRS information from lnd 

proj4string(lnd) <- CRS("+init=epsg:27700") # assign a new CRS

EPSG <- make_EPSG() # create data frame of available EPSG codes 

EPSG[grepl("WGS 84$", EPSG$note), ] # search for WGS 84 code

lnd84 <- spTransform(lnd, CRS("+init=epsg:4326")) # reproject

# Save lnd84 object (we will use it in Part IV)
saveRDS(object = lnd84, file = "data/lnd84.Rds")

rm(lnd84) # remove the lnd object
# we will load it back in later with readRDS(file = "data/lnd84.Rds")

# Attribute Joins---------------------

library(rgdal) # ensure rgdal is loaded

# Create new object called "lnd" from "london_sport" shapefile 
lnd <- readOGR(dsn = "data", "london_sport")
plot(lnd) # plot the lnd object (not shown)
nrow(lnd) # return the number of rows (not shown)

# Create and look at new crime_data object
crime_data <- read.csv("data/mps-recordedcrime-borough.csv", stringsAsFactors = FALSE)

head(crime_data$CrimeType) # information about crime type

# Extract "Theft & Handling" crimes and save
crime_theft <- crime_data[crime_data$CrimeType == "Theft & Handling", ] 
head(crime_theft, 2) # take a look at the result (replace 2 with 10 to see more rows)

# Calculate the sum of the crime count for each district, save result
crime_ag <- aggregate(CrimeCount ~ Borough, FUN = sum, data = crime_theft) # Show the first two rows of the aggregated crime data
head(crime_ag, 2)

# Compare the name column in lnd to Borough column in crime_ag to see which rows match.
lnd$name %in% crime_ag$Borough

# Return rows which do not match
lnd$name[!lnd$name %in% crime_ag$Borough]

# Joining the attribute tables to create a map with coded counties for crime rates:

library(dplyr)

head(lnd$name) # dataset to add to (results not shown) 
head(crime_ag$Borough) # the variables to join

lnd@data <- left_join(lnd@data, crime_ag, by = c('name' = 'Borough'))

library(tmap) # load tmap package (see Section IV) 
qtm(lnd, "CrimeCount") # plot the basic map
