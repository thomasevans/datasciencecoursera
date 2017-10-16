# Week 1 quizz

# Read in data
dataset <- read.csv("hw1_data.csv")
str(dataset)

# First two rows
dataset[c(1:2),]

# N rows
nrow(dataset)

# Last 2 rows
dataset[c(nrow(dataset)-1, nrow(dataset)),]

# Ozone 47th row
dataset$Ozone[47]

# Number of missing values in Ozone column
sum(is.na(dataset$Ozone))

# Mean of ozone column
mean(dataset$Ozone, na.rm = TRUE)

#Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?
dataset2 <- dataset[(dataset$Ozone>31  &
                       dataset$Temp >90),]
mean(dataset2$Solar.R, na.rm = TRUE)


# What is the mean of "Temp" when "Month" is equal to 6?
mean(dataset$Temp[dataset$Month == 6], na.rm = TRUE)


#What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?
max(dataset$Ozone[dataset$Month == 5], na.rm = TRUE)
