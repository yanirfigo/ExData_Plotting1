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
png("plot4.png",width=480,height=480)

##creating 2 rows and 2 cloumns for inorder to show 4 plots together
par(mfrow=c(2,2))

##topleft plot
plot(subpc$DT,subpc$Global_active_power,type = "l",xlab = "",ylab="Global Active Power(Killowatts)")

##topright plot
plot(subpc$DT,subpc$Voltage,type = "l",xlab = "datetime",ylab="Voltage")

##bottomleft plot
plot(subpc$DT,subpc$Sub_metering_1,type = "l",xlab = "",ylab="Energy Sub metering")
lines(subpc$DT,subpc$Sub_metering_2,col="red")
lines(subpc$DT,subpc$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = 1)

##bottomright plot
plot(subpc$DT,subpc$Global_reactive_power,type = "l",xlab = "datetime",ylab="Global Active Power(Killowatts)")
##clossing the plot device
dev.off()
