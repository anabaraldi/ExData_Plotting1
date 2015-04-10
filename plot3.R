#libraries
library(dplyr)

# read and get the data
unzip("data/exdata-data-household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

# cleaning data
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
data <- mutate(data, Date = paste(Date, Time, sep="T"))
data$Date <- strptime(data$Date, format = "%d/%m/%YT%T")
data <- data[-2]

# making the plot
png("plot3.png", bg = "transparent")
with(data, plot(Date, Sub_metering_1,
                type = "n",
                ylab = "Energy sub metering",
                xlab = ""))
with(data, lines(Date, Sub_metering_1, col = "black"))
with(data, lines(Date, Sub_metering_2, col = "red"))
with(data, lines(Date, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col= c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()