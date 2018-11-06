##download zip file

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","pc.zip")

##extract zip file
unzip("pc.zip")

##load the extracted file into R
pc<-read.table("household_power_consumption.txt",sep = ";",na.strings = "?",header = T)

##converting the dates and time to dates and time format
library(lubridate)
library(dplyr)
pc$Date<- dmy(pc$Date)
pc$Time<-hms(pc$Time)

##subseting the relevant dates
subpc<- pc[pc$Date=="2007-02-01" | pc$Date=="2007-02-02" ,]

##adding a column with date and time format
subpc<- mutate(subpc,DT=ymd_hms(paste(Date,Time)))

##creating png file device
png("plot3.png",width=480,height=480)

##creating line plot

##*****in the plot the days that should be in english are in Hebrew because my computre settings...****
##***please take into considaration while reviwing the plot....thanks****
plot(subpc$DT,subpc$Sub_metering_1,type = "l",xlab = "",ylab="Energy Sub metering")
lines(subpc$DT,subpc$Sub_metering_2,col="red")
lines(subpc$DT,subpc$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = 1)
##clossing the plot device
dev.off()
