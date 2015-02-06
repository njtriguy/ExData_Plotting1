
## Load Needed Library
library("timeDate")

## Define Source Data File Parameters
sourcefilename<-"exdata-data-household_power_consumption.zip"
sourcefileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


## Download the data archive if it doesn't exist and unzip it.  
if (!file.exists(sourcefilename)) {
  download.file(sourcefileurl,sourcefilename,mode="wb")  # If file doesn't exist download the source file as a binary
  unzip(sourcefilename,overwrite=TRUE)                   # Unzip the downloaded file and overwrite the existing folder and files
}

## Read the data file into data frame
DF<-read.table("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors=FALSE,colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?")

## Add a column that creates and timeDate column data type.
DF$DateTime<-strptimeDate(paste(DF$Date,DF$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")

DF<-subset(DF,DateTime >= timeDate("2007-02-01 00:00:00",format="%Y-%m-%d %H:%M:%S") & DateTime <= timeDate("2007-02-02 24:00:00",format="%Y-%m-%d %H:%M:%S"))

## Open the png device, name the image file and size for output
png("plot2.png",width=480,height=480)

## Create the histogram chart
plot(DF$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=NA, xaxt = "n")
## Add the x axis labels for the day of the week.
axis(side = 1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat"))

## Close the device file
dev.off()