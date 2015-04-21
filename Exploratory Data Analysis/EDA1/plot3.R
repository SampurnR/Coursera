setwd("C:\\Workspace\\R\\Codes\\Coursera\\EDA")

########## reading data
consumption_All <- read.table("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", stringsAsFactors=FALSE)
consumption_All$Date <- as.Date(consumption_All$Date, format = "%d/%m/%Y")

############## subsetting data
consumption_subset <- subset(consumption_All, Date >= as.Date("01/02/2007", format ="%d/%m/%Y") & Date <= as.Date("02/02/2007", format ="%d/%m/%Y"))

datetime <- paste(as.Date(consumption_subset$Date), consumption_subset$Time)
consumption_subset$Datetime <- as.POSIXct(datetime)
########## constructing plot
plot(consumption_subset$Sub_metering_1~consumption_subset$Datetime, type = "l", ylab = "Global Active Power (Kilowatts",  xlab = "")
lines(consumption_subset$Sub_metering_2~consumption_subset$Datetime, col = "red")
lines(consumption_subset$Sub_metering_3~consumption_subset$Datetime, col = "blue")

legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## saving plot
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
