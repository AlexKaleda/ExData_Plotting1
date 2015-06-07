#--  save the locale (we need to switch to US) ----
backup_locale <- Sys.getlocale('LC_TIME')
Sys.setlocale('LC_TIME', 'C')

rawdata <- read.csv("household_power_consumption.txt", header = T, sep = ";", dec = ".", colClasses = c(rep("character",2),rep("numeric",7)), na.strings = "?", nrows=70000)
rawdata$DateTime <- paste(rawdata$Date, rawdata$Time, sep = " ")
rawdata$Date <- as.Date(rawdata$Date, format= "%d/%m/%Y")
rawdata$Time <- strptime(rawdata$Time, format = "%H:%M:%S")
rawdata$DateTime <- as.POSIXct(rawdata$DateTime, format = "%d/%m/%Y %H:%M:%S")

subsetted <- rawdata[rawdata$Date == as.Date("2007-02-01") | rawdata$Date == as.Date("2007-02-02"),]

rm(rawdata)

png("plot3.png", width = 480, height = 480, units = "px")
plot(subsetted$DateTime,subsetted$Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering")
lines(subsetted$DateTime,subsetted$Sub_metering_2, type="l", col = "red")
lines(subsetted$DateTime,subsetted$Sub_metering_3, type="l", col = "blue")
legend("topright", names(subsetted)[7:9], lty=1, col=c("black", "red", "blue"))
dev.off()

#---------  restore changes -------------------    
Sys.setlocale('LC_TIME', backup_locale)