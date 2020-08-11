# Load Libraries and data
library(lubridate)
library(dplyr)
library(data.table)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")
data <- as_tibble(fread(file.path(path, "household_power_consumption.txt"), na.strings = "?"))

# Data preprocessing
data <- data %>%
        mutate(Date = dmy(Date)) %>%
        mutate(Time = paste(Date, Time)) %>%
        mutate(Time = strptime(Time, "%Y-%m-%d %H:%M:%S")) %>%
        filter(Date >= "2007-02-01" & Date < "2007-02-03")

# Plotting the graph
par(mfrow = c(2,2))
with(data, {
        plot(Time, Global_active_power, type = "l", 
             xlab = "", ylab = "Global Active Power")
        plot(Time, Voltage, type = "l",
             xlab = "datetime", ylab = "Voltage")
        points(Time, Sub_metering_3, type = "l", col = "blue")
})
with(data, {
        plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        points(Time, Sub_metering_2, type = "l", col = "red")
        points(Time, Sub_metering_3, type = "l", col = "blue")
        legend("topright", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               lwd = 2, lty = c(1, 1, 1))
})
with(data, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))

# Save the graph
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()