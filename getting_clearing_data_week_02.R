

# Q1 - GitHub
# Client ID
# 435eb0c9f8d55253a7bd
# Client Secret
# 95ff3ce2ec35622341d4fe38f44237d65decf2b2

# Based on https://github.com/r-lib/httr/blob/master/demo/oauth2-github.r

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at 
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "435eb0c9f8d55253a7bd",
                   secret = "95ff3ce2ec35622341d4fe38f44237d65decf2b2")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)


test <- GET("https://api.github.com/users/jtleek/repos", gtoken)
names(test)

stop_for_status(test)  # Gives an error message if the above failed
output <- content(test)   # Parses the returned object

# Find what repos are here
repos <- NULL
for( i in 1:length(output)){
  repos[i] <- output[[i]]$name
}
# Which number repo is the datasharing one?
repo_n <- c(1:length(repos))[repos == "datasharing"]

output[[repo_n]]$created_at  # Output the date created


# Q2
install.packages("sqldf")
library(sqldf)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "Amcommsurv.csv")

acs <- read.csv("Amcommsurv.csv", header = TRUE)

sqldf("select pwgtp1 from acs where AGEP < 50")

# Q3
a <- sqldf("select distinct AGEP from acs")
# Is this the same as unique...
all.equal(sort(a[,1]), sort(unique(acs$AGEP)))

# Q4
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
html <- readLines(con = url)
nchar(html[c(10,20, 30,100)])


# Q5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url, "q5.for")

# See the top of the file
head(readLines(con = "q5.for"))

# Load in file
q5_dat <- read.fwf("q5.for", 
                   widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4),
                   skip = 4)
# Sum of 4th column
sum(q5_dat[,4])
