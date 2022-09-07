################################################################################
################# Setting WD and seed- do not modify this part! ################
################################################################################

# We will define the Working directory for you to the folder in which the script is located
# Therefore, don't define it manually using set.wd()

#(We check whether a package we want is installed, if it isn't we install it for you)
if(!"rstudioapi" %in% installed.packages()) { 
    install.packages("rstudioapi")}

# Getting the path of your current open file
current_path = rstudioapi::getActiveDocumentContext()$path 
setwd(dirname(current_path ))
print( getwd() ) # You can make sure that the WD is correct. If it is not - send Or an E-mail

set.seed(123) ###  We set the seed to 123, do not change it.
rm(current_path)

################################################################################
#################################### Intro #####################################
################################################################################

# Hi! We want to get to know you better!
# please assign your name/id to these variables:
name1<- "Shavit Borisov"
ID1<-   "318740354"
name2<- "Noam Fadida"
ID2<-   "208872598"
name3<- "Yaron Shinkar"
ID3<-   "207384520"

# If you use any package that was not used in the course materials
# Please add its name to the vector in row 36
# otherwise you can ignore the next line
my.packages<-c("ggplot2","data.table") 

################################################################################
######################### The actual work starts here: ######################### 
################################################################################
library(caret)


#### Read files  ####
df<-read.csv("cross_2022c.csv")            #"Please read cross_2022C.csv file and store it as df"
holdout<-read.csv("holdout_2022c.csv")       #"Please read holdout_2022C.csv file and store it as holdout"

#### Pre-processing  ####
# remove unnecessary features as month, zipCode
filtered_df <- subset(df, select=-c(month, zipCode))

# creating the train data set
partition <- createDataPartition(df[['donation']], p = 0.8, list=FALSE ) # returns the indexes of the train data set.    

training <- filtered_df[partition,]
validation <- filtered_df[-partition,]

###############
# Training KNN 
##############

# K-Cross-Validation for our training
ctrl <- trainControl(
  method = "cv",
  number = 10,
)

knnFit <- train(donation ~ age + income + pastDonations + numberOfKids + married, 
                data = training, 
                method="knn", preProcess=c("scale","center"),
                tuneGrid   = expand.grid(k = c(3:7)),
                trControl = ctrl) 

knnFit

# Predict KNN


# Run on validation set
test.features = subset(validation, select=-c(donorId, donation))
test.target = subset(validation, select=donation)[,1]
predictions = predict(knnFit, newdata = test.features)

# Extract best samples
predictions_with_ID = data.frame(subset(validation, select=donorId), predictions)
predictions_with_ID_Sorted = predictions_with_ID[order(predictions_with_ID$predictions, decreasing = TRUE),]

actual_with_ID = data.frame(subset(validation, select=donorId), test.target)
actual_with_ID_Sorted = actual_with_ID[order(actual_with_ID$test.target, decreasing = TRUE),]

predict_best_90_IDs = subset(head(predictions_with_ID_Sorted, n=90), select=donorId)
actual_best_90_IDs = subset(head(actual_with_ID_Sorted, n=90), select=donorId)
intersection <- intersect(actual_best_90_IDs$donorId, predict_best_90_IDs$donorId)
#print(length(intersection))

# RMSE
sqrt(mean((test.target - predictions)^2))

# R2
cor(test.target, predictions) ^ 2

x = 1:(length(test.target)/10)

plot(x, test.target[x], col = "red", type = "l", lwd=2,
     main = "Donors test data prediction")
lines(x, predictions[x], col = "blue", lwd=2)
legend("topright",  legend = c("original-medv", "predicted-medv"), 
       fill = c("red", "blue"), col = 2:3,  adj = c(0, 0.6))
grid()



#### Predictions  ####
# Run on handout set
holdout.features = subset(holdout, select=-c(donorId, month, zipCode))
holdout.predictions = predict(knnFit, newdata = holdout.features)

# Extract best samples
predictions_with_ID = data.frame(subset(holdout, select=donorId), holdout.predictions)
predictions_with_ID_Sorted = predictions_with_ID[order(predictions_with_ID$holdout.predictions, decreasing = TRUE),]

colnames(predictions_with_ID_Sorted) <- c("recommendation")

final_prediction<-subset(head(predictions_with_ID_Sorted, n=90), select=recommendation) #Please save a vector with 90 donorID that you think maximize the sum of donation.


#### Let's save your prediction into a csv file
filename<-paste0(ID1,"_",ID2,"_",ID3,".csv") # Don't modify this line!
write.csv(x=data.frame(recommendation=final_prediction),file = filename,row.names = FALSE) # Don't modify this line!


