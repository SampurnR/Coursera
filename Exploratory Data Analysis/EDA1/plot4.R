setwd("C:\\Workspace\\R\\Codes\\Coursera\\EDA")

########## reading data
consumption_All <- read.table("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", stringsAsFactors=FALSE)
consumption_All$Date <- as.Date(consumption_All$Date, format = "%d/%m/%Y")

############## subsetting data
consumption_subset <- subset(consumption_All, Date >= as.Date("01/02/2007", format ="%d/%m/%Y") & Date <= as.Date("02/02/2007", format ="%d/%m/%Y"))

datetime <- paste(as.Date(consumption_subset$Date), consumption_subset$Time)
consumption_subset$Datetime <- as.POSIXct(datetime)
########## constructing plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(consumption_subset, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
})

## saving plot
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
