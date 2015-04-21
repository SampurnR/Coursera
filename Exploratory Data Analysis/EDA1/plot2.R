setwd("C:\\Workspace\\R\\Codes\\Coursera\\EDA")
########## reading data
consumption_All <- read.table("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", stringsAsFactors=FALSE)
consumption_All$Date <- as.Date(consumption_All$Date, format = "%d/%m/%Y")

############## subsetting data
consumption_subset <- subset(consumption_All, Date >= as.Date("01/02/2007", format ="%d/%m/%Y") & Date <= as.Date("02/02/2007", format ="%d/%m/%Y"))
#consumption_subset$day <- weekdays(consumption_subset$Date)

datetime <- paste(as.Date(consumption_subset$Date), consumption_subset$Time)
consumption_subset$Datetime <- as.POSIXct(datetime)

## Plot 2
plot(consumption_subset$Global_active_power~consumption_subset$Datetime, type="l", ylab="Global Active Power (kilowatts)",  xlab = "")
########## constructing plot
#plot(x = consumption_subset$day, y = consumption_subset$Global_active_power, xlab = "", ylab = "Global Active Power (Kilowatts)")
#plot(consumption_subset$Global_active_power~consumption_subset$day, type="l", ylab="Global Active Power (kilowatts)", xlab="")
##### saving plot
dev.copy(png, "plot2.png", height = 480, width = 480)
dev.off()
