# Samantha Alger
# CompBio, Brandon's lecture
# 2017-03-21


# install the package
install.packages("EpiModel", dependencies = TRUE)

library(EpiModel)

#setting the parameters
# inf.prob= transmission probability per act
# act.rate= acts per person per unit time
# init.dcm = initial conditions for the model
# control.dcm = structural model controls- model type/number of time steps for simulation
param <- param.dcm(inf.prob = 0.2, act.rate = 0.25)
init <- init.dcm(s.num = 500, i.num = 1)
control <- control.dcm(type = "SI", nsteps = 500)

# save as mod
mod <- dcm(param, init, control)

#check out model
mod
#plot model
plot(mod)

# check summary at time point 150
summary(mod, at = 150)

# Simulation
param <- param.dcm(inf.prob = 0.2, act.rate = 1, rec.rate = 1/20,
                   b.rate = 1/95, ds.rate = 1/100, di.rate = 1/80, dr.rate = 1/100)
init <- init.dcm(s.num = 1000, i.num = 1, r.num = 0)
control <- control.dcm(type = "SIR", nsteps = 500, dt = 0.5)
mod <- dcm(param, init, control)

#Plotting
par(mar = c(3.2, 3, 2, 1), mgp = c(2, 1, 0), mfrow = c(1, 2))
plot(mod, popfrac = FALSE, alpha = 0.5,
     lwd = 4, main = "Compartment Sizes")
plot(mod, y = "si.flow", lwd = 4, col = "firebrick",
     main = "Disease Incidence", leg = "n")

#summaries
par(mfrow = c(1, 1))
comp_plot(mod, at = 50, digits = 1)
