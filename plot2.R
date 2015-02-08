#store langugage settings
user_lang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

## read in data
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
selection <- subset(data, (as.Date(data$Date, "%d/%m/%Y") == (as.Date("2007-02-01", "%Y-%m-%d")) | (as.Date(data$Date, "%d/%m/%Y") == (as.Date("2007-02-02", "%Y-%m-%d")))))
y_axis <- as.numeric(selection$Global_active_power)/500
x_axis <- as.numeric(selection$Time)

## create the PNG image
png()
png("plot2.png", width = 480, height = 480)
plot(y_axis, type="n", xlab="", ylab="Global Active Power (kilowatts)", xaxt="n")
lines(y_axis)
axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri", "Sat"))
axis(2, at=c(0,2,4,6), labels=c("0", "2", "4", "6"))
dev.off()

#restore language
Sys.setlocale("LC_TIME", user_lang)