# PLOT SCRIPT FOR PLOT 4

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
png("plot4.png",width=480,height=480)

## Define the device object as a 2x2 grid to display multiple charts
par(mfcol=c(2,2))

## Plot 2 Create the histogram chart (top left corner)
plot(DF$Global_active_power,type="l",ylab="Global Active Power",xlab=NA, xaxt = "n",cex.lab=0.95,cex.main=0.95,cex.axis=0.95)
## Add the x axis labels for the day of the week.
axis(side = 1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat"))

## Plot 3 Create the plot chart (bottom right corner)
plot(DF$Sub_metering_1,type="l",ylab="Energy sub metering",xlab=NA, xaxt = "n",col="black",cex.lab=0.95,cex.main=0.95,cex.axis=0.95)
## Add second line to chart
lines(DF$Sub_metering_2,col="red")
## Add third line to chart
lines(DF$Sub_metering_3,col="blue")
## Add legend to chart with colored lines
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,col=c("black","red","blue"),bty="n",cex=0.9)
## Add the x axis labels for the day of the week.
axis(side = 1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat"))

## Plot 5 Create the plot chart
plot(DF$Voltage,type="l",ylab="Voltage",xlab="datetime", xaxt = "n",yaxt="n",col="black",cex.lab=0.95,cex.main=0.95,cex.axis=0.95)
## Add the y axis labels
axis(side=2,at=c(234,236,238,240,242,244,246),labels=c("234","","238","","242","","246"))
## Add the x axis labels for the day of the week.
axis(side = 1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat"))

## Plot 6 Create the chart
plot(DF$Global_reactive_power,type="l",ylab="Global_reactive_powere",xlab="datetime", xaxt = "n",col="black",cex.lab=0.95,cex.main=0.95,cex.axis=0.95)
## Add the x axis labels for the day of the week.
axis(side = 1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat"))

## Close the device file
dev.off()