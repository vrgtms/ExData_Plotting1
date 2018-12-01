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
png(filename = "plot4.png", bg = "white")

# Draw charts
par(mfcol = c(2, 2))

plot( Global_active_power ~ datetime, data, type="l", ylab = "Global Active Power (kilowatts)", xlab = "" )

plot(Sub_metering_1 ~ datetime, data, type="l", ylab = "Energy sub metering", xlab = "")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend( 'topright', legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1 )

plot( Voltage ~ datetime, data, type="l" )

plot( Global_reactive_power ~ datetime, data, type="l" )

# Save to png
dev.off()
