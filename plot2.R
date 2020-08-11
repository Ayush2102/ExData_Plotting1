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
plot(data$Time, data$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

# Save the graph
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()