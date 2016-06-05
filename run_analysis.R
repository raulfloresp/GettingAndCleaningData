## SCRIPT STARTS HERE
# The purpose of this project is to demonstrate the ability to collect, work with, 
## and clean a data set. 
## The goal is to prepare tidy data that can be used for later analysis. 
## 
##
# A. DATA PREPARATION
### A.1 Use the "download.file()" function to download source dataset file
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileUrl <- file.path("./coursera/data2", "WerableData.zip")
download.file(url, fileUrl)

### A.2 Unzip and list the downloaded files

unzip(zipfile = "./coursera/data2/WerableData.zip", exdir = "./coursera/data2")

## Once unzipped, a new directory named "UCI HAR Dataset" should be created
## List files on "UCI HAR Dataset" directory

path_dataset <- file.path("./coursera/data2" , "UCI HAR Dataset")
files<-list.files(path_dataset, recursive=TRUE)
files

### A.3 Load required R Libraries
library(dplyr)
library(data.table)
library(tidyr)

##
## 1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET.
### 1.1 Read the source files
## Read the activity files
datasetActivityTest  <- read.table(file.path(path_dataset, "test" , "Y_test.txt" ),header = FALSE)
datasetActivityTrain <- read.table(file.path(path_dataset, "train", "Y_train.txt"),header = FALSE)

## Read the subject files
datasetSubjectTrain <- read.table(file.path(path_dataset, "train", "subject_train.txt"),header = FALSE)
datasetSubjectTest  <- read.table(file.path(path_dataset, "test" , "subject_test.txt"),header = FALSE)

## Read the feature files
datasetFeaturesTest  <- read.table(file.path(path_dataset, "test" , "X_test.txt" ),header = FALSE)
datasetFeaturesTrain <- read.table(file.path(path_dataset, "train", "X_train.txt"),header = FALSE)

### 1.2 Explore the data we just readed
## Use head() to get a quick view of the data
head(datasetActivityTest)
head(datasetSubjectTrain)
head(datasetFeaturesTest)
head(datasetFeaturesTrain)
head(datasetSubjectTest)
head(datasetSubjectTrain)

#Use str() to explore the internal structure of the R objects we just readed
str(datasetActivityTest)
str(datasetActivityTrain)
str(datasetFeaturesTest)
str(datasetFeaturesTrain)
str(datasetSubjectTest)
str(datasetSubjectTrain)

### 1.3. Merge the data to generate a unique dataset
## Combine the data tables by rows on the ACTIVITY files using the "rbind()" function
datasetSubject <- rbind(datasetSubjectTrain, datasetSubjectTest)
datasetActivity<- rbind(datasetActivityTrain, datasetActivityTest)
datasetFeatures<- rbind(datasetFeaturesTrain, datasetFeaturesTest)

### 1.4 Use the names() function in order to set names of the data objets
names(datasetSubject)<-c("subject")
names(datasetActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_dataset, "features.txt"),head=FALSE)
names(datasetFeatures)<- dataFeaturesNames$V2

### 1.5 Merge Data Frame using the "cbind()" function to combine the data frame by columns

dataCombine <- cbind(datasetSubject, datasetActivity)
DataFrame <- cbind(datasetFeatures, dataCombine)

##
## 2. EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT.
## 
### 2.1 Subset Name of Features by measurements on the mean "mean()" and standard "std()" deviation

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

### 2.2 Subset the data frame by seleted names of Features
selectedDataNames <- c(as.character(subdataFeaturesNames), "subject", "activity" )
DataFrame <- subset(DataFrame, select=selectedDataNames)

### 2.3 Check the structure of the DataFrame by using the srt() function
str(DataFrame)

##
## 3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
##
### 3.1 Enter name of activity into DataFrame
activityLabels <- read.table(file.path(path_dataset, "activity_labels.txt"),header = FALSE)

### 3.2 Verify the existent names
head(str(DataFrame),2)

##
## 4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES.
## Variables t or f are based on time or frequency measurements.
## Body = related to body movement.
## Gravity = acceleration of gravity
## Acc = accelerometer measurement
## Gyro = gyroscopic measurements
## Jerk = sudden movement acceleration
## Mag = magnitude of movement
## mean and SD are calculated for each subject for each activity for each mean and SD measurements. 
## The units given are g's for the accelerometer and rad/sec for the gyro 
## and g/sec and rad/sec/sec for the corresponding jerks.
##
### 4.1 Assign the appropiated labels names
names(DataFrame)<-gsub("std()", "SD", names(DataFrame))
names(DataFrame)<-gsub("mean()", "MEAN", names(DataFrame))
names(DataFrame)<-gsub("^t", "time", names(DataFrame))
names(DataFrame)<-gsub("^f", "frequency", names(DataFrame))
names(DataFrame)<-gsub("Acc", "Accelerometer", names(DataFrame))
names(DataFrame)<-gsub("Gyro", "Gyroscope", names(DataFrame))
names(DataFrame)<-gsub("Mag", "Magnitude", names(DataFrame))
names(DataFrame)<-gsub("BodyBody", "Body", names(DataFrame))

### 4.2 Names after labels update
names (DataFrame)
head(str(DataFrame), 5)

## 5. FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY DATA SET 
## WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT. 
## 5.1 Write to text file on disk
write.table(DataFrame, "TidyData.txt", row.name=FALSE)

### 5.2 Explore the new tidy dataset we just created
tidyfile <- read.csv("./TidyData.txt")
head (str(tidyfile),5)

## SCRIPT ENDS HERE