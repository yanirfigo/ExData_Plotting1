##download zip file

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","pc.zip")

##extract zip file
unzip("pc.zip")

##load the extracted file into R
pc<-read.table("household_power_consumption.txt",sep = ";",na.strings = "?",header = T)

##converting the dates to dates format
library(lubridate)
library(dplyr)
pc$Date<- dmy(pc$Date)

##subseting the relevant dates
subpc<- pc[pc$Date=="2007-02-01" | pc$Date=="2007-02-02" ,]

##creating png file device
png("plot1.png",width=480,height=480)

##creating the histogram
hist(subpc$Global_active_power,col = "red",xlab = "Global Active Power(Killowatts)",main = "Global Active Power")

##clossing the plot device
dev.off()
