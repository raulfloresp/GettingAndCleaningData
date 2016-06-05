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

#2. EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT.

###2.1 Subset Name of Features by measurements on the mean "mean()" and standard "std()" deviation

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

###2.2 Subset the data frame by seleted names of Features

selectedDataNames <- c(as.character(subdataFeaturesNames), "subject", "activity" )

DataFrame <- subset(DataFrame, select=selectedDataNames)

###2.3 Check the structure of the DataFrame by using the srt() function

str(DataFrame)


#3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

###3.1 Enter name of activity into DataFrame

activityLabels <- read.table(file.path(path_dataset, "activity_labels.txt"),header = FALSE)

###3.2 Verify the existent names

head(str(DataFrame),2)

#4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES.
Variables t or f are based on time or frequency measurements.

Body = related to body movement.

Gravity = acceleration of gravity

Acc = accelerometer measurement

Gyro = gyroscopic measurements

Jerk = sudden movement acceleration

Mag = magnitude of movement

mean and SD are calculated for each subject for each activity for each mean and SD measurements. 

The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

###4.1 Assign the appropiated labels names

names(DataFrame)<-gsub("std()", "SD", names(DataFrame))

names(DataFrame)<-gsub("mean()", "MEAN", names(DataFrame))

names(DataFrame)<-gsub("^t", "time", names(DataFrame))

names(DataFrame)<-gsub("^f", "frequency", names(DataFrame))

names(DataFrame)<-gsub("Acc", "Accelerometer", names(DataFrame))

names(DataFrame)<-gsub("Gyro", "Gyroscope", names(DataFrame))

names(DataFrame)<-gsub("Mag", "Magnitude", names(DataFrame))

names(DataFrame)<-gsub("BodyBody", "Body", names(DataFrame))


###4.2 Names after labels update

names (DataFrame)

head(str(DataFrame), 5)


#5. FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT. 
### 5.1 Write to text file on disk

write.table(DataFrame, "TidyData.txt", row.name=FALSE)

### 5.2 Explore the new tidy dataset we just created

tidyfile <- read.csv("./TidyData.txt")

head (str(tidyfile),5)

### Sample of the second tidy file

'data.frame':	10299 obs. of  1 variable:
 $ timeBodyAccelerometer.MEAN...X.timeBodyAccelerometer.MEAN...Y.timeBodyAccelerometer.MEAN...Z.timeBodyAccelerometer.SD...X.timeBodyAccelerometer.SD...Y.timeBodyAccelerometer.SD...Z.timeGravityAccelerometer.MEAN...X.timeGravityAccelerometer.MEAN...Y.timeGravityAccelerometer.MEAN...Z.timeGravityAccelerometer.SD...X.timeGravityAccelerometer.SD...Y.timeGravityAccelerometer.SD...Z.timeBodyAccelerometerJerk.MEAN...X.timeBodyAccelerometerJerk.MEAN...Y.timeBodyAccelerometerJerk.MEAN...Z.timeBodyAccelerometerJerk.SD...X.timeBodyAccelerometerJerk.SD...Y.timeBodyAccelerometerJerk.SD...Z.timeBodyGyroscope.MEAN...X.timeBodyGyroscope.MEAN...Y.timeBodyGyroscope.MEAN...Z.timeBodyGyroscope.SD...X.timeBodyGyroscope.SD...Y.timeBodyGyroscope.SD...Z.timeBodyGyroscopeJerk.MEAN...X.timeBodyGyroscopeJerk.MEAN...Y.timeBodyGyroscopeJerk.MEAN...Z.timeBodyGyroscopeJerk.SD...X.timeBodyGyroscopeJerk.SD...Y.timeBodyGyroscopeJerk.SD...Z.timeBodyAccelerometerMagnitude.MEAN...timeBodyAccelerometerMagnitude.SD...timeGravityAccelerometerMagnitude.MEAN...timeGravityAccelerometerMagnitude.SD...timeBodyAccelerometerJerkMagnitude.MEAN...timeBodyAccelerometerJerkMagnitude.SD...timeBodyGyroscopeMagnitude.MEAN...timeBodyGyroscopeMagnitude.SD...timeBodyGyroscopeJerkMagnitude.MEAN...timeBodyGyroscopeJerkMagnitude.SD...frequencyBodyAccelerometer.MEAN...X.frequencyBodyAccelerometer.MEAN...Y.frequencyBodyAccelerometer.MEAN...Z.frequencyBodyAccelerometer.SD...X.frequencyBodyAccelerometer.SD...Y.frequencyBodyAccelerometer.SD...Z.frequencyBodyAccelerometerJerk.MEAN...X.frequencyBodyAccelerometerJerk.MEAN...Y.frequencyBodyAccelerometerJerk.MEAN...Z.frequencyBodyAccelerometerJerk.SD...X.frequencyBodyAccelerometerJerk.SD...Y.frequencyBodyAccelerometerJerk.SD...Z.frequencyBodyGyroscope.MEAN...X.frequencyBodyGyroscope.MEAN...Y.frequencyBodyGyroscope.MEAN...Z.frequencyBodyGyroscope.SD...X.frequencyBodyGyroscope.SD...Y.frequencyBodyGyroscope.SD...Z.frequencyBodyAccelerometerMagnitude.MEAN...frequencyBodyAccelerometerMagnitude.SD...frequencyBodyAccelerometerJerkMagnitude.MEAN...frequencyBodyAccelerometerJerkMagnitude.SD...frequencyBodyGyroscopeMagnitude.MEAN...frequencyBodyGyroscopeMagnitude.SD...frequencyBodyGyroscopeJerkMagnitude.MEAN...frequencyBodyGyroscopeJerkMagnitude.SD...subject.activity: Factor w/ 10299 levels "-0.0023770934 -0.11804976 -0.16177045 -0.1860625 0.12372816 0.23955661 0.89916174 -0.17415338 -0.30044295 -0.83179022 -0.752735"| __truncated__,..: 7747 5819 6366 6164 4874 5168 6287 5287 5216 6670 ...
NULL

#### End of Project
