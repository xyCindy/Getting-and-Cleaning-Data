# Getting and Cleaning Data Course Project 


This file describes how run_analysis.R script works.

* First, download the data from   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20  
and unzip it; Put it at the same directory as "run_analysis.R".  

* Second,use 

```r
source("run_analysis.R")
```
command in RStudio.

The run_analysis.R script performs the following steps to clean the data:  

1. Read X_train.txt, y_train.txt and subject_train.txt from the "./train" folder 
and store them in trainData, trainLabel and trainSubject variables respectively.

2. Read X_test.txt, y_test.txt and subject_test.txt from the "./test" folder and 
store them in testData, testLabel and testsubject variables respectively.  

3. Concatenate testData to trainData to generate a 10299x561 data frame, joinData;   concatenate testLabel to trainLabel to generate a 10299x1 data frame, joinLabel; 
concatenate testSubject to trainSubject to generate a 10299x1 data frame, 
joinSubject.  

4. Read the features.txt file from the "./UCI HAR Dataseta" folder and store the 
data in a variable called features. We only extract the measurements on the mean and standard deviation.   

5. This results in a 66 indices list. We get a subset of joinData with the 66 corresponding columns.  

6.Clean the column names of the subset. We remove the "()" and "-" symbols in the 
names,as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.  

7.Read the activity_labels.txt file from the "./UCI HAR Dataset"" folder and store 
the data in a variable called activity.  

8. Clean the activity names in the second column of activity. We first make all names 
to lower cases. If the name has an underscore between letters, we remove the 
underscore and capitalize the letter immediately after the underscore.  

9. Transform the values of joinLabel according to the activity data frame.  

10. Combine the joinSubject, joinLabel and joinData by column to get a new cleaned
10299x68 data frame, data1. Properly name the first two columns, "subject" and 
"activity". The "subject" column contains integers that range from 1 to 30 
inclusive; the "activity" column contains 6 kinds of activity names; the last 
66 columns contain measurements that range from -1 to 1 exclusive.  

11. Write the data1 out to "data1txt" file in current working directory.  

12. Finally, generate a second independent tidy data set with the average of each 
measurement for each activity and each subject. We have 30 unique subjects and 
6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding 
combination.   

13. Here, I use dplyr packages which provides many convenient functions to manipulate
dataset.I mainly used group_by and summarise function. In order to get all the arguments 
for the 66 features, I wrote a funtion called "getmean_by_subject_activity" to generate
a long string.  

14. In order to use this string as arugment of summerise function, I copied, pasted
it in summarise funciton and delete the double quotes.("")  

15. After performing the pipes, we get a 180x68 data frame called dataMean.  

16. Finally, write the result out to "dataMean.txt" file in current working directory.  


* Third, you will find two output files are generated in the current working directory:

     + data1:data1.txt (8.3 Mb): it contains a data frame called data1 with    
                                10299*68 dimension.  
                                
     + dataMean.txt (225 Kb): it contains a data frame called dataMean with 
                            180*68 dimension.  
                            
* Finally, use

```r
dataMean <- read.table("dataMean.txt") 
```
command in RStudio to read the file.   
Since activity has 6 unique values and subject has 30 unique values, we have 180
rows with all combinations for each of the 66 features.
                            
