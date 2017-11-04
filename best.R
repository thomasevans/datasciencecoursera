best <- function(state, outcome) {
  ## Read outcome data
  outcomedat <- read.csv("rprog%2Fdata%2FProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if(!(state %in% unique(outcomedat$State))){
    stop("invalid state")
  }
  if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))){
    stop("invalid outcome")
  }
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  # State subset
  outsub <- subset(outcomedat, State == state)
  var2test <- cbind.data.frame(
    outsub$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack
    ,outsub$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
    ,outsub$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia
  )[,outcome == c("heart attack", "heart failure", "pneumonia")]
  
  # Find minimum value
  var.min <- min(as.numeric(as.character(var2test)), na.rm = TRUE)
  
  return(sort(outsub$Hospital.Name[as.numeric(as.character(var2test)) == var.min])[1])
    
}

# best("TX", "heart attack")
# 
# best("TX", "heart failure")
# 
# best("MD", "heart attack")
# 
# best("MD", "pneumonia")
# 
# best("BB", "heart attack")
# 
# best("NY", "hert attack")
