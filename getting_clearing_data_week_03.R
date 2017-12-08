# Exercise 01 ---------------
url.d <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(url.d, "am_com_surv.csv")

am_com <- read.csv("am_com_surv.csv", header = TRUE)

# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products.
# Assign that logical vector to the variable agricultureLogical.
agricultureLogical <- (am_com$ACR == 3) & (am_com$AGS == 6)

#Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
which(agricultureLogical)[1:3]

# Exercise 02 ------
install.packages("jpeg")
library(jpeg)

url.d <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

download.file(url.d, "instruct.jpg")

# Using the jpeg package read in the following picture of your instructor into R
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

pic <- readJPEG("instruct2.jpg", native = TRUE)
quantile(pic, c(.3, .8))


# Exercise 03 -------
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
url.d <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(url.d, "gdp.csv")

gdp <- read.csv("gdp.csv", skip = 5, nrows = 190, stringsAsFactors = F, header = F)

# Load the educational data from this data set:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
url.d <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(url.d, "ed.csv")

ed <- read.csv("ed.csv", header = TRUE)
# 
# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

gdp <- gdp[, c(1, 2, 4, 5)]
colnames(gdp) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")

sum(gdp$CountryCode %in% ed$CountryCode)
# 189

comb.df <- merge(gdp, ed, by = "CountryCode")

library(dplyr)

comb.df.sort <- arrange(comb.df, desc(Rank))

comb.df.sort$Country.Name[13]


# Exercise 04 -----
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
comb.df.sort %>% group_by(Income.Group) %>% summarise(mean(Rank))


# Exercise 05 -----
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?
library(Hmisc)

comb.df.sort$groups <- cut2(comb.df.sort$Rank, g = 5)
table(comb.df.sort$groups, comb.df.sort$Income.Group)


