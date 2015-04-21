setwd("C:\\Workspace\\R\\Codes\\Coursera\\EDA")
########## reading data
consumption_All <- read.table("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", stringsAsFactors=FALSE)
consumption_All$Date <- as.Date(consumption_All$Date, format = "%d/%m/%Y")

############## subsetting data
consumption_subset <- subset(consumption_All, Date >= as.Date("01/02/2007", format ="%d/%m/%Y") & Date <= as.Date("02/02/2007", format ="%d/%m/%Y"))

########## constructing plot
hist(consumption_subset$Global_active_power, col ="red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)", ylab = "Frequency")

##### saving plot
dev.copy(png, "plot1.png", height = 480, width = 480)
dev.off()
