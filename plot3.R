#store langugage settings
user_lang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

## read in data
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")
data$datetime <- as.POSIXlt(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
selection <- subset(data, (as.Date(data$Date, "%d/%m/%Y") == (as.Date("2007-02-01", "%Y-%m-%d")) | (as.Date(data$Date, "%d/%m/%Y") == (as.Date("2007-02-02", "%Y-%m-%d")))))
dt <- selection$datetime
y1 <- as.numeric(as.character(selection$Sub_metering_1))
y2 <- as.numeric(as.character(selection$Sub_metering_2))
y3 <- selection$Sub_metering_3

## Opening the PNG device
png()
png("plot3.png", width = 480, height = 480)

## Plot the graphs and annotations
plot(dt, y1, type="l", xlab="", ylab="Energy Sub metering", axes=TRUE)
lines(dt, y2, col="red")
lines(dt, y3, col="blue")
legend(x="topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty="solid")

## Closing the device
dev.off()

#restore language
Sys.setlocale("LC_TIME", user_lang)