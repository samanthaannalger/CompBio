# plyr tutorial
# 2017-04-19
# Melanie

#install.packages("plyr")
library(plyr)

climate <- read.csv(file="ClimateData.csv")
climate$Month <- as.factor(climate$Month)
climate$Year <- as.factor(climate$Year)
str(climate)

# Using ddply: a simple example

# Use 'ddply' to calculate the mean air temperature for each month
ddply(climate, # input data frame
      "Month", # variable to subset by
      function(x){ # function to run on each subset
        mean(x$AvgAirTemp)
      }
)

# Alter the function slightly so that the output is easier to work with
monthlyData <- ddply(climate,
                     "Month",
                     function(x){ 
                       MeanAirTemp <- mean(x$AvgAirTemp)
                       data.frame(MeanAirTemp=MeanAirTemp)
                     }
)
print(monthlyData)

# Using ‘ddply’ to subset data based on multiple factors and perform a calculation

# Use 'ddply' to calculate the mean air temperature for each month-year combination
monthYearData <- ddply(climate,
                       c("Month","Year"),
                       function(x){ 
                         MeanAirTemp <- mean(x$AvgAirTemp)
                         data.frame(MeanAirTemp=MeanAirTemp)
                       }
)
print(monthYearData)

# Using 'ddply' to calculate multiple summary statistics

# Use 'ddply' to calculate, for each month, means and standard deviations for daily air
# temperature and precipitation
monthlyData <- ddply(climate,
                     "Month",
                     function(x){ 
                       
                       meanAirTemp <- mean(x$AvgAirTemp)
                       sdAirTemp <- sd(x$AvgAirTemp)
                       meanPrecip <- mean(x$Precip)
                       sdPrecip <- sd(x$Precip)
                       
                       data.frame(meanAirTemp=meanAirTemp,sdAirTemp=sdAirTemp,
                                  meanPrecip=meanPrecip,sdPrecip=sdPrecip)
                     }
)
print(monthlyData)

# Using 'summarize' within 'ddply'
# Calculate the mean air temperature for each month
monthlyData <- ddply(climate, # input data frame 
                     "Month", # variable to subset by
                     summarise, # "helper function" to run
                     MeanAirTemp = mean(AvgAirTemp)) # function to apply to each subset
print(monthlyData)

# Calculate the mean air temperature for each month-year combination
monthYearData <- ddply(climate, 
                       c("Month","Year"), 
                       summarise, 
                       MeanAirTemp = mean(AvgAirTemp))
print(monthYearData)

# Calculate, for each month, the mean and standard deviation for air temperature 
monthlyData <- ddply(climate, 
                     "Month", 
                     summarise, 
                     meanAirTemp=mean(AvgAirTemp), 
                     sdAirTemp=sd(AvgAirTemp))
print(monthlyData)

#Using ‘transform’ and ‘mutate’ within ‘ddply’
# Use 'transform' within 'ddply' to split your data into subsets, perform a calculation on
# each subset, and add the results to a copy of your input data frame as a new column
x <- ddply(climate, 
           "Month", 
           transform, 
           MonthlyMeanTemp = mean(AvgAirTemp))
head(x)

# 'Mutate' works similarly to 'transform', but allows you to do calculations within 'ddply'
# using columns you just created
x <- ddply(climate, 
           "Month", 
           mutate, 
           AvgMaxTemp = mean(MaxAirTemp),
           AvgMinTemp = mean(MinAirTemp),
           MonthlyMeanTempRange = AvgMaxTemp - AvgMinTemp)

# Using plyr for plotting
# Create boxplots of the mean daily air temperatures for each weather station
par(mfrow = c(1,2))
d_ply(climate, 
      "StationName", 
      summarise, 
      boxplot(AvgAirTemp, 
              xlab=unique(StationName), 
              ylab="Mean Daily Air Temperature (degrees C)"))

#Using other types of functions within ‘ddply’

# Use a linear model to examine how precipitation changes with air temperature within 
# each month
precipTemp <- ddply(climate, 
                    "Month", 
                    function(x) {
                      model <- lm(Precip ~ AvgAirTemp, data=x)
                      setNames(coef(model), c("Intercept", "Slope"))
                    }
)
print(precipTemp)

#Creating graphs using ‘ddply’ output

# For each month, calculate and graph the mean and standard deviation for air temperature 

monthlyData <- ddply(climate, 
                     "Month", 
                     summarise, 
                     meanAirTemp=mean(AvgAirTemp), 
                     sdAirTemp=sd(AvgAirTemp))
print(monthlyData)
head(x)

library(ggplot2)

p <- ggplot(monthlyData, aes(x=Month,y=meanAirTemp,colour=Month))
p <- p + geom_point(position=position_dodge(width=0.3), stat="identity", size = 3) 
p <- p + geom_errorbar(aes(ymin=meanAirTemp-sdAirTemp, ymax=meanAirTemp+sdAirTemp),
                       width=.1,position=position_dodge(.3))
print(p)
