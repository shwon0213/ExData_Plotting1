##############################################
## Exploratory Data Analysis
## Course Project 1 - Plot 4
#############################################

setwd("/Users/seunghyunwon/Documents/Coursera_Exp_Analysis/ExData_plotting1")

########################################### 
## Part 1: Loading the data
###########################################

downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
File <- "./household_power_consumption.zip"
DataFile <- "./household_power_consumption.txt"
if (!file.exists(DataFile)) {
        download.file(downloadURL, File, method = "curl")
        unzip(File, overwrite = T, exdir = "./ExData_Plotting1")
}

data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
                   header = TRUE)
dim(data) # Check the number of rows and columns 

# Subsetting - only select data from the dates 2007-02-01 and 2007-02-02
data$Date <- as.Date(data$Date, "%d/%m/%Y")
subdata <- subset(data, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))

# Get rid of missing values 
subdata <- subdata[complete.cases(subdata),]

# Combine Date and Time to set the X-axis
DateTime <- paste(subdata$Date, subdata$Time)
DateTime <- setNames(DateTime, "DateTime")
subdata  <- cbind(DateTime, subdata)
subdata$DateTime <- as.POSIXct(DateTime)

########################################### 
## Part 2: Draw Plot 4
###########################################

# Draw a 2 by 2 panel plot 
png("plot4.png",  width = 480, height = 480, units = "px")

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subdata, {
        # the top-left panel
        plot(Global_active_power ~ DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        # the top-right panel
        plot(Voltage ~ DateTime, type="l", 
             ylab="Voltage", xlab="datetime") 
        # the bottom-left panel
        plot(Sub_metering_1 ~ DateTime, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2 ~ DateTime,col='Red')
        lines(Sub_metering_3 ~ DateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"),  lty =1,
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        # the bottom-right panel
        plot(Global_reactive_power ~ DateTime, type="l", 
             ylab="Global_reactive_power",xlab="datetime")
        }
) 
dev.off()

### END 