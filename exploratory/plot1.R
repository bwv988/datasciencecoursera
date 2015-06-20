# plot1.R
colors = c("red")
plot1 <- function() {
  # Load and pre-process data set.
  fName <- "data/household_power_consumption.txt"
  data <- read.csv(fName, sep=";", na.strings="?", skip = 66637, nrows = 2880,
                   col.names = colnames(read.table(fName, nrow = 1,   header = TRUE, sep=";")))
  
  # Convert time/date to time/date objects.
  data$Time <- strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
  data$Date <- as.Date(data$Date)
  
  # Plot to file.
  plot.new()
  
  # Create new PNG. 480x480 is default.
  png(file="plot1.png")
  
  # Draw the histogram.
  hist(data$Global_active_power, col=colors, xlab="Global Active Power (kilowatts)", main="Global Active Power")
  
  # Write to file.
  dev.off()
}