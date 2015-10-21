# Getting and Cleaning Data Course Project
# 1.Merges the training and the test sets to create one data set.
setwd("~/Documents/Getting-and-Cleaning-Data/Course Project/UCI HAR Dataset/train")
trainData <- read.table("X_train.txt")
dim(trainData)
# 7352  561
trainLabel <- read.table("y_train.txt")
table(trainLabel)
# 1    2    3    4    5    6 
# 1226 1073  986 1286 1374 1407
trainSubject <- read.table("subject_train.txt")

setwd("~/Documents/Getting-and-Cleaning-Data/Course Project/UCI HAR Dataset/test")
testData <- read.table("X_test.txt")
dim(testData)
# 2947  561
testLabel <- read.table("y_test.txt") 
table(testLabel)
# 1   2   3   4   5   6 
# 496 471 420 491 532 537
testSubject <- read.table("subject_test.txt")
joinData <- rbind(trainData, testData)
dim(joinData)
# 10299   561
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) 
# 10299   1
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) 
# 10299   1

# 2.Extracts only the measurements on the mean and standard deviation for each 
# measurement.
setwd("~/Documents/Getting-and-Cleaning-Data/Course Project/UCI HAR Dataset")
features <- read.table("features.txt")
dim(features)  
# 561   2
meanStdIndices <- grep("mean\\()|std\\()", features[, 2],value = FALSE)
length(meanStdIndices)
# 66
joinData <- joinData[ ,meanStdIndices]
dim(joinData)
# 10299    66
# remove ()
names(joinData) <- gsub("\\()","",features[meanStdIndices ,2])
# Capitalize M
names(joinData) <- gsub("m","M",names(joinData))
# Capitalize S
names(joinData) <- gsub("s","S",names(joinData))
# Remove "-"
names(joinData) <- gsub("-","",names(joinData))

# 3.Uses descriptive activity names to name the activities in the data set.
activity <- read.table("activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
# walkingUpstairs
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
# walkingDownstairs
activityLabel <- activity[joinLabel[, 1], 2]
str(activityLabel)
# chr [1:10299] "standing" "standing" "standing" "standing" "standing"  ...
joinLabel[ ,1] <- activityLabel
names(joinLabel) <- "activity"

# 4.Appropriately labels the data set with descriptive variable names.
names(joinSubject) <- "subject"
data1 <- cbind(joinSubject, joinLabel, joinData)
dim(data1)
# 10299    68
write.table(data1, "data1.txt")

# 5.From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
library(dplyr)
tbl_df(data1)
# Get the long string as the argument for summarize function
getmean_by_subject_activity <- function(col_num) {
                result <- ""
                for (i in 3:col_num) {
                row_name <- colnames(data1)[i]
                str <- paste(row_name,"= mean(",row_name,",na.rm =TRUE)")
                result <- paste(result,str,sep = ",")
                i <- i+1
                }
                result <- substring(result,2)
                return(result)
}

getmean_by_subject_activity(68)

# Delete "" after copy the result of getmean_by_subject_activity(68)
dataMean <- data1 %>% group_by(subject,activity) %>%
                      summarise(tBodyAccMeanX = mean( tBodyAccMeanX ,na.rm =TRUE),
                                tBodyAccMeanY = mean( tBodyAccMeanY ,na.rm =TRUE),
                                tBodyAccMeanZ = mean( tBodyAccMeanZ ,na.rm =TRUE),
                                tBodyAccStdX = mean( tBodyAccStdX ,na.rm =TRUE),
                                tBodyAccStdY = mean( tBodyAccStdY ,na.rm =TRUE),
                                tBodyAccStdZ = mean( tBodyAccStdZ ,na.rm =TRUE),
                                tGravityAccMeanX = mean( tGravityAccMeanX ,na.rm =TRUE),
                                tGravityAccMeanY = mean( tGravityAccMeanY ,na.rm =TRUE),
                                tGravityAccMeanZ = mean( tGravityAccMeanZ ,na.rm =TRUE),
                                tGravityAccStdX = mean( tGravityAccStdX ,na.rm =TRUE),
                                tGravityAccStdY = mean( tGravityAccStdY ,na.rm =TRUE),
                                tGravityAccStdZ = mean( tGravityAccStdZ ,na.rm =TRUE),
                                tBodyAccJerkMeanX = mean( tBodyAccJerkMeanX ,na.rm =TRUE),
                                tBodyAccJerkMeanY = mean( tBodyAccJerkMeanY ,na.rm =TRUE),
                                tBodyAccJerkMeanZ = mean( tBodyAccJerkMeanZ ,na.rm =TRUE),
                                tBodyAccJerkStdX = mean( tBodyAccJerkStdX ,na.rm =TRUE),
                                tBodyAccJerkStdY = mean( tBodyAccJerkStdY ,na.rm =TRUE),
                                tBodyAccJerkStdZ = mean( tBodyAccJerkStdZ ,na.rm =TRUE),
                                tBodyGyroMeanX = mean( tBodyGyroMeanX ,na.rm =TRUE),
                                tBodyGyroMeanY = mean( tBodyGyroMeanY ,na.rm =TRUE),
                                tBodyGyroMeanZ = mean( tBodyGyroMeanZ ,na.rm =TRUE),
                                tBodyGyroStdX = mean( tBodyGyroStdX ,na.rm =TRUE),
                                tBodyGyroStdY = mean( tBodyGyroStdY ,na.rm =TRUE),
                                tBodyGyroStdZ = mean( tBodyGyroStdZ ,na.rm =TRUE),
                                tBodyGyroJerkMeanX = mean( tBodyGyroJerkMeanX ,na.rm =TRUE),
                                tBodyGyroJerkMeanY = mean( tBodyGyroJerkMeanY ,na.rm =TRUE),
                                tBodyGyroJerkMeanZ = mean( tBodyGyroJerkMeanZ ,na.rm =TRUE),
                                tBodyGyroJerkStdX = mean( tBodyGyroJerkStdX ,na.rm =TRUE),
                                tBodyGyroJerkStdY = mean( tBodyGyroJerkStdY ,na.rm =TRUE),
                                tBodyGyroJerkStdZ = mean( tBodyGyroJerkStdZ ,na.rm =TRUE),
                                tBodyAccMagMean = mean( tBodyAccMagMean ,na.rm =TRUE),
                                tBodyAccMagStd = mean( tBodyAccMagStd ,na.rm =TRUE),
                                tGravityAccMagMean = mean( tGravityAccMagMean ,na.rm =TRUE),
                                tGravityAccMagStd = mean( tGravityAccMagStd ,na.rm =TRUE),
                                tBodyAccJerkMagMean = mean( tBodyAccJerkMagMean ,na.rm =TRUE),
                                tBodyAccJerkMagStd = mean( tBodyAccJerkMagStd ,na.rm =TRUE),
                                tBodyGyroMagMean = mean( tBodyGyroMagMean ,na.rm =TRUE),
                                tBodyGyroMagStd = mean( tBodyGyroMagStd ,na.rm =TRUE),
                                tBodyGyroJerkMagMean = mean( tBodyGyroJerkMagMean ,na.rm =TRUE),
                                tBodyGyroJerkMagStd = mean( tBodyGyroJerkMagStd ,na.rm =TRUE),
                                fBodyAccMeanX = mean( fBodyAccMeanX ,na.rm =TRUE),
                                fBodyAccMeanY = mean( fBodyAccMeanY ,na.rm =TRUE),
                                fBodyAccMeanZ = mean( fBodyAccMeanZ ,na.rm =TRUE),
                                fBodyAccStdX = mean( fBodyAccStdX ,na.rm =TRUE),
                                fBodyAccStdY = mean( fBodyAccStdY ,na.rm =TRUE),
                                fBodyAccStdZ = mean( fBodyAccStdZ ,na.rm =TRUE),
                                fBodyAccJerkMeanX = mean( fBodyAccJerkMeanX ,na.rm =TRUE),
                                fBodyAccJerkMeanY = mean( fBodyAccJerkMeanY ,na.rm =TRUE),
                                fBodyAccJerkMeanZ = mean( fBodyAccJerkMeanZ ,na.rm =TRUE),
                                fBodyAccJerkStdX = mean( fBodyAccJerkStdX ,na.rm =TRUE),
                                fBodyAccJerkStdY = mean( fBodyAccJerkStdY ,na.rm =TRUE),
                                fBodyAccJerkStdZ = mean( fBodyAccJerkStdZ ,na.rm =TRUE),
                                fBodyGyroMeanX = mean( fBodyGyroMeanX ,na.rm =TRUE),
                                fBodyGyroMeanY = mean( fBodyGyroMeanY ,na.rm =TRUE),
                                fBodyGyroMeanZ = mean( fBodyGyroMeanZ ,na.rm =TRUE),
                                fBodyGyroStdX = mean( fBodyGyroStdX ,na.rm =TRUE),
                                fBodyGyroStdY = mean( fBodyGyroStdY ,na.rm =TRUE),
                                fBodyGyroStdZ = mean( fBodyGyroStdZ ,na.rm =TRUE),
                                fBodyAccMagMean = mean( fBodyAccMagMean ,na.rm =TRUE),
                                fBodyAccMagStd = mean( fBodyAccMagStd ,na.rm =TRUE),
                                fBodyBodyAccJerkMagMean = mean( fBodyBodyAccJerkMagMean ,na.rm =TRUE),
                                fBodyBodyAccJerkMagStd = mean( fBodyBodyAccJerkMagStd ,na.rm =TRUE),
                                fBodyBodyGyroMagMean = mean( fBodyBodyGyroMagMean ,na.rm =TRUE),
                                fBodyBodyGyroMagStd = mean( fBodyBodyGyroMagStd ,na.rm =TRUE),
                                fBodyBodyGyroJerkMagMean = mean( fBodyBodyGyroJerkMagMean ,na.rm =TRUE),
                                fBodyBodyGyroJerkMagStd = mean( fBodyBodyGyroJerkMagStd ,na.rm =TRUE))
dim(dataMean)
# 180 60
write.table(dataMean,"dataMean.txt",row.name=FALSE)