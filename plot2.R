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

## define Global_active_power column as numeric
subData[,3] <- as.numeric(subData[,3])

## combine Date and Time and make DateTime column in POSIXct format
DateTime <- strptime(paste(subData$Date, subData$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
subData <- cbind(subData, DateTime)

## transform Global_active_power to KW
subData <- mutate(subData, GAP_KW = (Global_active_power/1000)*2)


## plot Global_active_power to DateTime with line format
png(filename="plot2.png", width=480, height=480)
plot(subData$DateTime, subData$GAP_KW,ylab="Global Active Power (kilowatts)",xlab=" ", type="l")
dev.off()


