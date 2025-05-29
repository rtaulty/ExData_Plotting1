# plot4.R

# Load and filter data - Bob Taulty
filename <- "household_power_consumption.txt"

# Read the data
data <- read.table(filename, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

# Subset for dates 1/2/2007 and 2/2/2007
subdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

# Convert to datetime
subdata$Datetime <- as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S")

# Remove rows with NA in important columns
subdata <- subdata[complete.cases(subdata[, c(
  "Global_active_power", "Voltage", "Sub_metering_1", 
  "Sub_metering_2", "Sub_metering_3", "Global_reactive_power", "Datetime"
)]), ]

# Open PNG device
png("plot4.png", width=480, height=480)

# 2x2 layout
par(mfrow = c(2, 2))

# Top-left plot: Global Active Power
plot(subdata$Datetime, subdata$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")

# Top-right plot: Voltage
plot(subdata$Datetime, subdata$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# Bottom-left plot: Sub metering
plot(subdata$Datetime, subdata$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(subdata$Datetime, subdata$Sub_metering_2, col="red")
lines(subdata$Datetime, subdata$Sub_metering_3, col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1, bty="n", cex=0.8)

# Bottom-right plot: Global Reactive Power
plot(subdata$Datetime, subdata$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global Reactive Power")

# Close device
dev.off()
