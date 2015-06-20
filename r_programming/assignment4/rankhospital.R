rankhospital <- function(state, outcome, num = "best") {
  resultHospital <- NA
  
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
      outcomesData <- suppressWarnings(as.double(byStateData[[columnName]]))
      
      if (num == "best") {
        vals <- min(outcomesData, na.rm=TRUE)
        str <- as.character(sprintf("%.1f", vals))
      } else if(num == "worst") { 
        vals <- max(outcomesData, na.rm=TRUE)
        str <- as.character(sprintf("%.1f", vals))
      } else {
        t <- suppressWarnings(as.double(byStateData[[columnName]]))
        # Converted to NAs.
        new <-  byStateData[t, ]
        
        byStateDataOrdered <- new[order(columnName, na.last=NA), ]
        return(byStateDataOrdered[num, ]$Hospital.Name)
      }
      
      t <- byStateData[byStateData[[columnName]] == str, ]
      resultHospital <- t$Hospital.Name
    } else {
      stop("invalid outcome")
    }
  } else {
    stop("invalid state")
  }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate.
  resultHospital
  
 
}