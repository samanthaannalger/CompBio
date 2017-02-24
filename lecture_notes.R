## ------------------------------------------------------------------------
#Use comments profusely in your code!

Time <- seq(1,10) #seq makes integer sequence
print(Time)       #show contents
Resp <- runif(10) #random uniform- create 10 random numbers froma uniform distribution
print(Resp)
plot(x=Time, y=Resp, type="b")

## ------------------------------------------------------------------------
            #```{r, echo=FALSE} (removes the R code)
            #eval=FALSE (keeps record of code it  will print, but will not run inside that chunk)
plot(runif(20))
print(seq(1,5))


