# Lecture #24: Base Graphics I
# SAA
# April 25, 2017

# Preserving Defaults, Attaching A Data Frame
####################################################
#  Standard calls for preserving defaults, and reading a csv
par() # a ridiculous number of graphic parameters
opar <- par(no.readonly=TRUE) # store defaults of changeable options

Ant.Data <- read.table(file="antcountydata.csv",
                       header=TRUE,
                       sep=",",
                       stringsAsFactors=FALSE)
attach(Ant.Data) # to cut down on typing of data frame name, can call column names without referring the the df each time


# Basic Graphs & Lines
plot(x=lat.centroid,y=n.species,log="y") # log transforms; use x,y, or xy
plot(x=lat.centroid,y=n.species)
abline(h=20) # drawing a horizontal line
abline(v=46,lwd=2,lty="twodash",col="grey") # drawing a vertical line
abline(a=-1600,b=40) # intercept and slope
abline(lm(n.species~lat.centroid)) # standard regression
lines(lowess(n.species~lat.centroid),col="blue",lty="dotdash",lwd=2.5)
rug(lat.centroid) # show the density of data points
rug(n.species,side=2) # can be done on any axis for any variable
grid()
box(which="outer") # box options: outer, inner, figure, plot
box(col="gray",lwd=5)
text(44,60,"my text here at 44,60") # coordinates are in the x y frame

# Standard Axes
par(opar)
x <- 1:1000
y <- runif(1000,0.2)
plot(x,y,type="l",col="grey",ylim=c(0,1.2))
grid(nx=NA,ny=NULL,col="black")

# adjustments for standard axes

# use  xlim and y lim for clipping or adding white space
plot(x,y,type="l",col="grey",xlim=c(400,600),ylim=c(-1,1))

# use xlim and ylim reversed to flip axes
plot(x,y,,type="l",col="grey",xlim=c(1000,0))

# use lab for ticks x,y, len of label (default=7)
plot(x,y,type="l",col="grey",ylim=c(0,1.2),
     lab=c(1,5,7))

# use mgp for lines of text from edge. 3 numbers are:
# 1) margin label; 2) tick mark labels; 3) axis line
# defaults are 3,1,0

plot(x,y,type="l",col="grey",ylim=c(0,1.2),
     mgp=c(0,1,0)) # pulls in label

plot(x,y,type="l",col="grey",ylim=c(0,1.2),
     mgp=c(3,-1,0)) # pulls in label to inside


plot(x,y,type="l",col="grey",ylim=c(0,1.2),
     mgp=c(3,1,1)) # moves out entire axis

# use tcl to control length and direction of ticks; default=-0.5
plot(x,y,type="l",col="grey",ylim=c(0,1.2),
     tcl=1,lab=c(5,5,7))

# could pull in labels and use inner tick marks
# use las to flip tick labels to all horizontal
plot(x,y,type="l",col="grey",xlim=c(-40,1000),ylim=c(0.17,1),
     tcl=0.3,mgp=c(2,0.2,0),las=1,ann=FALSE,bty="L")

# use xlog in par or log in plot for transform
plot(x,y,type="l",col="grey",log="x")

# use xaxs and yaxs to control style of axis setting
# default = r = expanded range
# or set as i = exact range

par(pty="s")
par(mfrow=c(2,1))
par(mar=c(2,2,1,1)) # for adjusting distance on axis and above and below the figure
plot(x,y,type="l",col="grey",ann=FALSE,xaxs="r")
plot(x,y,type="l",col="grey",ann=FALSE,xaxs="i")
Custom Axes
par(opar)
# create random data with gamma distribution
x <- 1:20
y <- rgamma(20,1,2)

# set x limit to avoid clipping at start
par(mar=c(5,4,4,4))
plot(x,y,type="b",pch=23,bg="slateblue",
     xlim=c(0,20),ylim=c(0,1.3),
     axes=FALSE,ann=FALSE)

# use sequence and take default tick labels
axis(1,at=seq(0,20,by=5))

# use mtext to add text labels in the margins
mtext("Time",1,line=3)

# use sequence and override with user labels
axis(2, at=seq(0,1.3,length=4),labels=c("low","med","high","peak"),
     las=2)

# thicken up tick lines and move axis out a bit
axis(3,at=seq(0,20,by=5),line=1,lwd=2,lwd.ticks=2,font=2)

# move the axis and ticks inward with the mgp argument
axis(4,at=seq(0,1.3,length=4),labels=c("l","m","h","p"),
     las=2,mgp=c(0,1.4,1.9),tcl=2,
     col.axis="red",col="slateblue")

# overplot the axis to easily create minor tick marks
axis(4,at=seq(0,1.3,length=7),labels=FALSE,
     mgp=c(0,1.4,1.9),tcl=0.75,
     col="slateblue")
par(opar)

# Cleaned Up Regression
par(mar=c(5,6,2,2)+0.1)
plot(x=lat.centroid,y=n.species,
     xlab="Latitude",ylab="Number of Species",
     las=1,cex.axis=1.2,cex.lab=1.5)
reg.model <- lm(n.species~lat.centroid)
abline(reg.model)
rug(n.species,side=2)
grid()

#Text Annotations
x <- 1:5
y <- seq(1,5,1)
plot(x,y)
text(1,1,"right",pos=4) # use pos to offset the text
# use vectors for multiple plotting
plot(x,y,ann=FALSE, axes= FALSE, col="green")
box(col="gray")
text(x[-3],y[-3],c("right","top","bottom","left"),pos=c(4,3,1,2)) # -3 takes away point # 3 and plots labels on points 1, 2, 4, and 5
# pos is the position of where the label is put in relation to the point
text(3,3,"overlay")
text(4,2,"angle = 10 degrees",srt=10) # angled text centered over coordinate 4, 2. 

# illustration of plot math
plot(x,y,ann=FALSE, axes= FALSE, type="n")
box(col="gray")

text(3,4,
     expression(sqrt(x[i]^2+y[i]^2)-hat(beta)))


text(3,3,
     expression(bar(x) == sum(frac(x[i], n),
                              i == 1,n)))

# alter size, color, font, and rotation
text(3,3,
     expression(bar(x) == sum(frac(x[i], n),
                              i == 1,n)),
     cex=4,col="red",font=1,srt=-10)

text(3,2,
     expression(paste("Temperature (", degree,
                      "C) in 2013")))
# Graphical Annotations
x <- 1:10
y <-runif(10)

plot(x,y,type="n",xlim=c(0,10),ylim=c(0,1))

points(x,y)
lines(x,y)

xspline(x,y,shape=0) # -1,0,1
xspline(x,y,shape=1,open=FALSE)
polygon(x,y,col="coral")

rect(8,0.1,10,0.2,col="blue")
rect(0,0,x,y,lty="dashed")
segments(0,1,3,0)
segments(0,0,x,y)
arrows(0,0,x,y)
points(0,0)

#Clean Up & Detach
detach(Ant.Data) # detach ant data
par(opar) # restore original parameters

# Panel Layout & 4 Variations On Plot Type
####################################################
# illustrating panel layout and 4 variations on plot type
Random.Data <- rnorm(20)
time <- 1:20
par(mfrow=c(3,2)) # gives a grid of 3 rows and two columns
plot(Random.Data,type="p")
plot(Random.Data,type="l")
plot(Random.Data,type="b")
plot(Random.Data,type="o")
plot(Random.Data,type="s")
plot(Random.Data,type="h")

par(opar)
plot(Random.Data,type="n")
# Special Plots With Linear Model
attach(Ant.Data)
####################################################
# illustrating special plots that come with a linear model
par(mfrow=c(2,2))
Ant.Model <- lm(n.species~lat.centroid)
summary(Ant.Model)
plot(Ant.Model)
plot(lat.centroid,n.species)
abline(Ant.Model)
abline(h=10,lty="dashed")
abline(v=45,col="red",lty="dotdash")

# Plots In A Single Dimension
# illustrating plots for a single dimension of data
par(mfrow=c(1,2))

plot(n.species) # plots numeric data in order
plot(table(ecoregion)) # plots tabled counts of factors as lines

barplot(table(ecoregion))
Little.Data <- c(3,2,1,5,6)
names(Little.Data) <- LETTERS[1:5]
barplot(Little.Data) # plots numeric data as bar heights

pie(Little.Data) # plots numeric data as pie slices     
dotchart(Little.Data) # plots numeric data as ordered dot plots

boxplot(n.species) # plots numeric data as box plot
hist(n.species) # plots numeric data as histogram
stripchart(Little.Data) # plots numeric data in a single strip chart
plot(density(n.species)) # plots kernel density of a numeric variable

# Bar Plot With Custom Error Bars
ecoregion.means <- by(n.species,ecoregion,mean)

barplot(ecoregion.means,names.arg=letters[1:5],
        ylim=c(0,100))
midpoints <- barplot(ecoregion.means,plot=FALSE)
ecoregion.sd <- by(n.species,ecoregion,sd)

arrows(midpoints,ecoregion.means,midpoints,
       ecoregion.means+ecoregion.sd,angle=90,
       length=0.1)

# For a double-headed arrow, adjust starting
# points and use code=3
arrows(midpoints,ecoregion.means-ecoregion.sd,midpoints,
       ecoregion.means+ecoregion.sd,angle=90,
       length=0.1,code=3)
points(midpoints,ecoregion.means,pch=19)

# plotting points with asymmetric
# confidence intervals
par(opar)

# using the quantile function
z <- rnorm(1000)
quantile(z,probs=0.95)
hist(z)
abline(v=quantile(z,probs=c(0.05,0.95)),lty="dashed",col="red")
abline(v=quantile(z,probs=c(0.025,0.975)),lty="dotted",col="blue")

# Calculate Confidence intervals with the by function
quantile(n.species,probs=0.025)
Con.low <- by(n.species,ecoregion,quantile,probs=0.025)
Con.high <- by(n.species,ecoregion,quantile,probs=0.975)

# set up a blank plot (show code first)
plot(1:5,1:5)
plot(1:5,1:5,xlim=c(0.5,5),ylim=c(0,100))
plot(1:5,1:5,xlim=c(0.5,5),ylim=c(0,100),type="n")

# fully blank plot
plot(1:5,1:5,xlim=c(0.5,5),ylim=c(0,100),type="n",
     axes= FALSE,ann=FALSE)

# add axes with labels
axis(1,at=seq(1:5),labels=letters[1:5])
axis(2)
mtext("Number of Species",side=2,line=2.5)
box(bty="L")
arrows(1:5,ecoregion.means,1:5,Con.low,angle=90,length=0.1)
arrows(1:5,ecoregion.means,1:5,Con.high,angle=90,length=0.1)
points(1:5,ecoregion.means,pch=23,cex=1.5,bg="gold")
abline(h=seq(0,100,by=20),col="gray",lty="dotted")

# add minor tick marks
# first find your location in the plot
points(1,0)
points(0,0)
points(0.5,0)
par("usr") # get limits

# try plotting a point points(0.32,10)
points(0.32,10)
par("xpd")
par(xpd=TRUE) # change clippig to figure region
points(0.32,10)
# first refresh plot
segments(rep(0.32,5),seq(10,90,length=5),rep(0,5),seq(10,90,length=5))

#Regression Line With Confidence, Prediction Intervals
##########################################
# fit the model

reg.model <- lm(mean.ann.temp~lat.centroid)

#################################################
# confidence and prediction intervals for original data

con.1 <- predict(reg.model,interval="confidence")
pred.1 <- predict(reg.model,interval="prediction")

####################################################
# confidence and prediction intervals for new x data
# (extrapolation and more finely spaced x)


nd <- seq(35,50,length=100)

con.2 <- predict(reg.model,interval="confidence",
                 newdata=data.frame(lat.centroid=nd))

pred.2 <- predict(reg.model,interval="prediction",
                  newdata=data.frame(lat.centroid=nd))

#####################################################
# plot results just for data interval

plot(lat.centroid,mean.ann.temp)
abline(reg.model)

matlines(Ant.Data$lat.centroid,con.1[,c("lwr","upr")],
         col="red",lty=1,type="l")

matlines(Ant.Data$lat.centroid,pred.1[,c("lwr","upr")],
         col="blue",lty=1,type="l")

##################################################
# plot results for extrapolated interval and smooth data
plot(lat.centroid,mean.ann.temp,xlim=c(30,50),ylim=c(-5,15))

abline(reg.model)

matlines(nd,con.2[,c("lwr","upr")],
         col="red",lty=1,type="l")

matlines(nd,pred.2[,c("lwr","upr")],
         col="blue",lty=1,type="l")

###########################################################
# plot the results as a confidence band using a polygon

plot(lat.centroid,mean.ann.temp,
     xlim=c(34,50),ylim=c(-5,25),type="n")

polygon(c(nd,rev(nd)),c(con.2[,2],rev(con.2[,3])),
        col="thistle",border=NA)

points(lat.centroid,mean.ann.temp)

abline(reg.model)

##########################################################
# plot the results as a prediction band using a polygon

plot(lat.centroid,mean.ann.temp,
     xlim=c(34,50),ylim=c(-5,25),type="n")

polygon(c(nd,rev(nd)),c(pred.2[,2],rev(pred.2[,3])),
        col="wheat",border=NA)

points(lat.centroid,mean.ann.temp)
abline(reg.model)

#########################################################
# Layout Function For Visualizing Plot Space
#############################################
# Creating a function for illustrating plot layouts
my.layout <- function (x=1) {
  for (i in 1:x) plot(runif(100),type="b",
                      col="gray",lwd=2,ann=FALSE,las=1)
  
  mtext("X axis label",side=1,font=2,line=3)
  mtext("Y axis label",side=2,font=2,line=3)
  mtext("Top Plot label",side=3,font=2,line=1)
  mtext("Side\nPlot\nLabel",side=4,font=2,line=1,las=1)
  mtext("BOTTOM OUTER MARGIN LABEL",side=1,font=2,line=1,cex=2,outer=TRUE)
  mtext("SIDE OUTER MARGIN LABEL",side=2,font=2,line=1,cex=2,outer=TRUE)
  mtext("TOP OUTER MARGIN LABEL",side=3,font=2,line=1,cex=2,outer=TRUE)
  mtext("SIDE\nOUTER\nMARGIN\nLABEL",side=4,font=2,line=1,cex=2,outer=TRUE,las=1)
  
  box(which="outer",col="red",lwd=4)
  box(which="inner",col="blue",lwd=4)
  box(which="figure",col="darkgreen",lwd=4)
  box(which="plot",col="goldenrod",lwd=4)
  
  par(opar)
}
############################################
# Check out appearance with default settings

my.layout(1)

##########################################
# Adjusting Margins of a Single Figure with mar (= lines of text)

par("mar")

par(mar=c(5,5,4,4))
my.layout(1)

##########################################
# Adding outer plot margins with oma (= lines of text)

par("oma")

par(oma=c(3,3,3,8))
my.layout(1)

##########################################

# Creating a square plot with pty (default = "m")

par("pty")
par(pty="s")

my.layout(1)

########################################
# Using mfrow for multi-panel plots

par("mfrow")
par(mfrow=c(3,2))
my.layout(6)

# Add in your outer margins & square plot regions

par("oma")
par(oma=c(6,6,6,6))
par(pty="s")
par(mar=c(2,2,2,2))
par(mfrow=c(3,4))
my.layout(12)

###############################################
# Gaining more control with the layout function

layout(matrix(1:6,nrow=3,byrow=TRUE))
layout.show(6)
my.layout(6)

# Matrix elements give the order of filling
layout(matrix(c(1,2,3,4,6,5),nrow=3,byrow=FALSE))
layout.show(6)
my.layout(6)

###########################################
# as before, outer margins can be added

layout(matrix(1:6,nrow=3,byrow=TRUE))
layout.show(6)
par("oma")
par(oma=c(4,4,4,4))
layout.show(6)
my.layout(6)

##################################################
# use "respect" option to square up the entire figure region

layout(matrix(1:6,nrow=3,byrow=TRUE),respect=TRUE)
layout.show(6)

par(oma=c(4,4,4,4))
layout.show(6)
my.layout(6)

###################################################
# allows for more compact figures; use with pty="s"

layout(matrix(1:12,nrow=3,byrow=TRUE),respect=TRUE)
layout.show(12)

par(oma=c(4,4,4,4))
par(mar=c(2,2,2,2))
par(pty="s")

layout.show(12)
my.layout(12)

###################################################
# alter the widths and/or heights of figures

layout(matrix(1:6,nrow=3,byrow=TRUE),widths=c(2,1))
layout.show(6)
my.layout(6)

layout(matrix(1:6,nrow=3,byrow=TRUE),widths=c(2,1),
       heights=c(1,2,1))
layout.show(6)
my.layout(6)

###################################################
# use "0" matrix entries for no plot
# use multiple matrix entries for expanded plot regions

layout(matrix(c(1,1,1,2,0,3),nrow=2,byrow=TRUE))
layout.show(3)
my.layout(6)

###################################################
# use all of this to combine graphic elements

# set up plotting regions

par(opar)
layout(matrix(c(2,0,1,3),nrow=2,byrow=TRUE),
       heights=c(1,8),widths=c(8,1))
layout.show(3)
########################################################
# create some skewed data and sort it
x <- sort(rgamma(100,shape=2,scale=1))
y <- sort(rgamma(100,shape=2,scale=1),decreasing=TRUE)

########################################################
# generate the basic scatterplot
par(mar=c(4,5,0,0))
plot(x,y,ann=FALSE,cex=2,pch=21,bg="cornflowerblue")

par(mar=c(0,5,0,0))
#par(bty="n")
#par(xaxt="n")


boxplot(x,names=FALSE,horizontal=TRUE,col="cornflowerblue")
par(mar=c(4,0,0,0))

#par(yaxt="n")
boxplot(y,names=FALSE, horizontal=FALSE,col="cornflowerblue")
par(opar)
Asymmetric Confidence Intervals
ecoregion.means <- by(n.species,ecoregion,mean)

# using the quantile function
z <- rnorm(1000)
quantile(z,probs=0.95)
hist(z)
abline(v=quantile(z,probs=c(0.05,0.95)),lty="dashed",col="red")
abline(v=quantile(z,probs=c(0.025,0.975)),lty="dotted",col="blue")

# Calculate Confidence intervals with the by function
quantile(n.species,probs=0.025)
Con.low <- by(n.species,ecoregion,quantile,probs=0.025)
Con.high <- by(n.species,ecoregion,quantile,probs=0.975)

# set up a blank plot (show code first)
plot(1:5,1:5)
plot(1:5,1:5,xlim=c(0.5,5),ylim=c(0,100))
plot(1:5,1:5,xlim=c(0.5,5),ylim=c(0,100),type="n")

# fully blank plot
plot(1:5,1:5,xlim=c(0.5,5),ylim=c(0,100),type="n",
     ,axes= FALSE,ann=FALSE)

# add axes with labels
axis(1,at=seq(1:5),labels=letters[1:5])
axis(2)
mtext("Number of Species",side=2,line=2.5)
box(bty="L")


arrows(1:5,ecoregion.means,1:5,Con.low,angle=90,length=0.1)
arrows(1:5,ecoregion.means,1:5,Con.high,angle=90,length=0.1)
points(1:5,ecoregion.means,pch=23,cex=1.5,bg="gold")
abline(h=seq(0,100,by=20),col="gray",lty="dotted")

# add minor tick marks
# first find your location in the plot
points(1,0)
points(0,0)
points(0.5,0)
par("usr") # get limits

# try plotting a point points(0.32,10)
points(0.32,10)
par("xpd")
par(xpd=TRUE) # change clippig to figure region
points(0.32,10)
# first refresh plot
segments(rep(0.32,5),seq(10,90,length=5),rep(0.28,5),seq(10,90,length=5))
par(opar)
Polygon Confidence Interval
par(mar=c(5,6,4,2)+0.1)
par(pty="s")

# create data
x <- 1:100
Exp <- 50 + x*0.1
Con.High <- Exp + 5 + rnorm(100)
Con.Low <- Exp - 5 + rnorm(100)
One.Run <- Exp + rnorm(100,0,2)

# create plot
plot(Exp~x,type="l",
     xlab= "Time Step",
     ylab="Populatioh Size (N)",
     lty="dashed",
     ylim=range(One.Run,Exp,Con.High,Con.Low),
     cex.lab=1.5,las=1,cex.axis=1.5)

# add polygon and overplot the lines
polygon(c(x,rev(x)),c(Con.Low,rev(Con.High)),col="thistle",border=NA)
lines(x,Exp,lty="solid",col="purple",lwd=1.5)
lines(x,One.Run)
par(opar)
Color
######################################################################
par(opar)
# names and units for colors
colors()
colors()[10]
col2rgb("red")
z <- "#DD059E"
pie(1,col=z)

######################################################################
# plot with colors as groups
plot(mean.ann.temp,n.species,col=as.integer(as.factor(ecoregion)))

#examine default palette
palette()

my.palette <- c("black","brown","orange","chocolate","coral")
palette(my.palette)
palette()

plot(mean.ann.temp,n.species,col=as.integer(as.factor(ecoregion)),main="custom colors")
palette("default")

######################################################################
# add a vector of colors to an existing data frame
Ant.Data$custom.colors <- NA


# new colors (could be numbers)
mycolors <- c("green","yellow","purple","blue","grey")
table(ecoregion)

as.integer(as.factor(ecoregion))

Ant.Data$custom.colors <- 
  mycolors[as.integer(as.factor(Ant.Data$ecoregion))]

#--------------------------------------------
# alternate method using match function
# make the match and store in Ant.Data$mycolors
# old names, sorted alphabetically (or not)
# tmpold <- sort(unique(Ant.Data$ecoregion)) 

# Ant.Data$mycolors <- as.character(
#                        mycolor[match(Ant.Data$ecoregion,tmpold)])
#---------------------------------------------
Ant.Data$custom.colors

plot(mean.ann.temp,n.species,col=Ant.Data$custom.colors,
     main="using custom color vector")

#######################################################################
# using the cut function to create categories for colors

x <- rnorm(1000)

table(ecoregion)

table(cut(x,breaks=4))
table(cut(x,breaks=c(-3,0,1,2,3)))
table(cut(x,breaks=quantile(x,c(0,0.25,0.5,0.75,1.0))))
table(cut(x,breaks=quantile(x,c(0,0.25,0.5,0.75,1.0)),
          include.lowest=TRUE))
table(cut(x,breaks=quantile(x,c(0,0.25,0.5,0.75,1.0)),
          include.lowest=TRUE,labels=FALSE))

# cut the temperature variable

Temperature.Colors <- c("yellow","orange",
                        "red","chocolate")
temp <- 
  cut(mean.ann.temp,breaks=quantile(mean.ann.temp,
                                    c(0,0.25,0.5,0.75,1.0)), include.lowest=TRUE,
      labels=FALSE)



Ant.Data$T.colors <- Temperature.Colors[temp]

plot(lat.centroid,mean.ann.temp,pch=24,
     bg=Ant.Data$T.colors,cex=2)

###############################################
# adjusting colors for transparency
# first, with no adjustment
x1 <- rnorm(100,0,1)
x2 <- rnorm(100,2,1)

hist(x1,xlim=range(c(x1,x2)),ylim=c(0,35),
     col="red",breaks=seq(-4,6,by=0.5))
par(new="TRUE")

hist(x2,xlim=range(c(x1,x2)), ylim=c(0,35),
     axes=FALSE,ann=FALSE,
     col="blue",breaks=seq(-4,6,by=0.5))
par(opar)

# now adjust the blue to 50% transparency
my.blue <- adjustcolor("blue",alpha.f=0.5)

hist(x1,xlim=range(c(x1,x2)),ylim=c(0,35),
     col="red",breaks=seq(-4,6,by=0.5))

par(new="TRUE")

hist(x2,xlim=range(c(x1,x2)), ylim=c(0,35),
     axes=FALSE,ann=FALSE,col=my.blue,
     breaks=seq(-4,6,by=0.5)) # my.blue not in quotes!

par(opar)
###########################################
# visualizing colors from default color sets

n <- 3
my.greys <- gray.colors(n,0,1)
pie(rep(1,n),labels=my.greys,col=my.greys)

my.rainbow <- rainbow(n)
pie(rep(1,n),labels=my.rainbow,col=my.rainbow)

############################################
# build your own function

Color.Pie <- function(z="black"){
  pie(rep(1,length(z)),col=z)
}
###########################################
Color.Pie
Color.Pie()
x <- rainbow(10)
Color.Pie(x)
x <- rainbow(3)
barplot(c(3,4,1),col=x)

palette(rainbow(5))
palette()
palette("default")

# use start and stop to control range in rainbow
# defaults are 0 to 1
x <- rainbow(10,start=0.2,end=0.7)

# use s and v for saturation and value in rainbow
# default is 1
x <- rainbow(10,s=0.5)
x <- rainbow(10,v=0.8)
Color.Pie(x)
# specify alpha value for transparency
# default is 1 (= opaque)
x <- rainbow(10,alpha=0.5)

# other built in palettes only can specify alpha
x <- heat.colors(10)
x <- terrain.colors(10)
x <- topo.colors(10)
x <- cm.colors(10)


Color.Pie(x)

# special calls for grays

x <- gray.colors(10) # default grays
x <- gray.colors(10,0,1) # from white through black
xs <- x[c(2,9,4)] # take a re-ordered subset

Color.Pie(xs)
############################################################
# Using the ColorBrewer library and associated palettes

library(RColorBrewer)
display.brewer.all(type="all")

x <- brewer.pal(6,"Reds") # gradients
x <- brewer.pal(10,"Spectral") #divergent
x <- brewer.pal(8,"Dark2") # contrasting

Color.Pie(x)
############################################################
# This routine creates a custom palette to interpolate
# across any 2 (or more) named colors!
# bias is a positive number; high bias gives more weight to end color
# try bias = 1 for a reasonable balance among all 3
# space = rgb or Lab; the latter gives more even hues, but it is subtle
# interpolate = linear or spline; spline looks a little better


Custom.Palette <- colorRampPalette(colors=c("red","blue"), 
                                   bias=1, space="rgb", interpolate="spline")
x <- Custom.Palette(10)
Color.Pie(x)
par(opar)
Legends
######################################################################
# plot with colors as groups
par(opar)
plot(mean.ann.temp,n.species,col=as.integer(as.factor(ecoregion)))
legend("topleft", inset=0.01, title="ecoregion",
       c("Acadian Plains","GL Lowlands"),
       pch=1,col=palette()[c(1,2)])

# plot with symbols as groups
par(xpd=NA) # suppress clipping
par(fig=c(0,1,0,0.75)) # move figure down in plot space

plot(mean.ann.temp,n.species,pch=as.integer(as.factor(ecoregion)))
legend(3,160, title="ecoregion",
       c("Acadian Plains","GL Lowlands",
         "NE Coastal", "NE Highlands", "Pine Barrens"),
       pch=1:5)
par(opar)
########################################################################
Inset Figures
par(opar)
set.seed(102)

####################################################
# create a stochastic increasing time series

x <- 1:1000
y <- rgamma(1000,shape=2,scale=1) + 0.01*x

###################################################
# select a time slice for plotting
slice <- 300:450

# create the main graph

par(mar=c(5,6,1,1))
plot(x[slice],y[slice],xlim=range(slice),col="gray",type="l",
     xlab="Time",ylab="Temperature",
     font.lab=2,cex.lab=1.5,las=1,ylim=range(y[slice]))

##################################################################
#add par commands to strip margins, overplot, and place the inset

par(new=TRUE) # overlay existing plot
par(mar=c(0,0,0,0)) # strip out the margins for the inset plot
par(fig=c(0.4,0.7,0.80,0.94)) # fig shrinks and places relative to figure region

#################################################################
# separately create the inset graph

plot(x,y,type="l",ann=FALSE)
rect(slice[1],-1,slice[length(slice)],1000,col="gray",border=NA)
box()
lines(x,y)

#########################################
par(opar)
Miscellaneous Functions
par(opar)
##############################################################
# Add formatted text to a plot
library(gplots)
par(mfrow=c(1,2))
plot(lat.centroid,n.species)
reg.model <- lm(n.species~lat.centroid)
abline(reg.model)

textplot(capture.output(summary(reg.model)))
par(opar)
##############################################################
# Add a boxed label to a plot
library(plotrix)
plot(lat.centroid,n.species)

# give x, y positions
boxed.labels(45.5,75,"boxed.labels",bg="gray90",cex=2)
###############################################################
# Add a text box to a plot
library(plotrix)


#give c(xmin,xmax), y top; # lines determined by amount of text
textbox(c(45.5,46.0),60,"this is a text box on several lines")
###############################################################
# stack the labels if they are too crowded
library(plotrix)
par(mar=c(8,4,4,2))
plot(lat.centroid,n.species,axes=FALSE)
axis(1,labels=FALSE)
axis(2)
box()
my.labs <-round(seq(41,47,by=0.25),3)
staxlab(1,at=my.labs) #add srt=45 to rotate
################################################################
# add an axis break
library(plotrix)
plot(lat.centroid,n.species)
axis.break(1)
par(opar)
Graphics For Proteomics & Big Data
################################################
# Figure 1. standard pie chart
# data from Petricka et al. 2012 Fig 1D

Arab.labels <- c("Root Hairs", "Epidermis","Cortex",
                 "Endodermis","Vasculature", "Columella")
Protein.per <- c(34,8,9,8,29,12)
pie(Protein.per, labels=Arab.labels,main="Pie Chart",
    sub="Figure 1. A typical pie chart, which makes it hard to estimate proportions
    from the angles and does not preserve the original form of the data.
    Proportion data are taken from Petricka et al. (2012) Figure 1D.")

###############################################
# Figure 2. replotted as a bar chart
library(RColorBrewer)
Brew.cols <- brewer.pal(6,"Pastel1")
par(fig=c(0,1,0.3,1))
barplot(Protein.per,names.arg=Arab.labels,ylim=c(0,40),col=Brew.cols,
        ylab="% of Proteins",xlab="Cell Types", main = "Bar Plot")
mtext("Figure 2. A standard bar plot makes it easier to estimate the proportions, 
      but is not practical for a large number of categories.", side= 1,line=10)
grid(nx=0,ny=8,col="gray")
par(opar)
##################################################################
# Figure 3. improved with a fan chart with RColorBrewer palette
library(plotrix)
library(RColorBrewer)
Brew.cols <- brewer.pal(6,"Pastel1")
par(fig=c(0,1,0.3,1))
fan.plot(Protein.per, labels = Arab.labels, col=Brew.cols, main="Fan Plot")
par(new=TRUE)
par(fig=c(0,1,0.3,1))
plot(Protein.per,type="n",font.sub=1,axes=FALSE, ann=FALSE)
mtext("Figure 3. A fan plot is an improvement over a pie chart because proportions 
      can be estimated more accurately from the length of the arcs.", side= 1,line=6)
par(opar)
########################################################
#Figure 4. dotchart for long lists of elements
par(mar=c(9,4,4,2))
Protein.list = paste("Protein",1:50,"     ")
Express1 <- sort(runif(20,1,6))
Express2 <- sort(runif(20,3,12))
Express3 <- sort(runif(10,9,12))
Proteins <- c(Express1,Express2,Express3)
Grps <- factor(c(rep("Metabolic",20),rep("Chaperone",20),rep("Heat Shock",10)))
dotchart(Proteins,labels=Protein.list,,groups=Grps,xlab="Fold Induction",
         gcolor="red",pch=21,bg="gold",lcol="blue",cex=0.6, main="Dot Chart")
mtext("Figure 4. A dotchart efficiently displays 
      quantitative values with labels and sorted groups",side=1,line=7)
par(opar)
##################################################
# Figure 5. plot showing polar coordinates
library(plotrix)
par(fig=c(0,1,0.2,1))
polar.plot(lengths=0,polar.pos=seq(135,240,length=6),
           main="Polar Plot",lwd=10,line.col=NA,
           radial.lim=c(0,40),start=0,rp.type="r",
           labels="",
           show.grid.labels=3,mar=c(2,4,7,2))

mtext("Figure 5. In a polar plot, each point is located within a circle.
      The first coordinate is the angle (0-360), and the second coordinate
      is the continuous variable (in this case, a scale from 0-40 units).", side= 1,line=6)
par(opar)
########################################
# Figure 6. Simple plot of protein numbers
library(plotrix)
par(fig=c(0,1,0.2,1))
polar.plot(lengths=Protein.per,polar.pos=seq(135,240,length=6),
           main="Polar Plot of Vectors",lwd=10,line.col=NA,
           radial.lim=c(0,40),start=0,rp.type="r",
           labels=Arab.labels,label.pos=seq(135,240,length=6),
           show.grid.labels=3,mar=c(2,4,7,2))
polar.plot(lengths=Protein.per,polar.pos=seq(135,240,length=6),
           add=TRUE, main="",lwd=10,line.col="seagreen",
           radial.lim=c(0,40),start=0,rp.type="r",
           labels=Arab.labels,label.pos=seq(135,240,length=6),
           show.grid.labels=3,mar=c(2,4,7,2),show.grid=FALSE,
           show.radial.grid=FALSE)
mtext("Figure 6. Protein numbers illustrated in a polar plot.
      The relative proportions can be easily compared,
      but the original units (numbers of proteins) are preserved.", side= 1,line=6)
par(opar)
#############################################################
# Figure 7. Now add a second set and color code for a new treatment
par(fig=c(0,1,0.2,1))
Protein2.per <- c(9,20,30,21,11,9)

polar.plot(lengths=c(Protein.per,Protein2.per),
           polar.pos=rep(seq(140,220,length=6),2)+rep(c(0,180),each=6),
           lwd=10,line.col=rep(c("seagreen","goldenrod"),each=6),
           radial.lim=c(0,40),start=0,rp.type="r",
           labels=Arab.labels,
           label.pos=rep(seq(140,220,length=6),2)+rep(c(0,180),each=6),
           show.grid.labels=3,mar=c(2,4,7,4),cex=2)

mtext("Control",side=2,font=2,las=1,cex=1.5,line=3,at=30)
mtext("Ectopic",side=4,font=2,las=1,cex=1.5,line=3,at=30)
mtext("Polar Plot\nWith Two Groups",side=3,font=2,las=1,cex=1.75,line=1,
      at=0)
mtext("Figure 7. Comparison of two groups in a polar plot.
      With exactly 2 groups, the vectors can be extended and color coded
      to illustrate comparisons within and between groups.", side= 1,line=6)
par(opar)
#####################################################
# Figure 8. Create a graph for 100 proteins, with 4 proteins coded
par(fig=c(0,1,0.2,1))
Protein.col <- rep("black",100)
Protein.col[c(60, 70, 93,95)] <- "red"  
Protein.express <- sort(rgamma(100,shape=1,scale=3))
polar.plot(lengths=Protein.express, 
           polar.pos=seq(10,350,length=100),
           lwd=2,line.col=Protein.col,
           radial.lim=c(0,max(Protein.express)),start=0,rp.type="r",
           show.grid.labels=4,mar=c(2,4,7,4),cex=2)
mtext("Polar Plot\nOf 100 ER Proteins",side=3,font=2,las=1,cex=1.75,line=2,
      at=0)
par(opar)
mtext("Figure 8. Peptide composition of individual proteins.
      Each line represents the expression of an individual protein. 
      The proteins are ordered by expression intensity,
      with 4 particular proteins (#60,70,93,95) highlighted.", side= 1,line=2)
par(opar)
#############################################################
# Figure 9. Create a graph for 100 proteins, with special coding for peptide number
par(fig=c(0,1,0.2,1))

library(RColorBrewer)
my.reds <- brewer.pal(6,"Reds")
red6 <- sample(my.reds,100,replace=TRUE,prob=6:1)
Protein.express <- sort(rgamma(100,shape=1,scale=3))
Protein.express <- runif(100,0,12)
polar.plot(lengths=Protein.express,
           polar.pos=seq(10,350,length=100),
           lwd=3,line.col=red6,
           radial.lim=c(0,max(Protein.express)),start=0,rp.type="r",
           labels="",
           show.grid.labels=4,mar=c(2,4,7,4),cex=2)
mtext("Normalized Fold Induction\nOf 100 ER Proteins",side=3,font=2,las=1,cex=1.75,line=1,
      at=0)
legend(-35,15,pt.cex=1.2,legend=c("1 peptide","2 peptides","3 peptides",
                                  "4 peptides", "5-10 peptides","> 10 peptides"),
       fill=my.reds)
mtext("Figure 9. Peptide composition of individual proteins.
      Each line represents the expression of an individual protein. 
      The ordering is arbitrary, but colors show number of peptides
      used in the protein identification.", side= 1,line=4)
par(opar)

####################################################
# Figure 10. mosaic plot for two categorical variables
library(RColorBrewer)
my.blues <- brewer.pal(4,"Blues")
Protein.counts <- matrix(c(100,25,300,40,60,4,200,22,48,20,99,777),nrow=3,
                         dimnames=list(c("Control","Enriched","Disturbed"),c("1 peptide","2 peptides",
                                                                             "3 peptides", "> 3 peptides")))
mosaicplot(t(Protein.counts),col=my.blues,main="Mosaic Plot Of Protein Counts")
mtext("Figure 10. Protein composition as a function of 
      experimental treatment. Heights are proportional to protein numbers in each treatment,
      and widths are proportional to the number of peptides in each protein. Tile areas
      are proportional to the number of proteins in each grouping.", side= 1,line=4)
par(opar)