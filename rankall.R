# outcome <- "heart attack"

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomedat <- read.csv("rprog%2Fdata%2FProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  # str(outcomedat)
  ## Check that state and outcome are valid
  if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))){
    stop("invalid outcome")
  }

  ## For each state, find the hospital of the given rank
  states <- sort(unique(outcomedat$State))
  
  # state <- states[1]
  fun_hosp <- function(state){
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
    if(num == "best") {return(hospitals_ranked[1])} else if(num == "worst"){
      return(hospitals_ranked[length(hospitals_ranked)])
    } else{return(hospitals_ranked[num])}
  }
  
  hospital <- sapply(states, fun_hosp)
  state <- states
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  return(cbind.data.frame(hospital, state))
}

# 
# head(rankall("heart attack", 20), 10)
# tail(rankall("pneumonia", "worst"), 3)
# tail(rankall("heart failure"), 10)
