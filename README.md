# Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

## Getting Started

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 



### Prerequisites

You must download the data file for the project from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 


### Project Goal

You should create one R script called run_analysis.R that does the following:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



### Project Inputs

This project depends on the following data sets from the downloaded zip file:

* ```features.txt```
* ```activity_labels.txt```
* ```test/y_test.txt```
* ```train/y_train.txt``` 
* ```test/subject_test.txt```
* ```train/subject_train.txt```
* ```test/X_test.txt```
* ```train/X_train.txt```



## Project Walkthroughs

The project follows the following steps to achieve the main goal:

* **Step 1 -> Get the Data :**
    * Download the file and put the file in the ```data``` folder
    * Unzip the files then get the list of the files in the ```UCI HAR Dataset``` folder.
    
* **Step 2 -> Read data from the targeted files :**
    * Read all the variables names files: features.txt and activity_labels.txt.
    * Read all the test and training files: test/y_test.txt, train/y_train.txt, test/subject_test.txt, train/subject_train.txt, test/X_test.txt and train/X_train.txt.
    
* **Step 3 -> Merges the training and the test sets to create one data set :**
    * Concatenate the data tables by rows.
    * set names to variables.
    * Merge columns to get the data frame ```Data``` for all data.
    
* **Step 4 -> Extracts only the measurements on the mean and standard deviation for each measurement :**
    * Getting all the columns names with the mean or standard deviation.
    * Subset the data frame ```Data``` by the seleted columns names plus ```subject``` and ```activity``` columns.
    
* **Step 5 -> Using descriptive activity names instead of activity ids :**
    * Merge the dataset ```Data``` with dataset ```activityLabels``` to get descriptive activity names.
    * Drop the original ```activity``` column from the data frame ```Data``` then rename the other from the dataset ```activityLabels``` with ```activity```.

* **Step 6 -> Appropriately use descriptive variable names with the data set ```Data```:**

    This will follow the following replacements to generate descriptive columns names:
    * Columns starts with prefix ```t``` is replaced by the word ```time```.
    * Columns starts with prefix ```f``` is replaced by the word ```frequency```.
    * Columns contains the prefix ```Acc``` is replaced by the word ```Accelerometer```.
    * Columns contains the prefix ```Gyro``` is replaced by the word ```Gyroscope```.
    * Columns contains the prefix ```Mag``` is replaced by the word ```Magnitude```.
    * Columns contains the dublicated ```BodyBody``` is replaced by the word ```Body```.
    
* **Step 7 -> Creating a second independent aggregated tidy data set and ouput it :**
    * Create a new data frame by finding the mean for each combination of subject and label. It's done by ```aggregate()``` function.
    * Sorting the dataset ```Data2``` by ```subject``` and ```activity```.
    * Reindexing the row names for the dataset ```Data2```.
    * Write the new tidy set into a text file called ```tidydataset.txt```, formatted similarly to the original files.