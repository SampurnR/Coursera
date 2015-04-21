# load data
setwd("C:\\Workspace\\R\\Codes")
activity <- read.csv("activity.csv", stringsAsFactors = FALSE)

# transform data
activity$date <- as.POSIXct(activity$date)

# Calculate number of steps taken per day
stepsdaily <- tapply(activity$steps, activity$date, sum, na.rm = TRUE)

stepsd<- as.data.frame(stepsdaily)

## create histogram
library(ggplot2)
ggplot(data = stepsd, aes(stepsdaily)) + geom_histogram(col = "grey", fill = "red") 
			+ labs(title = "Histogram for steps daily", x =  "Total number of steps taken each day")

### calculate and report mean and median
meansteps <- mean(stepsdaily)
mediansteps <- median(stepsdaily)


####################################
### average daily activity pattern
avgstepsperinterval <- aggregate(activity$steps, by = list(activity$interval), FUN = mean, na.rm = TRUE)
colnames(avgstepsperinterval) <- c("interval", "meansteps")
ggplot(data = avgstepsperinterval, aes(y = meansteps, x = interval)) + geom_line() 
			+ labs(x = "5-minute intervals", y = "Average number of steps taken")
### 5-minnute interval that contains most number of steps
moststeps <- which.max(avgstepsperinterval$meansteps)
moststepstime <- avgstepsperinterval[moststeps,]$interval


###################################
### number of na/missing values
numMissingValues <- length(which(is.na(activity$steps)))
### impute data
imputeddata <- activity
imputeddata[is.na(imputeddata$steps), ]$steps = mean(imputeddata$steps, na.rm = TRUE)


### histogram
stepsdailyimputed <- tapply(imputeddata$steps, imputeddata$date, sum, na.rm = TRUE)
stepsdfimputed <- as.data.frame(stepsdailyimputed)
ggplot(data = stepsdfimputed, aes(stepsdailyimputed)) + geom_histogram(col = "grey", fill = "red") 
			+ labs(title = "Histogram for steps daily (Imputed data)", x =  "Total number of steps taken each day")
meanstepsimputed <- mean(stepsdailyimputed)
medianstepsimputed <- median(stepsdailyimputed)
meanstepsimputed
medianstepsimputed

##########################
### weekday/weekend factoring
imputeddata$dateType <-  ifelse(as.POSIXlt(imputeddata$date)$wday %in% c(0,6), 'weekend', 'weekday')

### time series plot
averagedActivityDataImputed <- aggregate(steps ~ interval + dateType, data=imputeddata, mean)
ggplot(averagedActivityDataImputed, aes(interval, steps)) 
			+ geom_line() + facet_grid(dateType ~ .) + xlab("5-minute interval") + ylab("avarage number of steps")