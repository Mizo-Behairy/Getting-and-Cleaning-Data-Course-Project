# Importing the required libraries

library(data.table)

library(dplyr)

library(knitr)

# Getting the current working directory

initWorkDir <- getwd()

# Initiating new working directories

parentWorkDir <- "Getting and Cleaning Data Course Project"

dataWorkDir <- paste(parentWorkDir, "data", sep = "/")

# Checking if the new directory exists, if not create it

if(!file.exists(parentWorkDir)){

    dir.create(dataWorkDir, recursive = TRUE)

    }

# Set the newely created directory as the session working directory for ease of coding

setwd(dataWorkDir)

# URL for the required data sets file

dataSetsURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Downloading the data sets file

download.file(url = dataSetsURL, destfile = "datasets.zip")

# Unzipping the downloaded data sets file

unzip(zipfile = "datasets.zip", overwrite = TRUE)

# Getting all the data sets files directories

files <- list.files("UCI HAR Dataset", recursive=TRUE)

# Importing all the required data sets

dataFeaturesNames <- read.table(file = "UCI HAR Dataset/features.txt",header = FALSE)

activityLabels    <- read.table(file = "UCI HAR Dataset/activity_labels.txt",header = FALSE)

dataActivityTest  <- read.table(file = "UCI HAR Dataset/test/y_test.txt",header = FALSE)
dataActivityTrain <- read.table(file = "UCI HAR Dataset/train/y_train.txt",header = FALSE)

dataSubjectTest   <- read.table(file = "UCI HAR Dataset/test/subject_test.txt",header = FALSE)
dataSubjectTrain  <- read.table(file = "UCI HAR Dataset/train/subject_train.txt",header = FALSE)

dataFeaturesTest  <- read.table(file = "UCI HAR Dataset/test/X_test.txt",header = FALSE)
dataFeaturesTrain <- read.table(file = "UCI HAR Dataset/train/X_train.txt",header = FALSE)

# Concatenating all the Subject data tables by rows

dataSubject  <- rbind(dataSubjectTrain, dataSubjectTest)

# Concatenating all the Activity data tables by rows

dataActivity <- rbind(dataActivityTrain, dataActivityTest)

# Concatenating all the Features data tables by rows

dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

# Set names to the Subject data table

names(dataSubject) <-c("subject")

# Set names to the Activity data table

names(dataActivity) <- c("activity")

# Set names to the Features data table as features.txt

names(dataFeatures) <- dataFeaturesNames$V2

# Concatenating all the data tables to create one data set

Data <- cbind(dataFeatures, dataSubject, dataActivity)

# Determinning all the column names with "mean()" or "std()"

meansSTDNames <- grep("mean\\(\\)|std\\(\\)", names(Data), ignore.case = TRUE, value = TRUE)

# Extracting only the columns "mean()" or "std()", "subject" and "activity"

Data <- Data[, c(meansSTDNames, "subject", "activity")]

# Merge the main dataset with activityLabels to get descriptive activity names

Data <- merge(Data, activityLabels, by.x = "activity", by.y = "V1", all = TRUE)

# Dropping activity id column

Data <- Data[, !(names(Data) %in% c("activity"))]

# Renaming the V2 column from activityLabels to be activity

setnames(Data, "V2", "activity")

# Renaming the main dataset column names with descriptive column names

names(Data) <- gsub("^t", "time", names(Data))

names(Data) <- gsub("^f", "frequency", names(Data))

names(Data) <- gsub("Acc", "Accelerometer", names(Data))

names(Data) <- gsub("Gyro", "Gyroscope", names(Data))

names(Data) <- gsub("Mag", "Magnitude", names(Data))

names(Data) <- gsub("BodyBody", "Body", names(Data))

# Creating a second independent tidy data set with the average of each variable for each activity and each subject

Data2 <- aggregate(.~subject + activity, Data, mean)

# Sorting the second independent tidy data set

Data2 <- Data2[order(Data2$subject,Data2$activity),]

# Reindexing the second independent tidy data set

row.names(Data2) <- c(1:nrow(Data2))

# Resetting the working directory

setwd(paste(initWorkDir, parentWorkDir, sep = "/"))

# Exporting the second independent tidy data set

write.table(Data2, file = "tidydataset.txt",row.name=FALSE)