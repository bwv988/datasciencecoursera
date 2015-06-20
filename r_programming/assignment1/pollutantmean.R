pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  values <- c()
  for (idx in id) {
    fname <- paste(directory, "/", sprintf("%.3d.csv", idx), sep="")
    temp <- read.csv(fname)
    p <- temp[pollutant]
    values <- c(values, p[!is.na(p)])
  }
  
  mean(values)
}