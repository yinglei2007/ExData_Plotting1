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

## define Global_active_power column as numeric
subData[,3] <- as.numeric(subData[, 3])

## transform Global_active_power to KW
subData <- mutate(subData, GAP_KW = (Global_active_power/1000)*2)

## make histogram for Global_active_power in kilowalt and export to plot1.png
png(filename="plot1.png", width=480, height=480)
plot1 <- hist(subData$GAP_KW, col="red", ylim=c(0,1200), xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()


