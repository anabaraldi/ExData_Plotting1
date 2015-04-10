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
png("plot2.png", bg = "transparent")
with(data, plot(Date, Global_active_power, 
                type = "l",
                ylab = "Global Active Power (kilowatts)",
                xlab = NULL))
dev.off()