rawdata <- read.csv("household_power_consumption.txt", header = T, sep = ";", dec = ".", colClasses = c(rep("character",2),rep("numeric",7)), na.strings = "?", nrows=70000)

rawdata$Date <- as.Date(rawdata$Date, format= "%d/%m/%Y")
rawdata$Time <- stptime(rawdata$Time, format = "%H:%M:%S")

subsetted <- rawdata[rawdata$Date == as.Date("2007-02-01") | rawdata$Date == as.Date("2007-02-02"),]

rm(rawdata)

png("plot1.png",width = 480, height = 480, units = "px")
hist(subsetted$Global_active_power, col ="red", main = "Global Aactive Power", xlab="Global Active Power (kilowatts)")
dev.off()