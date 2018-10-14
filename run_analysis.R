## The goal is to prepare tidy data that can be used for later analysis.
##
## Data for this assignment was downloaded from following url on 12-OCt-2018
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## For the purpose of this assignment, files were unzippped to the working dir.
##
##

library(data.table)
library(plyr)
library(dplyr)


## First read data into tables
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

## Get column names
features        <- read.table("./UCI HAR Dataset/features.txt")[,2]
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")


## 1. Merges the training and the test sets to create one data set.
subject_all <- rbind(subject_test, subject_train)
x_all <- rbind(x_test, x_train)
y_all <- rbind(y_test, y_train)

## Add column names
names(subject_all) <- 'subjectid'
names(x_all) <- features
names(y_all) <- 'activityid' 
names(activity_labels) <- c('activityid','activity') 

hcr_dt <- cbind(subject_all, y_all, x_all)


## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement.

col_literal <- paste(names(subject_all), names(y_all),"mean","std",sep = "|")
extract_cols <- grepl(col_literal, names(hcr_dt))
extract_measurements <- hcr_dt[,extract_cols]


## 3. Uses descriptive activity names to name the activities in the data set

extract_measurements$activityid <-
    mapvalues(extract_measurements$activityid, activity_labels$activityid, activity_labels$activity)

## Must col name activitID since it's no longer contain ID
names(extract_measurements)[names(extract_measurements) == "activityid"] <- "activity"


## 4. Appropriately labels the data set with descriptive variable names.

col_names <- names(extract_measurements)

## Remove ()
col_names <- gsub("[\\(\\)]", "", col_names)

## Remove duplicate "Body"
col_names <- gsub("BodyBody", "Body", col_names)

## Update the column names
names(extract_measurements) <- col_names


## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.

hcrmean <- extract_measurements %>% 
    group_by(subjectid, activity) %>%
    summarise_all(.funs = c(mean="mean"))








