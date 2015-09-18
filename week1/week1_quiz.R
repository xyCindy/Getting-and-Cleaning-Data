#week 1 quiz
#Question 1
setwd("~/Documents/GC_Data/week1")
getwd()
# download American Community Survey 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./survey.csv", method="curl")
dateDownloaded <- date()
dateDownloaded
survey <- read.csv("survey.csv")
#VAL is the column name of property value; >= 1,000,000 will be 24
nrow(survey[(survey$VAL == 24) & !is.na(survey$VAL), ])
#---53

#Question 2
#---Tidy data has one variable per column.

#Question 3
#Download the Excel spreadsheet on Natural Gas Aquisition Program
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="./gas.xlsx", method="curl")
dateDownloaded <- date()
dateDownloaded
#in order to use xlsx package, we need to install rJava and xlsxjars first
install.packages("rJava")
install.packages("xlsxjars")
library(rJava)
library(xlsxjars)
install.packages("xlsx")
library(xlsx)
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("./gas.xlsx", sheetIndex=1,colIndex=colIndex, 
                 rowIndex=rowIndex,header=TRUE)
sum(dat$Zip*dat$Ext,na.rm=T) 
#---6534720

#Question 4
#Download the XML data on Baltimore restaurants
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
# To fix the error: Error: XML content does not seem to be XML
# We need to remove "s" from "https"
new_fileUrl <- sub("s","",fileUrl)
install.packages("XML")
library(XML)
doc <- xmlTreeParse(new_fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
rootNode
xmlName(rootNode)
names(rootNode)
rootNode[[1]][[1]]
zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
length(zipcode[zipcode == 21231])
#---127

#Question 5
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./survey2.csv", method="curl")
#in order to use fread function, we need to install data.table package
install.packages("data.table")
library(data.table)
DT <- fread("./survey2.csv")
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(rowMeans(DT)[DT$SEX==1])+system.time(rowMeans(DT)[DT$SEX==2]
)