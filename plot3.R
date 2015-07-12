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

## plot submetering one by one
png(filename="plot3.png", width=480, height=480)
plot(as.numeric(subData$Sub_metering_1),xaxt="n",type = "l", ylab="Enerby sub metering", xlab=" ") 
lines(as.numeric(subData$Sub_metering_2), type="l", col="red")
lines(as.numeric(subData$Sub_metering_3), typle="l", col="blue")
axis(1, at=c(1,1441,2881), labels=c('Thu', 'Fri', 'Sat'))

dev.off()


