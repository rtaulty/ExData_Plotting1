

# Load and filter data - Bob Taulty
filename <- "household_power_consumption.txt"

# Read the data
data <- read.table(filename, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

# Subset for dates 1/2/2007 and 2/2/2007
subdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

# Create a datetime column
subdata$Datetime <- as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S")

# Remove rows with NA values in the sub metering columns
subdata <- subdata[complete.cases(subdata[, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "Datetime")]), ]

# Create the plot and save to PNG
png("plot3.png", width=480, height=480)

# Plot the first line
plot(subdata$Datetime, subdata$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")

# Add the second line
lines(subdata$Datetime, subdata$Sub_metering_2, col="red")

# Add the third line
lines(subdata$Datetime, subdata$Sub_metering_3, col="blue")

# Add a legend
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=1)

dev.off()
