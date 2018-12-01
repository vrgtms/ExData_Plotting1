# Get the data if it's not already downloaded
if (!("household_power_consumption.txt" %in% dir())) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "powerConsumption.zip")
  unzip("powerConsumption.zip")
  file.remove("powerConsumption.zip")
}

# Open and transform it
colClasses <- c("character", "factor", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = colClasses, na.strings = "?")
data <- data[ which(data$Date == "1/2/2007" | data$Date == "2/2/2007"), ]
data$datetime <- as.POSIXct( paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S" )

# Open device
png(filename = "plot1.png", bg = "white")

# Draw chart
hist(data$Global_active_power, freq = TRUE, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

# Save to png
dev.off()
