# 
# state <- "TX"
# outcome <- "heart failure"
# num <- 4

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  outcomedat <- read.csv("rprog%2Fdata%2FProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if(!(state %in% unique(outcomedat$State))){
    stop("invalid state")
  }
  if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))){
    stop("invalid outcome")
  }
  
  
  # State subset
  outsub <- subset(outcomedat, State == state)
  
  var2test <- cbind.data.frame(
    outsub$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack
    ,outsub$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
    ,outsub$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia
  )[,outcome == c("heart attack", "heart failure", "pneumonia")]
  
  # Get ranks
  hospitals_ranked <- outsub$Hospital.Name[order((as.numeric(as.character(var2test))), outsub$Hospital.Name )]
  
  # Exclude NAs
  hospitals_ranked <- hospitals_ranked[!((var2test[order((as.numeric(as.character(var2test))), outsub$Hospital.Name )]) == "Not Available")]
  
  
  # var2test[order((as.numeric(as.character(var2test))))]
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if(num == "best") return(hospitals_ranked[1])else if(num == "worst"){
    return(hospitals_ranked[length(hospitals_ranked)])
  } else{return(hospitals_ranked[num])}
  
}
# 
# rankhospital("TX", "heart failure", 1)
# rankhospital("TX", "heart failure", 4)
# 
# rankhospital("MD", "heart attack", "worst")
# 
# rankhospital("MN", "heart attack", 5000)
# 
