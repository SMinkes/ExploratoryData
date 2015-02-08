data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
selection <- subset(data, (as.Date(data$Date, "%d/%m/%Y") == (as.Date("2007-02-01", "%Y-%m-%d")) | (as.Date(data$Date, "%d/%m/%Y") == (as.Date("2007-02-02", "%Y-%m-%d")))))
png()
plot_data <- as.numeric(selection$Global_active_power)/500
png("plot1.png", width = 480, height = 480)
histogram <- hist(plot_data)
plot(histogram, main = "Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", ylim=c(0,1200), col="Red")
dev.off()