##Read in source csv file
##If memory is of concern, I don't thing grep-ing through the entire file is any better. 
##Therfore, I approximate number of lines skipped for 1/2/2007 and 2/2/2007 data.
##Will filter out exact rows after converting to actual time format
hh <- read.csv("household_power_consumption.txt", nrows = 4000, sep = ";",skip = 66000 ,na.strings = "?")

##Read in header & append to data.frame
hhHeader <- read.csv("household_power_consumption.txt", nrows = 1, sep = ";")
names(hh) <- names(hhHeader)

## format date & Time columns 
as.Date(hh$Date, "%d/%m/%Y") -> hh$Date
as.character(hh$Time) -> hh$Time
strptime(paste(hh$Date,hh$Time), "%Y-%m-%d %H:%M:%S") -> hh$Time

## filter out row that is not within date range. 
subset(hh,Date >= "2007-02-01" & Date <="2007-02-02")->hh

##open graphics device (png file format)
##plot graph
##close graphics device
png(filename = "plot1.png")
hist(hh$Global_active_power,col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()