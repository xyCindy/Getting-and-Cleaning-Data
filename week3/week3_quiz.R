#week 3 quiz
#Question 1
getwd()
# download American Community Survey 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./survey3.csv", method="curl")
dateDownloaded <- date()
dateDownloaded
survey3 <- read.csv("survey3.csv")
# ACR 3.House on ten or more acres
# AGS 6.$10000+
agricultureLogical <- (survey3$ACR == 3) & (survey3$AGS == 6)
which(agricultureLogical)
#  [1]  125  238  262  470  555

#Question 2
fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile="./jeff.jpg", method="curl")
install.packages("jpeg")
library(jpeg)
img <- readJPEG("jeff.jpg",native = TRUE)
quantile(img,probs=c(0.3,0.8))
#  30%       80% 
#-15259150 -10575416 

#Question 3
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1, destfile="./productData.csv", method="curl")
download.file(fileUrl2, destfile="./educationData.csv", method="curl")

# We need to first do some data wrangling of product dataset,select only 
# 1st, 4th and 5th columns
product <-read.csv("productData.csv",header=F,skip = 5,nrows = 190)[ ,c(1,2,4,5)]
education <-read.csv("educationData.csv")
head(product,2)
head(education,2)

# Merge two datasets by CountryCode, all=FALSE only returns matched rows
mergedData <- merge(product,education,by.x="V1",by.y="CountryCode",all=FALSE)
# Because V1 has been merged, we need to look at V2 to see how many unique value are
sum(!is.na(unique(mergedData$V1)))
#[1] 189

#Sort the margedData
install.packages("dplyr")
library(dplyr)
sort_mergedData <- arrange(mergedData,desc(V2))
sort_mergedData[ ,"Long.Name"][13]
# [1] St. Kitts and Nevis
# 189 matches, 13th country is St. Kitts and Nevis

# Question 4
mergedData %>% group_by(Income.Group) %>% summarize(avg_ranking = mean(V2))
#          Income.Group avg_ranking
#               (fctr)     (dbl)
#1 High income: nonOECD  91.91304
#2    High income: OECD  32.96667
#3           Low income 133.72973
#4  Lower middle income 107.70370
#5  Upper middle income  92.13333

# Question 5
mergedData$rankGroup <- cut(mergedData$V2, breaks = 5)
table(mergedData$rankGroup,mergedData$Income.Group)
# 5