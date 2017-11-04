# Week 3 quizz

source("best.R")
source("rankhospital.R")
source("rankall.R")

# 1
best("SC", "heart attack")
# [1] "MUSC MEDICAL CENTER"

# 2
best("NY", "pneumonia")
#  "MAIMONIDES MEDICAL CENTER"

# 3
best("AK", "pneumonia")
# "YUKON KUSKOKWIM DELTA REG HOSPITAL"

#4 
rankhospital("NC", "heart attack", "worst")
# "WAYNE MEMORIAL HOSPITAL"

#5 
rankhospital("WA", "heart attack", 7)
# "YAKIMA VALLEY MEMORIAL HOSPITAL"

#6 
rankhospital("TX", "pneumonia", 10)
# "SETON SMITHVILLE REGIONAL HOSPITAL"

#7
rankhospital("NY", "heart attack", 7)
#"BELLEVUE HOSPITAL CENTER"

#8
r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)
#  "CASTLE MEDICAL CENTER"

#9
r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)
# "BERGEN REGIONAL MEDICAL CENTER"

#10
r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
# "RENOWN SOUTH MEADOWS MEDICAL CENTER"