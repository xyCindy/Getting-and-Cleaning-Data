# Week 4 Quiz
# Question 1
survey4 <- read.csv("survey4.csv")
names(survey4)[123]
strsplit("wgtp15","\\wgtp")
# ---[1] ""   "15"

# Question 2
product <-read.csv("productData.csv",header=F,skip = 5,nrows = 190)[ ,c(1,2,4,5)]
str(product)
new_millions <-gsub(",","",product$V5)
mean(as.numeric(new_millions))
# ---[1] 377652.4

# Question 3
summary(grepl("^United",as.character(product$V4)))
# ---3

# Question 4
product <-read.csv("productData.csv",header=F,skip = 5,nrows = 190)[ ,c(1,2,4,5)]
education <-read.csv("educationData.csv")
mergedData <- merge(product,education,by.x="V1",by.y="CountryCode",all=FALSE)
fiscalYearEndJune <- grepl("fiscal year end(.*)june", 
                           tolower(mergedData$Special.Notes))
summary(fiscalYearEndJune)
# ---13

# Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
amzn$year <- format(sampleTimes,"%Y")
table(amzn$year)
#---2012 : 250
amzn$weekday <- format(sampleTimes,"%Y %a")
head(amzn$weekday)
summary(grepl("2012 Mon",amzn$weekday))
# --- 47