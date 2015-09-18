#week 2 quiz
#Question 1
install.packages("httr")
library(httr)
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")
# 2. To make your own application, register at at
#    https://github.com/settings/applications. 
#    Developer applications > register an application
#    Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#    Replace your key and secret below.
myapp <- oauth_app("getting_and_cleaning_data",
                   key = "your key",
                   secret = "your secret")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
output <- content(req)
#looping through output, and find the crated time for datasharing repo
for (i in 1:length(output)) {	
	if (output[[i]]$name == "datasharing")
           return(output[[i]]$created_at)
}
#---[1] "2013-11-07T13:25:07Z"

#Question 2
install.packages("sqldf")
#Loading required package: gsubfn,proto,DBI,RSQLite
install.packages("gsubfn")
install.packages("proto")
install.packages("DBI")
install.packages("RSQLite")
library(gsubfn)
library(proto)
library(DBI)
library(RSQLite)
library(sqldf)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,destfile="Documents/GC_Data/week2/survey.csv",method="curl")
dateDownloaded <- date()
dateDownloaded
acs <- read.csv("survey.csv")
head(acs$pwgtp1)
#---sqldf("select pwgtp1 from acs where AGEP < 50")

#Question 3
#Using the same data frame you created in the previous problem, 
#what is the equivalent function to unique(acs$AGEP)
#---sqldf("select distinct AGEP from acs")

#Question 4
#How many characters are in the 10th, 20th, 30th and 100th lines of HTML 
#from this page:http://biostat.jhsph.edu/~jleek/contact.html 
htmlUrl <- "http://biostat.jhsph.edu/~jleek/contact.html"
# connnection
con<- url(htmlUrl)
htmlCode <- readLines(con,n=c)
close(con)
head(htmlCode)
sapply(htmlCode[c(10,20,30,100)], nchar)
#---45 31 7 25

#Question 5
#Read a table of fixed width formatted data into a data.frame.
#widths arg:c(1,2,3)---> a aa aaa
q5 <- read.fwf("Documents/GC_Data/week2/getdata-wksst8110.for",
               widths = c(12,7,4,9,4,9,4,9,4),
               skip = 4)
sum(q5[,4])
#---32426.7
