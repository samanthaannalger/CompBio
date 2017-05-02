# EcoSimR
# Morgan's talk

# Create presence-absence matrix from species list data----

# read in associated species data 
sppDat <- read.table("AssociatedSppData_Serp.csv",header=TRUE,sep=",",stringsAsFactors = FALSE)
head(sppDat)

# reshape data using dcast function in reshape2 package
library(reshape2)
PA <- dcast(sppDat,formula=SpeciesName~SitePatch)
head(PA)

# conduct species co-occurence analysis using EcoSimR------

library(EcoSimR)
library(MASS)
# Run null model with SIM9 algorithm & CHECKER index
adMod1 <- cooc_null_model(PA,algo= "sim9",metric="checker",nReps=1000,suppressProg=T)

# Summary and plots
summary(adMod1)

mean(adMod1$Sim)

plot(adMod1,type="hist")

plot(adMod1,type="cooc")

plot(adMod1,type="burn_in")

# C score index-------------------------------
## Run null model with SIM9 algorithm and C score index
adMod2 <- cooc_null_model(PA,algo= "sim9",metric="c_score",nReps=1000)

# Summary and plots
summary(adMod2)
plot(adMod2,type="hist")
plot(adMod2,type="cooc")
plot(adMod2,type="burn_in")

# COMBO index-------------------------------------
# Run null model with SIM9 algorithm and COMBO index
adMod3 <- cooc_null_model(PA,algo= "sim9",metric="species_combo",nReps=1000)

# Summary and plots
summary(adMod3)
plot(adMod3,type="hist")
plot(adMod3,type="cooc")