# Description:
# This code will create a DB, than will export it to a csv. file
# and than will read its data using a function

#Set working directory
setwd('C:/projects/MBA/Summer22/DataScienceMBA/MiniAssignment1/')

#num
num <- 2

#vec
vec <- c(1:10)

#create data frame with two columns
df <- data.frame(A = vec, B = vec*num)

#save data frame to a csv file
write.csv(df, file = 'file.csv', row.names = FALSE)

#read file.csv to a new data frame
df2 <- read.csv(file = 'file.csv')

#print and filter only rows 2, 4, and 7
df2[c(2,4,7),]

#print the first column using $
df2$A

#print the first column using []
df2[,1]
