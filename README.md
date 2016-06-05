# GettingAndCleaningData

#Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


#A. DATA PREPARATION
###A.1 Use the "download.file()" function to download source dataset file

url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

fileUrl <- file.path("./coursera/data2", "WerableData.zip")

download.file(url, fileUrl)

###A.2 Unzip and list the downloaded files

unzip(zipfile = "./coursera/data2/WerableData.zip", exdir = "./coursera/data2")

Once unzipped, a new directory named "UCI HAR Dataset" should be created

List files on "UCI HAR Dataset" directory

path_dataset <- file.path("./coursera/data2" , "UCI HAR Dataset")

files<-list.files(path_dataset, recursive=TRUE)

files

These are the files extracted from the original Zip File once downloaded to the local data directory. A new file directory "UCI HAR Dataset" has been created. 

activity_labels.txt,
features.txt,
features_info.txt,
README.txt,
test/Inertial Signals/body_acc_x_test.txt,
test/Inertial Signals/body_acc_y_test.txt,
test/Inertial Signals/body_acc_z_test.txt,
test/Inertial Signals/body_gyro_x_test.txt,
test/Inertial Signals/body_gyro_y_test.txt,
test/Inertial Signals/body_gyro_z_test.txt,
test/Inertial Signals/total_acc_x_test.txt,
test/Inertial Signals/total_acc_y_test.txt,
test/Inertial Signals/total_acc_z_test.txt,
test/subject_test.txt,
test/X_test.txt,
test/y_test.txt,
train/Inertial Signals/body_acc_x_train.txt,
train/Inertial Signals/body_acc_y_train.txt,
train/Inertial Signals/body_acc_z_train.txt,
train/Inertial Signals/body_gyro_x_train.txt,
train/Inertial Signals/body_gyro_y_train.txt,
train/Inertial Signals/body_gyro_z_train.txt,
train/Inertial Signals/total_acc_x_train.txt,
train/Inertial Signals/total_acc_y_train.txt,
train/Inertial Signals/total_acc_z_train.txt,
train/subject_train.txt,
train/X_train.txt,
train/y_train.txt,

###A.3 Data Files used on this Analysis
Open the README file - Ans after reading and understanding the origial data files in the data set, I have identified the specific files to be used on the analysis. These are:

SUBJECT FILES:

test/subject_test.txt, 
train/subject_train.txt

ACTIVITY FILES:

train/y_train.txt, 
test/y_test.txt

FEATURE FILES:

train/X_train.txt, 
test/X_test.txt

###A.4 Load required R Libraries

library(dplyr)

library(data.table)

library(tidyr)


#1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET.

To load the data to start the analysis and before we comabine and merge the original data files, we can use the Read.Table() function in R.

### 1.1 Read the source files

READ THE ACTIVITY FILES

datasetActivityTest  <- read.table(file.path(path_dataset, "test" , "Y_test.txt" ),header = FALSE)

datasetActivityTrain <- read.table(file.path(path_dataset, "train", "Y_train.txt"),header = FALSE)

READ THE SUBJECT FILES

datasetSubjectTrain <- read.table(file.path(path_dataset, "train", "subject_train.txt"),header = FALSE)

datasetSubjectTest  <- read.table(file.path(path_dataset, "test" , "subject_test.txt"),header = FALSE)

READ THE FEATURES FILE

datasetFeaturesTest  <- read.table(file.path(path_dataset, "test" , "X_test.txt" ),header = FALSE)

datasetFeaturesTrain <- read.table(file.path(path_dataset, "train", "X_train.txt"),header = FALSE)

### 1.2 Explore the data we just readed

Use head() to get a quick view of the data

head(datasetActivityTest)

head(datasetSubjectTrain)

head(datasetFeaturesTest)

head(datasetFeaturesTrain)

head(datasetSubjectTest)

head(datasetSubjectTrain)


Use str() to explore the internal structure of the R objects we just readed

str(datasetActivityTest)

str(datasetActivityTrain)

str(datasetFeaturesTest)

str(datasetFeaturesTrain)

str(datasetSubjectTest)

str(datasetSubjectTrain)


RESULTS OF DATA EXPLORATION

RUN str(datasetActivityTest)

'data.frame':	2947 obs. of  1 variable:

$ V1: int  5 5 5 5 5 5 5 5 5 5 ...


RUN str(datasetActivityTrain)

'data.frame':	7352 obs. of  1 variable:

$ V1: int  5 5 5 5 5 5 5 5 5 5 ...


RUN str(datasetFeaturesTest)
'data.frame':	2947 obs. of  561 variables:

 $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...

 $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...

 $ V3  : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...


[list output truncated]


RUN str(datasetFeaturesTrain)

'data.frame':	7352 obs. of  561 variables:

 $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
 
 $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
 
 $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
 
  [list output truncated]

RUN str(datasetSubjectTest)

'data.frame':	2947 obs. of  1 variable:

 $ V1: int  2 2 2 2 2 2 2 2 2 2 ...

RUN str(datasetSubjectTrain)

'data.frame':	7352 obs. of  1 variable:

 $ V1: int  1 1 1 1 1 1 1 1 1 1 ...
 

###1.3. Merge the data to generate a unique dataset

Combine the data tables by rows on the ACTIVITY files using the "rbind()" function

datasetSubject <- rbind(datasetSubjectTrain, datasetSubjectTest)

datasetActivity<- rbind(datasetActivityTrain, datasetActivityTest)

datasetFeatures<- rbind(datasetFeaturesTrain, datasetFeaturesTest)

###1.4 Use the names() function in order to set names of the data objets

names(datasetSubject)<-c("subject")

names(datasetActivity)<- c("activity")

dataFeaturesNames <- read.table(file.path(path_dataset, "features.txt"),head=FALSE)

names(datasetFeatures)<- dataFeaturesNames$V2


###1.5 Merge Data Frame using the "cbind()" function to combine the data frame by columns

dataCombine <- cbind(datasetSubject, datasetActivity)

DataFrame <- cbind(datasetFeatures, dataCombine)

