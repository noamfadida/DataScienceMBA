### Homework 1 - Data Science, MBA

# Set working directory
setwd('C:/projects/MBA/Summer22/DataScienceMBA/HW1/')

# Set global options
options("scipen"=10, "digits"=7)

# Load csv. file
HousePrices.df <- read.csv(file = "HousePricesHW1.csv")

# Part B: Visualization

# Section 1
# Histogram for Price variable
hist(HousePrices.df$Price, main = "Histogram for Price Variable", 
     xlab = "Price", br = 150, xlim = c(0, 3000000), col = 'red')
summary(HousePrices.df$Price)

# Section 2
# BoxPlot NumStores vs. DogParkInd
boxplot(HousePrices.df$NumStores ~ HousePrices.df$DogParkInd, data = HousePrices.df, 
     main = "Plot NumStores vs. DogParkInd", xlab = "DogParkInd", ylab = "NumStores")


# Part C: Models Estimation

# Section 1 - Model M1
# Regression model between Price and the explanatory 
# variables: MtrsToBeach,SqMtrs,Age,NumStores,DogParkInd,SchoolScores.
reg.m1 <- lm(Price ~ ., data = HousePrices.df)
summary(reg.m1)

# Section 2 - Model M2
# Regression model between Price and the explanatory 
# variables: MtrsToBeach,SqMtrs,Age.
reg.m2 <- lm(Price ~ MtrsToBeach + SqMtrs + Age, data = HousePrices.df)
summary(reg.m2)

# Section 3 - Model M1'
# Regression model as Section 1 but without NumStores variable.
reg.m1tag <- lm(Price ~ .-NumStores, data = HousePrices.df)
summary(reg.m1tag)

# Print coeff for DogParkInd
coef(reg.m1)["DogParkInd"]
coef(reg.m1tag)["DogParkInd"]
# ==> DogParkInd increases it's value.


# Part D: Report
# Extract relevant coefficients that differentiate between the lot A and lot B.
coeff.MtrsToBeach <- reg.m1$coefficients["MtrsToBeach"]
coeff.NumStores <- reg.m1$coefficients["NumStores"]
coeff.DogParkInd <- reg.m1$coefficients["DogParkInd"]

# Let's assume that the investor will not be building new stores
# Also, we know that there aren't dog parks and stores in lot A, so we can 
# build a tradeoff equation as follows:
# * DeltaMtrToBeach = MtrToBeach_B - MtrToBeach_A, when:
# ** MtrToBeach_X is the average distance from an apartment in lot X to the sea.
NumStoresB.eq <- function(DeltaMtrsToBeach){(-coeff.MtrsToBeach*DeltaMtrsToBeach - coeff.DogParkInd)/coeff.NumStores}
curve(NumStoresB.eq, from=0, to=5000, xlab="Delta Distance From Beach (B-A)", ylab="Number Of Stores In Lot B")

# * Let's plot square meters versus resulting price
plot(Price ~ SqMtrs, data = HousePrices.df, xlab="Square Meters")
