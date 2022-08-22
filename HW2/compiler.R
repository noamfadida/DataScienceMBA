# We will set the WD to the folder in which the scripts are located:

if(!"rstudioapi" %in% installed.packages()) { 
    install.packages("rstudioapi")}

# Getting the path of your current open file
current_path = rstudioapi::getActiveDocumentContext()$path 
setwd(dirname(current_path ))
print( getwd() ) # You can make sure that the WD is correct. If it is not - send Or an E-mail

# To make sure that your script runs, please delete your csv file with the predictions from your library, 
# run the next row and then make sure that the excel file appears (again) in the same folder as the script.
rm(list = ls())
source("script.R")
# To check your assignment, we will run only the above row, and evaluate your score based on the prediction we will find in the excel file that this script produces... 

# To make sure that we are on the same page, we will make now some sanity checks
# All the requirements are in the moodle, read them carefully.
# To minimize the risk of sending a file in the wrong format lets run these chunks of code together
# Each chunk is an if/else command that check some aspect of the code, and return a message in the console.
# If you encounter a problem, stop and fix it before running the next tests.
# If R returns an error, this is a bad sign as well...

filename<-paste0(ID1,"_",ID2,"_",ID3,".csv")

####  Does the file exist?
if (file.exists(filename)) {
  df<-read.csv(filename)
  print("I found the csv I looked for")
} else {
print("Warning : I could not find your csv file, make sure that your script makes one")
}

####  number of cols
if (ncol(df)==1) {
  print("number of cols seems to be fine")
}else {
  print("Warning : I expected to see 1 column")
}

####  NA's?
if (sum(is.na(df))==0) {
  print("I did not find any NA value (that's good)")
}else {
  print("Warning : I found NA's but really hope not to see...")
}

####  recommendation variable?
if (c("recommendation") %in% names(df)) {
  print("I found the variables I looked for")
}else {
  print("Warning : I expected to see a column named recommendation")
}

