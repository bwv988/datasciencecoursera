## RS06052014
best <- function(state, outcome) {
  
  resultHospital <- NULL
  ## Read outcome data.
  outcomeData <<- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid.
  validStates <<- unique(outcomeData$State)
  validOutcomes <<- c("heart attack", "heart failure", "pneumonia")
  validOutcomesReal <<- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                          "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                          "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  # Create a hash map.
  names(validOutcomesReal) <<- validOutcomes
  
  if (state %in% validStates) {
    if (outcome %in% validOutcomes) {
      columnName <- validOutcomesReal[[outcome]]
      byStateData <- outcomeData[outcomeData$State == state, ]
      minVal <- min(suppressWarnings(as.double(byStateData[[columnName]])), na.rm=TRUE)
      minStr <- as.character(sprintf("%.1f", minVal))
      t <- byStateData[byStateData[[columnName]] == minStr, ]
      resultHospital <- t$Hospital.Name
    } else {
      stop("invalid outcome")
    }
  } else {
    stop("invalid state")
  }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate.
  resultHospital
}