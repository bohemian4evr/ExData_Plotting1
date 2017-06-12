#1
#Reading the data in a file
plotData <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
plotData$Date<- as.Date(df1$Date,"%d/%m/%Y")

#extracting data with the required dates
df2<-df1[df1$Date=="2007-02-01"|df1$Date=="2007-02-02",]

#creating the png file and the plot1
png("plot1.png",width = 480, height = 480)
hist(df2$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.off()

#2
#Merging two rows to create a timestamp
SetTime<- as.POSIXlt(paste(df1$Date,df1$Time,sep=" "))
df1<- cbind(df1,SetTime)

#Creating the png file for plot2
dev.cur()
png("plot2.png",width = 480, height = 480)
with(df1,plot(df1$SetTime,df1$Global_active_power,type="l",main= "Global active power",xlab="Global Active Power",ylab="Time"))
dev.off()

#3

png("plot3.png",width = 480, height = 480)
with(df2,plot(SetTime,Sub_metering_1,col="black",type="l",ylab="Energy Sub metering",xlab=""))
lines(SetTime,df2$Sub_metering_2,type="l",pch=2,col="red")
lines(SetTime,df2$Sub_metering_3,type="l",pch=2,col="blue")

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))

dev.off()

#4

png("plot4.png",width = 480, height = 480)
#creating 2*2 matrix for the graphs
old.par <- par(mfrow=c(2, 2))
#plot1
with(df2,plot(SetTime,Global_active_power,type="l",main= "Global active power",ylab="Global Active Power",xlab=""))
#plot2
with(df2,plot(SetTime,Voltage,type="l",ylab="Voltage",xlab="datetime",main=""))
#plot3
with(df2,plot(SetTime,Sub_metering_1,col="black",type="l",ylab="Energy Sub metering",xlab=""))
lines(SetTime,df2$Sub_metering_2,type="l",pch=2,col="red")
lines(SetTime,df2$Sub_metering_3,type="l",pch=2,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
#plot4
with(df2,plot(SetTime,Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime",main=""))
dev.off()
