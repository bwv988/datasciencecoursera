# Codebook for Data Cleaning Project

## Introduction
The data set generated by run_analysis.R creates a condensed view of the original data set which can be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Merging
The original data set is split up in test and training sets. run_analysis.R extracts and merges test and training sets to create a larger data set.

Additionally, inertial signals data is available for both test and training sets. However, these have been omitted in the creation of the merged data set.

### Variable Transformations
To obtain the target data set, only variables to do with mean and standard deviation have been extracted from the original, raw data set. To do this, grep was used to search for the occurence of mean() and std() in the variable names.

Furthermore, the average of each variable in the set has been recorded for each activity and each subject.

### Renaming and Relabeling
* Variable names from the original data set have been changed such that parenthesis were removed and hyphens replaced by dots, as is general practice in R.

* Instead of activity IDs, activity labels in English were used.

## List of Variables
This lists the variables in the cleaned data set. For a full description of the meaning of each variable, please refer to the according description in the original dataset.

The "activity" uses descriptive labels to describe the subject's activity.

| Variables in Data Set                 |
|---------------------------------------|
| Mean.of.tBodyAcc.mean.X               |
| Mean.of.tBodyAcc.mean.Y               |
| Mean.of.tBodyAcc.mean.Z               |
| Mean.of.tBodyAcc.std.X                |
| Mean.of.tBodyAcc.std.Y                |
| Mean.of.tBodyAcc.std.Z                |
| Mean.of.tGravityAcc.mean.X            |
| Mean.of.tGravityAcc.mean.Y            |
| Mean.of.tGravityAcc.mean.Z            |
| Mean.of.tGravityAcc.std.X             |
| Mean.of.tGravityAcc.std.Y             |
| Mean.of.tGravityAcc.std.Z             |
| Mean.of.tBodyAccJerk.mean.X           |
| Mean.of.tBodyAccJerk.mean.Y           |
| Mean.of.tBodyAccJerk.mean.Z           |
| Mean.of.tBodyAccJerk.std.X            |
| Mean.of.tBodyAccJerk.std.Y            |
| Mean.of.tBodyAccJerk.std.Z            |
| Mean.of.tBodyGyro.mean.X              |
| Mean.of.tBodyGyro.mean.Y              |
| Mean.of.tBodyGyro.mean.Z              |
| Mean.of.tBodyGyro.std.X               |
| Mean.of.tBodyGyro.std.Y               |
| Mean.of.tBodyGyro.std.Z               |
| Mean.of.tBodyGyroJerk.mean.X          |
| Mean.of.tBodyGyroJerk.mean.Y          |
| Mean.of.tBodyGyroJerk.mean.Z          |
| Mean.of.tBodyGyroJerk.std.X           |
| Mean.of.tBodyGyroJerk.std.Y           |
| Mean.of.tBodyGyroJerk.std.Z           |
| Mean.of.tBodyAccMag.mean              |
| Mean.of.tBodyAccMag.std               |
| Mean.of.tGravityAccMag.mean           |
| Mean.of.tGravityAccMag.std            |
| Mean.of.tBodyAccJerkMag.mean          |
| Mean.of.tBodyAccJerkMag.std           |
| Mean.of.tBodyGyroMag.mean             |
| Mean.of.tBodyGyroMag.std              |
| Mean.of.tBodyGyroJerkMag.mean         |
| Mean.of.tBodyGyroJerkMag.std          |
| Mean.of.fBodyAcc.mean.X               |
| Mean.of.fBodyAcc.mean.Y               |
| Mean.of.fBodyAcc.mean.Z               |
| Mean.of.fBodyAcc.std.X                |
| Mean.of.fBodyAcc.std.Y                |
| Mean.of.fBodyAcc.std.Z                |
| Mean.of.fBodyAcc.meanFreq.X           |
| Mean.of.fBodyAcc.meanFreq.Y           |
| Mean.of.fBodyAcc.meanFreq.Z           |
| Mean.of.fBodyAccJerk.mean.X           |
| Mean.of.fBodyAccJerk.mean.Y           |
| Mean.of.fBodyAccJerk.mean.Z           |
| Mean.of.fBodyAccJerk.std.X            |
| Mean.of.fBodyAccJerk.std.Y            |
| Mean.of.fBodyAccJerk.std.Z            |
| Mean.of.fBodyAccJerk.meanFreq.X       |
| Mean.of.fBodyAccJerk.meanFreq.Y       |
| Mean.of.fBodyAccJerk.meanFreq.Z       |
| Mean.of.fBodyGyro.mean.X              |
| Mean.of.fBodyGyro.mean.Y              |
| Mean.of.fBodyGyro.mean.Z              |
| Mean.of.fBodyGyro.std.X               |
| Mean.of.fBodyGyro.std.Y               |
| Mean.of.fBodyGyro.std.Z               |
| Mean.of.fBodyGyro.meanFreq.X          |
| Mean.of.fBodyGyro.meanFreq.Y          |
| Mean.of.fBodyGyro.meanFreq.Z          |
| Mean.of.fBodyAccMag.mean              |
| Mean.of.fBodyAccMag.std               |
| Mean.of.fBodyAccMag.meanFreq          |
| Mean.of.fBodyBodyAccJerkMag.mean      |
| Mean.of.fBodyBodyAccJerkMag.std       |
| Mean.of.fBodyBodyAccJerkMag.meanFreq  |
| Mean.of.fBodyBodyGyroMag.mean         |
| Mean.of.fBodyBodyGyroMag.std          |
| Mean.of.fBodyBodyGyroMag.meanFreq     |
| Mean.of.fBodyBodyGyroJerkMag.mean     |
| Mean.of.fBodyBodyGyroJerkMag.std      |
| Mean.of.fBodyBodyGyroJerkMag.meanFreq |
| subject                               |
| activity                              |