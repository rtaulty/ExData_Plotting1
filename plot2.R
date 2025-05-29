# By Bob Taulty, Let's get the data and make the Line Plot
# plot2.R

# Load and filter data
filename <- "household_power_consumption.txt"

# Read the data with appropriate settings
data <- read.table(filename, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

# Subset for dates 1/2/2007 and 2/2/2007
subdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

# Convert Date and Time into a single POSIXct datetime column
subdata$Datetime <- as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S")

# Optional: remove rows with missing values in relevant columns
subdata <- subdata[!is.na(subdata$Datetime) & !is.na(subdata$Global_active_power), ]

# Create the plot and save to PNG
png("plot2.png", width=480, height=480)

plot(subdata$Datetime, subdata$Global_active_power,
     type="l",
     xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.off()

