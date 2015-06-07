## Download the data file, saving it to the working directory as household_power_consumption.zip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")

## Unzip the data file, creating the file household_power_consumption.txt
unzip("household_power_consumption.zip")

## Read the data in the file to a data frame
dfPowerConsumption = read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")

## Create combined Date/Time object column
dfPowerConsumption$DateTime <- as.POSIXct(paste(dfPowerConsumption$Date, dfPowerConsumption$Time), 
										  format = "%d/%m/%Y %H:%M:%S")
## Remove original Date and Time columns
dfPowerConsumption$Date <- NULL
dfPowerConsumption$Time <- NULL

## Pare down the data to the range between 2007-02-01 to 2007-02-02
dfPowerConsumption <- subset(dfPowerConsumption, DateTime >= as.POSIXct("2007-02-01"))
dfPowerConsumption <- subset(dfPowerConsumption, DateTime <= as.POSIXct("2007-02-02 23:59:59.999"))

## Open the png drawing device (this helps prevent the legend from being cut off in # 3)
png(file="plot4.png")

## Divide the drawing window into 4 boxes
par(mfrow=c(2, 2))

## Graph 1: Plot the Global Active Power vs the Date/Time
plot(dfPowerConsumption$DateTime, dfPowerConsumption$Global_active_power, 
	 type="n",
	 xlab="",
	 ylab="Global Active Power")
lines(dfPowerConsumption$DateTime, dfPowerConsumption$Global_active_power)

## Graph 2: Plot the Voltage vs the Date/Time
plot(dfPowerConsumption$DateTime, dfPowerConsumption$Voltage, 
	 type="n",
	 xlab="datetime",
	 ylab="Voltage")
lines(dfPowerConsumption$DateTime, dfPowerConsumption$Voltage)

## Graph 3: Overlay of Sub_metering_1, Sub_metering_2, Sub_metering_3
## Plot the graph for Sub_metering_1, which has the broadest set of values
plot(dfPowerConsumption$DateTime, dfPowerConsumption$Sub_metering_1, 
	 type="n",
	 xlab="",
	 ylab="Energy sub metering")
## Plot the lines for Sub_metering_1, Sub_metering_2, and Sub_metering_1
lines(dfPowerConsumption$DateTime, dfPowerConsumption$Sub_metering_1)
lines(dfPowerConsumption$DateTime, dfPowerConsumption$Sub_metering_2, col="red")
lines(dfPowerConsumption$DateTime, dfPowerConsumption$Sub_metering_3, col="blue")
## Set the legend at the top-right corner
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(2.5,2.5), col=c("black", "red", "blue"), bty="n")

## Graph 4: Plot the Global_reactive_power vs the Date/Time
plot(dfPowerConsumption$DateTime, dfPowerConsumption$Global_reactive_power, 
	 type="n",
	 xlab="datetime",
	 ylab="Global_reactive_power")
lines(dfPowerConsumption$DateTime, dfPowerConsumption$Global_reactive_power)

## Close PNG file to write the file
dev.off()
