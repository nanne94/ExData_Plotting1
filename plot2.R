## the file from which we read should be in the directory set as
## the working directory
data <- read.table("household_power_consumption.txt",
                   header=T,
                   sep=";",
                   na.strings="?",
                   nrows=2075259,
                   colClasses = c("character", "character", "numeric",
                                  "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"))

## The date and time information must be converted in a standard fomat
## to enable us to make the subset
data$datetime <- paste(data$Date, data$Time, sep = " ")
data$datetime <- strptime(data$datetime, "%d/%m/%Y %H:%M:%S")
start <- as.POSIXct("2007-02-01 00:00:00")
end <- as.POSIXct("2007-02-03 00:00:00")
data <- data[data$datetime >= start & data$datetime < end,]

## You may need to change your local parameters so that
## the names of the day appear in english
locale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")

png(file = "plot2.png", bg ="transparent")
plot(data$datetime, data$Global_active_power,
       type ="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

## you restore your previous local parameters as regards the date
Sys.setlocale("LC_TIME", locale)