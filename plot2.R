##############################################
## Exploratory Data Analysis
## Course Project 1 - Plot 2
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
## Part 2: Draw Plot 2
###########################################

# Draw a line plot 

plot(subdata$Global_active_power ~ subdata$DateTime, type = "l",
     ylab="Global Active Power (kilowatts)", xlab="")

# Save the plot to a PNG file with a width of 480 pixels and a height of 480 pixels.  

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

### END 