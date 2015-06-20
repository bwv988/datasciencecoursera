# plot2.R

plot2 <- function() {
  # Load and pre-process data set.
  fName <- "data/household_power_consumption.txt"
  data <- read.csv(fName, sep=";", na.strings="?", skip = 66637, nrows = 2880,
                   col.names = colnames(read.table(fName, nrow = 1,   header = TRUE, sep=";")))
  
  
  # Convert time/date to time/date objects.
  data$Time <- strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
  data$Date <- as.Date(data$Date)
  
  Sys.setlocale(category = "LC_ALL", locale = "C")
  
  # Plot to file.
  plot.new()
  
  # Create new PNG. 480x480 is default.
  png(file="plot2.png")
  
  # Draw the plot.
  with(data, plot(Time, Global_active_power, type="l", col="black", ylab="Global Active Power (kilowatts)", xaxt = "n", xlab=""))
  
  # Write to file.
  dev.off()
}