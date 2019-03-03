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
powerdt<-powerdt[powerdt$Date %in% c("1/2/2007","2/2/2007"), ]

#generate plot
png("plot1.png")
GlobalActivePower<-as.numeric(powerdt[,3])
hist(GlobalActivePower,xlab="Global Active Power (kilowatts)",breaks=12,main="Global Active Power",col="red")
dev.off()