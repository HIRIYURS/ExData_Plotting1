## Exploratory Data Analsysis Project 1
##
plot3png <- function() {
    require(data.table)
    require(dplyr)
    
    filenamepath <- "./data/exdata-data/household_power_consumption.txt"
    
    ## read the file
    dat <- read.table(filenamepath, sep=";", stringsAsFactors = FALSE, header=TRUE,
                        na.strings = "?")
    clabels <- c("Date", "Time", "GAPower", "GRPower", "Voltage", "GIntensity", 
                 "SubM1", "SubM2", "SubM3")
    
    colnames(dat) <- clabels
    
    dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
    #dat$DateTime <- as.Date(paste(dat$Date, dat$Time), format = "%d/%m/%Y %H:%M:%S")

    #subdat <- filter(dat, DateTime >= as.Date("2007-02-01 00:00:00") && 
    #                 DateTime <= as.Date("2007-02-03 00:00:00"))
    subdat <- dat[dat$Date >= "2007-02-01" & dat$Date <= "2007-02-02",]
    
    subdat$DateTime <- paste(subdat$Date, subdat$Time)
    subdat$DateTime <- strptime(subdat$DateTime, "%Y-%m-%d %H:%M:%S")
    
    na.omit(subdat)
    
    # Plot the graph 
    plot(subdat$DateTime, subdat$SubM1,  type = "l",
         ylab = "Energy sub metering", xlab = "")
    points(subdat$DateTime, subdat$SubM2,  type = "l",
           col="red")
    points(subdat$DateTime, subdat$SubM3,  type = "l",
           col="blue")
    legend("topright", col = c("black","red","blue" ), pch = "-", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

    # Copy to png file
    dev.copy(png, file = "plot3.png")
    
    # Close the device
    dev.off() 
    
    print("comlete")
}
