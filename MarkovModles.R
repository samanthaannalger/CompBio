# Demonstration of Markov Models and popbio library
# 2017 03 13
# SAA

setwd("~/CompBio")

library(popbio)
stages <- c("Disturbed", "Grassland", "Forest")
A <- matrix(c(0.3, 0.4, 0.3,
              0.0, 0.1, 0.2,
              0.7, 0.5, 0.1),
            nrow=3,
            byrow=TRUE, dimnames=list(stages,stages))
n <- c(100,0,0)
timesteps=10
print(A)

MarkovOut <- pop.projection(A=A,n=n,iterations=timesteps)
stage.vector.plot(MarkovOut$stage.vectors,col=2:4)

print(MarkovOut)

##################################################
# function: plotCounts
# plot raw counts of states at each time step
# input: matrix (rows=stages, cols=times)
# output: plot
#------------------------------------------------- 
plotCounts <- function(m=matrix) {
  par(mfrow=c(1,2))
  
  plot(x=1:ncol(m),
       y=m[1,],
       type="o",
       ylab="Frequency",
       xlab="Time",
       ylim=c(0,max(m)),
       col="red",
       lwd=2)
  for (i in 2:nrow(m)){
    lines(x=1:ncol(m),
          y=m[i,],
          type="o",
          col=i+1,
          lty=i,
          lwd=2)
  }
  stage.vector.plot(MarkovOut$stage.vectors,col=2:(nrow(m)+1))
  par(mfrow=c(1,1))
}
plotCounts(MarkovOut$stage.vectors)

# data from Gotelli N.J. and A.M. Ellison. 2002. Nitrogen deposition and extinction risk in the northern pitcher plant, Sarracenia purpurea. Ecology 83: 2758-2765.
stages <- c("Recruit","Juvenile","NFAdult","FAdult")
timesteps=100
n=c(50,50,50,50)
A <- matrix(c(0,0,0,4,
              0.1, 0.854, 0.177, 0,
              0, 0.131, 0.708, 0.660,
              0,0,0.1,0.307),nrow=4,byrow=TRUE,dimnames=list(stages,stages))
MarkovOut <- pop.projection(A=A,n=n,iterations=timesteps)
plotCounts(MarkovOut$stage.vectors)

print(MarkovOut$lambda) 
print(MarkovOut$stable.stage)  
print(head(MarkovOut$pop.sizes))
print(tail(MarkovOut$pop.sizes))
eigen.analysis(A)


# data simplified from Slade N.A. and D.F. Balph. 1974. Population ecology of Uinta ground squirrels. Ecology 55: 989-1003
stages <- as.character(0:8)
timesteps=150
n= rep(20,9)
A <- matrix(c(0,0,0.646,3,2.17,0,1.054,0,2.214,
              0.662,0,0,0,0,0,0,0,0,
              0,0.501,0,0,0,0,0,0,0,
              0,0,0.756,0,0,0,0,0,0,
              0,0,0,0.142,0,0,0,0,0,
              0,0,0,0,0.566,0,0,0,0,
              0,0,0,0,0,0.026,0,0,0,
              0,0,0,0,0,0,0.103,0,0,
              0,0,0,0,0,0,0,0,0.000),nrow=9,byrow=TRUE,dimnames=list(stages,stages))
print(A)

MarkovOut <- pop.projection(A=A,n=n,iterations=timesteps)
plotCounts(MarkovOut$stage.vectors)
print(MarkovOut$lambda)  
print(MarkovOut$stable.stage)      
print(head(MarkovOut$pop.sizes))
print(tail(MarkovOut$pop.sizes))
eigen.analysis(A)

# Data from Diamond, S. E., L. M. Nichols, S. L. Pelini, C. A. Penick, G. W. Barber, S. H. Cahan, R. R. Dunn, A. M. Ellison, N. J. Sanders, and N. J. Gotelli. 2016. Climatic warming destabilizes forest ant communities. Science Advances 2.

# transition matrix from control 5C heated chamber
stages <- c("Empty",paste("Species",LETTERS[1:3]))
timesteps=70
n= rep(20,4)
A <- matrix(c(245,14,8,0,
              18,17,0,2,
              8,1,0,5,
              1,0,0,1) ,nrow=length(stages),byrow=TRUE,dimnames=list(stages,stages)) 
print(A)

A <- apply(A,2, function(x) x/sum(x)) # convert raw counts to column proportions
print(A)

MarkovOut <- pop.projection(A=A,n=n,iterations=timesteps)
plotCounts(MarkovOut$stage.vectors)

print(MarkovOut$stable.stage)              
eigen.analysis(A)

# transition matrix from control (=unheated) chamber
stages <- c("Empty",paste("Species",LETTERS[1:3]))
timesteps=70
n= rep(20,4)
A <- matrix(c(202,14,13,0,
              18,9,2,0,
              13,1,35,1,
              1,0,0,11) ,nrow=length(stages),byrow=TRUE,dimnames=list(stages,stages)) 
print(A)
