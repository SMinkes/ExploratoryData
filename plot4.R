#store langugage settings
user_lang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

## read in data
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")
data$datetime <- as.POSIXlt(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
selection <- subset(data, (as.Date(data$Date, "%d/%m/%Y") == (as.Date("2007-02-01", "%Y-%m-%d")) | (as.Date(data$Date, "%d/%m/%Y") == (as.Date("2007-02-02", "%Y-%m-%d")))))
dt <- selection$datetime
GAP <- as.numeric(selection$Global_active_power)/500
RAP <- as.numeric(selection$Global_reactive_power)/500
y1 <- as.numeric(as.character(selection$Sub_metering_1))
y2 <- as.numeric(as.character(selection$Sub_metering_2))
y3 <- selection$Sub_metering_3
voltage <- as.numeric(as.character(selection$Voltage))

## Opening the PNG device
png()
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

## Plot top left
plot(dt, GAP, xlab="", ylab="Global Active Power", type="l")
axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri", "Sat"))

## Plot top right
plot(dt, voltage, type="l", xlab="datetime", ylab="Voltage")
axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri", "Sat"))

## Plot bottom left
plot(dt, y1, type="l", xlab="", ylab="Energy Sub metering", axes=TRUE)
lines(dt, y2, col="red")
lines(dt, y3, col="blue")
axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri", "Sat"))
legend(x="topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty="solid", bty="n")

## Plot bottom right
plot(dt, RAP, , xlab="datetime", ylab="Global_reactive_power", type="l", ylim=c(0,0.5))
axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri", "Sat"))

## Closing the device
dev.off()

#restore language
Sys.setlocale("LC_TIME", user_lang)