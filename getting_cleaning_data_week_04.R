library(dplyr)

# Exercise 01 ----------

url.dat <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(url.dat, "AmCommSurv.csv")

# Load data in and make tibble
AmCommSurv <- read.csv("AmCommSurv.csv", header = TRUE)
AmCommSurv <- as_tibble(AmCommSurv)

AmCommSurv_names <- names(AmCommSurv)


AmCommSurv_names_split <- strsplit(AmCommSurv_names, "wgtp")
AmCommSurv_names_split[[123]]


# Exercise 02 --------
url.dat <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(url.dat, "GrossDomProd.csv")

# Load data in and make tibble
grossprod <- read.csv("GrossDomProd.csv",
                      skip = 4, 
                      header = TRUE)
# grossprod <- as_tibble(grossprod)
grossprod <- grossprod[c(1:190),]

grossprod[,5] <- gsub(",", "", as.character(grossprod[,5]))
grossprod[,5] <- gsub(" ", "", as.character(grossprod[,5]))

mean(as.numeric(grossprod[,5]), na.rm = TRUE)


# Exercise 03 --------
#' In the data set from Question 2 what is a regular
#' expression that would allow you to count the number
#' of countries whose name begins with "United"?
#' Assume that the variable with the country names
#' in it is named countryNames. How many countries
#' begin with United?

grossprod[,4][grep("^United",grossprod[,4])]


# Exercise 04 -------

#'Load the Gross Domestic Product data for the 190 ranked countries in this data set:
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(url1, "GrossDomProd.csv")

# Load data 
grossprod <- read.csv("GrossDomProd.csv",
                      skip = 4, 
                      header = TRUE)
grossprod <- grossprod[c(1:190),]


#' Load the educational data from this data set:

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(url2, "Education.csv")

# Load data 
education <- read.csv("Education.csv",
                      skip = 0, 
                      header = TRUE)


#' Match the data based on the country shortcode.
combined.tab <- merge(grossprod, education, by.x = "X", by.y = "CountryCode")

# Of the countries for which the end of the fiscal year is available, how many end in June?

length(grep("Fiscal year end: June",combined.tab[,"Special.Notes"]))


# Exercise 05 --------
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

str(sampleTimes)
sum(year(sampleTimes) == "2012")
sum((wday(sampleTimes) == 2) & (year(sampleTimes) == "2012"))
