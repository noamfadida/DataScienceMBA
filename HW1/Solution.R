
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

# Print coef for DogParkInd
coef(reg.m1)["DogParkInd"]
coef(reg.m1tag)["DogParkInd"]
# ==> DogParkInd increase its value.


