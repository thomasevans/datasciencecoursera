
# q1
american_com_survey <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

# How many properties are worth $1,000,000 or more?
sum(american_com_survey$VAL == 24, na.rm = TRUE)


# q3
library("xlsx")
# ?download.file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "natgas.xlsx", method = "libcurl")

dat <- read.xlsx("natgas2.xlsx",
                  sheetIndex = 1,
                 rowIndex = c(18:23),
                 colIndex = c(7:15))
# ?read.xlsx

sum(dat$Zip*dat$Ext, na.rm = TRUE)

# q4
library(XML)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", "balt.xml", method = "libcurl")

balt_res <- xmlTreeParse("balt.xml")
balt_res_root <- xmlRoot(balt_res)
balt_res_xml <- xmlParse("balt.xml")

length(xpathApply(balt_res_xml, "//zipcode[text()='21231']", xmlValue))


# q5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "am_com_dat.csv")

library(data.table)

# ?fread

DT <- fread("am_com_dat.csv", sep = ",", header = TRUE)

DT[,mean(pwgtp15),by=SEX]
