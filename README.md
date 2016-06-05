# GettingAndCleaningData

#Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


#The files listed in the data set are:
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

#Data Files used on this Analysis
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

#Load the data first to start the analysis
To load the data to start the analysis and before we comabine and merge the original data files, we can use the Read.Table() function in R.

Read the activity files

datasetActivityTest  <- read.table(file.path(path_dataset, "test" , "Y_test.txt" ),header = FALSE), 
datasetActivityTrain <- read.table(file.path(path_dataset, "train", "Y_train.txt"),header = FALSE)

Read the feature files

datasetFeaturesTest  <- read.table(file.path(path_dataset, "test" , "X_test.txt" ),header = FALSE), 
datasetFeaturesTrain <- read.table(file.path(path_dataset, "train", "X_train.txt"),header = FALSE)

Read the subject files

datasetSubjectTrain <- read.table(file.path(path_dataset, "train", "subject_train.txt"),header = FALSE), 
datasetSubjectTest  <- read.table(file.path(path_dataset, "test" , "subject_test.txt"),header = FALSE)

#Explore the data we just loaded
Now lets take a look at the data we loaded in order to identify the variables and structure of the dataset.

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

