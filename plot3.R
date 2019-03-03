#Link for the data
url<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"

#Download and unzip the data
library(downloader)
f<-file.path(getwd(),"dataset.zip")
download(url,dest=f,mode="wb")
path_unzip<-file.path(getwd(),"dt")
unzip(f,exdir=path_unzip)
file.remove("dataset.zip")

#list unzipped files
filest<-list.files(path=path_unzip,recursive = TRUE)


#Read files for analysis
library(data.table)
powerdt<-(read.table(file.path(path_unzip,filest[1]),header=TRUE,sep=";",dec=".",stringsAsFactors = FALSE))
#subset the file
powerdt<-powerdt[powerdt$Date %in% c("1/2/2007","2/2/2007"), ]

#reformat the data
datetime <- strptime(paste(powerdt$Date, powerdt$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(powerdt$Global_active_power)
subMetering1 <- as.numeric(powerdt$Sub_metering_1)
subMetering2 <- as.numeric(powerdt$Sub_metering_2)
subMetering3<-powerdt$Sub_metering_3

#plot png for the datetime and submeterings
png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

