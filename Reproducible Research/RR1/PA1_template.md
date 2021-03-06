---
title: "Reproducible Research Peer Assessment 1"
output: html_document
---



**Loading and Preprocessing the data:**

1. Load the data.

2. Process/transform the data into a suitable format.

```{r}
setwd("C:\\Workspace\\R\\Codes")
activity <- read.csv("activity.csv", stringsAsFactors = FALSE)
activity$date <- as.POSIXct(activity$date)
```




**What is the mean total number of steps taken per day?:**

1. Calculate the total number of steps taken per day.


```{r}
stepsdaily <- tapply(activity$steps, activity$date, sum, na.rm = TRUE)
stepsd<- as.data.frame(stepsdaily)
```

2. Plotting the histogram.

```{r}
library(ggplot2)
ggplot(data = stepsd, aes(stepsdaily)) + geom_histogram(col = "grey", fill = "red") + labs(title = "Histogram for steps daily", x =  "Total number of steps taken each day")
```

3. Mean and Median of total number of steps taken per day.

```{r}
meansteps <- mean(stepsdaily)
mediansteps <- median(stepsdaily)
meansteps
mediansteps
```





**Average Daily Activity Pattern:**

1. Make a time series plot:
```{r}
avgstepsperinterval <- aggregate(activity$steps, by = list(activity$interval), FUN = mean, na.rm = TRUE)
colnames(avgstepsperinterval) <- c("interval", "meansteps")
ggplot(data = avgstepsperinterval, aes(y = meansteps, x = interval)) + geom_line() + labs(x = "5-minute intervals", y = "Average number of steps taken")
```

2. 5-minute interval that contains the maximum number of steps:
```{r}
moststeps <- which.max(avgstepsperinterval$meansteps)
moststepstime <- avgstepsperinterval[moststeps,]$interval
moststepstime
```

**Impute Missing Values:**

1. Total number of missing values in the dataset:

```{r}
numMissingValues <- length(which(is.na(activity$steps)))
numMissingValues
```

2. Impute Strategy:
3. Create new dataset with imputed data:

```{r}
imputeddata <- activity
imputeddata[is.na(imputeddata$steps), ]$steps = mean(imputeddata$steps, na.rm = TRUE)
```

4. Make histogram; Report mean and median of imputed data:
```{r}
stepsdailyimputed <- tapply(imputeddata$steps, imputeddata$date, sum)
stepsdfimputed <- as.data.frame(stepsdailyimputed)
library(ggplot2)
ggplot(data = stepsdfimputed, aes(stepsdailyimputed)) + geom_histogram(col = "grey", fill = "red") + labs(title = "Histogram for steps daily (Imputed data)", x =  "Total number of steps taken each day")
meanstepsimputed <- mean(stepsdailyimputed)
medianstepsimputed <- median(stepsdailyimputed)
meanstepsimputed
medianstepsimputed
```

**Are there differences in activity patterns between weekdays and weekends?:**

1. Create a new factor variable in the dataset with two levels - "weekday" and "weekend":

```{r}
imputeddata$dateType <-  ifelse(as.POSIXlt(imputeddata$date)$wday %in% c(0,6), 'weekend', 'weekday')
```

2. Plot a time series:

```{r}
averagedActivityDataImputed <- aggregate(steps ~ interval + dateType, data=imputeddata, mean)
ggplot(averagedActivityDataImputed, aes(interval, steps)) + geom_line() + facet_grid(dateType ~ .) + xlab("5-minute interval") + ylab("avarage number of steps")
```


EOF!
```{r}
file.rename(from = "pa_rmd.Rmd", to = "pa.md")
```