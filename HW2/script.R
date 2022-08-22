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
name1<- "Inbal Yahav Shenberger"
ID1<-   "1234"
name2<- "Sagit Bar-gill"
ID2<-   "123"
name3<- "0" # if you work as a couple, insert "0"
ID3<-   "0" # if you work as a couple, insert "0"

# If you use any package that was not used in the course materials
# Please add its name to the vector in row 36
# otherwise you can ignore the next line
my.packages<-c("ggplot2","data.table") 

################################################################################
######################### The actual work starts here: ######################### 
################################################################################


#### Read files  ####
df<-"Modify this line"            #"Please read cross_2022C.csv file and store it as df"
holdout<-"Modify this line"       #"Please read holdout_2022C.csv file and store it as holdout"




#### Pre-processing  ####
# Please use this part of the to do all the data cleaning, feature engineering and so on


#### Models ####




#### Predictions  ####
final_prediction<-"Modify this line" #Please save a vector with 90 donorID that you think maximize the sum of donation.


#### Let's save your prediction into a csv file
filename<-paste0(ID1,"_",ID2,"_",ID3,".csv") # Don't modify this line!
write.csv(x=data.frame(recommendation=final_prediction),file = filename,row.names = FALSE) # Don't modify this line!


