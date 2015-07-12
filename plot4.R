library(plyr)
library(dplyr)
library(datasets)
## download "household_power_consumption.zip" from website
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", destfile="IndiviualHouseholdElectricPowder.zip", method="curl")

## read file to variable allDat
Unzipped <- unzip("IndiviualHouseholdElectricPowder.zip")
allData <- read.table(Unzipped, header=TRUE, sep=";")
## subset data for 2007-02-01 and 2007-02-02
subData <- subset(allData, Date %in% c("1/2/2007", "2/2/2007"))

## combine Date and Time and make DateTime column in POSIXct format
DateTime <- strptime(paste(subData$Date, subData$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
subData <- cbind(subData, DateTime)

## Set 3 columns of submetering data as numeric
subData[,7] <- as.numeric(subData[, 7])
subData[,8] <- as.numeric(subData[, 8])
subData[,9] <- as.numeric(subData[, 9])

## define Global_active_power and Global_reactive_powercolumn as numeric
subData[,3] <- as.numeric(subData[, 3])
subData[,4] <- as.numeric(subData[, 4])

## transform Global_active_power to KW
subData <- mutate(subData, GAP_KW = (Global_active_power/1000)*2)

## make 4 plots one by one
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subData, {
     ## for upper right
   plot(subData$DateTime, subData$GAP_KW, ylab="Global Active Power", xlab=" ", type="l")
     ## for upper left
   plot(subData$DateTime, subData$Voltage, ylab="Voltage", xlab="datetime", type="l")
    ## for lower right
   plot(as.numeric(subData$Sub_metering_1),xaxt="n", ylab="Energy sub metering", xlab=" ", type = "l") 
   lines(as.numeric(subData$Sub_metering_2), type="l", col="red")
   lines(as.numeric(subData$Sub_metering_3), type="l", col="blue")
   axis(1, at=c(1,1441,2881), labels=c('Thu', 'Fri', 'Sat'))
    ## for lower left
   plot(subData$DateTime, subData$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")
})

dev.off()



