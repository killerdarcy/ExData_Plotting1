### plot3.R ###

tmp.file = tempfile()

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              tmp.file, method = "curl")

ECP.file <- read.table(unz(tmp.file, "household_power_consumption.txt"), sep = ";", quote = "", header = TRUE,
                       stringsAsFactor = FALSE, na.string = "?")
unlink(tmp.file)

ECP.file <- within(ECP.file, date.time <- strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

ECP.file.sub <- with(ECP.file, subset(ECP.file, date.time >= as.POSIXct('2007-02-01 00:00:00') 
                                      & date.time < as.POSIXct('2007-02-03 00:00:00')))
rm(ECP.file)

png('plot3.png', width = 480, height = 480, units = "px")

with(ECP.file.sub, plot(date.time, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l", col = "black"))
with(ECP.file.sub, lines(date.time, Sub_metering_2, col = "red"))
with(ECP.file.sub, lines(date.time, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()