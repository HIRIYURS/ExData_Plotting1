## Exploratory Data Analsysis Project 1
##
plot1png <- function() {
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
    
    subdat$GAPower <- (subdat$GAPower)*100

    # Plot the graph (histogram)
    hist(subdat$GAPower, col = "red", main = "Global Active Power", 
         xlab = "Global Active Power (Kilowatts)")

    # Copy to png file
    dev.copy(png, file = "plot1.png")
    
    # Close the device
    dev.off() 
    
    print("comlete")
}