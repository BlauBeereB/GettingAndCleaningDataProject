## README.md for script run_analysis.r

# Instructions for running the script

For clarity, let's call the folder where you saved the script the "working directory".

To start off, make sure that you have downloaded the data set provided here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip the data such that you have a subdirectory (in the working directory) that is called "UCI HAR Dataset".

Then, run the script run_analysis.r. The first time you run it, a file called "joinedData.r" is saved in your working directory. In the next runs, when "joinedData.r" exists, it is loaded from there. This is done to save time when the actual data cleaning procedures are edited and the script is rerun.

The cleaned data set is saved as "tidyData.r" in the working directory.

# Notes on what the script does

At first, the script checks whether the subfolder "UCI HAR Dataset" exists. Then, the names for the two files that are written to the working directory are set.

Part 1:

If the file "joinedData.r" exists, it is loaded. Otherwise, it is made as follows. Two loops are used to load the various files with the original data. The first loop runs over the two cases, i.e. the training and the test case. The corresponding data files are in the two subfolders "train" and "test". The second loop runs over the three different files that are provided for each case. For example, these are called "X_train.txt", "y_train.txt" and "subject_train.txt" for the training set. All six files with the original data are joined into one data set. This is saved as a variable "joinedSet" in the file "joinedData.r".

Part 2:

The file "features.txt" from the original data is loaded and the names of the features are extracted. Two names are added, namely "subject" and "activity". Note that this order is in line with the order in which the files are joined in part 1. The columns in the joined data set are given these feature names. In addition, all names which refer to a mean or a standard deviation (abbreviated by std) are found. (Note that neither mean frequencies nor angles that involve a mean are taken into account.) Then, only columns with mean or standard deviation plus the subject and activity columns are extracted from "joinedSet" and saved as a new variable "extractedSet".

Part 3:

The file "activity_labels.txt" from the original data is loaded. It contains the encoding of six different activities by numbers, e.g. walking is encoded by the number 1. The numeric values for the activities (last column in the data set) are replaced by the descriptions of the activities.

Part 4:

Here, the column names, i.e. the labels of the variables in the data set, are improved and clarified. For example, brackets are removed and abbreviations are expanded, e.g. t is replaced by time. As a result, all names just contain letters (in camel case).

Part 5:

From the data set prepared in the previous steps, a new tidy data set called "tidySet" is derived. It contains the average of each variable for each activity and each subject. This data set is saved in the file "tidyData.r".

# Author and date

The script has been prepared by BlauBeereB in the context of the course project for the Coursera course "Getting and Cleaning Data" provided by Johns Hopkins University in January 2015.


