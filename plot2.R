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

## Plot the Global Active Power vs the Date/Time
plot(dfPowerConsumption$DateTime, dfPowerConsumption$Global_active_power, 
	 type="n",
	 xlab="",
	 ylab="Global Active Power (kilowatts)")
lines(dfPowerConsumption$DateTime, dfPowerConsumption$Global_active_power)

## Save the plot to a PNG file
dev.copy(png, file="plot2.png")
dev.off()
