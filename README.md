## README.md for script run_analysis.R

# Instructions for running the script

For clarity, let's call the folder where you saved the script the "working directory".

To start off, make sure that you have downloaded the data set provided here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip the data such that you have a subdirectory (in the working directory) that is called "UCI HAR Dataset".

After starting RStudio or similar, set your working directory correctly, i.e. to your source file location. Then, run the script by typing

source("run_analysis.R")

and pressing Enter. The first time you run it, a file called "joinedData.r" is saved in your working directory. In the next runs, when "joinedData.r" exists, it is loaded from there. This is done to save time when the actual data cleaning procedures are edited and the script is rerun.

The cleaned data set is saved as "tidyData.txt" in the working directory.

# Notes on what the script does

At first, the script checks whether the subfolder "UCI HAR Dataset" exists. Then, the names for the two files that are written to the working directory are set.

Part 1:

If the file "joinedData.r" exists, it is loaded. Otherwise, it is made as follows. Two loops are used to load the various files with the original data. The first loop runs over the two cases, i.e. the training and the test case. The corresponding data files are in the two subfolders "train" and "test". The second loop runs over the three different files that are provided for each case. For example, these are called "X_train.txt", "y_train.txt" and "subject_train.txt" for the training set. All six files with the original data are joined into one data set. This is saved as a variable "joinedSet" in the file "joinedData.r".

Part 2:

The file "features.txt" from the original data is loaded and the names of the features are extracted. Two names are added, namely "subject" and "activity". Note that this order is in line with the order in which the files are joined in part 1. The columns in the joined data set are given these feature names. In addition, all names which refer to a measurement of a mean or a standard deviation (abbreviated by std) are found. (Note that neither mean frequencies nor angles that involve a mean are taken into account.) Then, only columns with mean or standard deviation plus the subject and activity columns are extracted from "joinedSet" and saved as a new variable "extractedSet".

Part 3:

The file "activity_labels.txt" from the original data is loaded. It contains the encoding of six different activities by numbers, e.g. walking is encoded by the number 1. The numeric values for the activities (last column in the data set) are replaced by the descriptions of the activities.

Part 4:

Here, the column names, i.e. the labels of the variables in the data set, are improved and clarified. For example, brackets are removed and abbreviations are expanded, e.g. t is replaced by time. As a result, all names just contain letters (in camel case).

Part 5:

From the data set prepared in the previous steps, a new tidy data set called "tidySet" is derived. It contains the average of each variable for each activity and each subject. The procedure is as follows (likely not the easiest way, but one way). Two loops are used to extract the subsets of data over which the averages are taken. The first loop runs over the activities. For each activity, a subset of the data set is extracted. The second loop runs over the subjects, such that an even smaller subset is extracted that now only contains data that correspond to the current activity and the current subject. The averages of the measurements are calculated and saved together with the activity label and the subject label. In this way, one row is made for each activity and subject. The rows are bound into a new data set called "tidySet". Afterwards, the column names are updated to include names for the activities and subject columns. Finally, the tidy data set is saved in the text file "tidyData.txt".

Remark:

Variables that are not used anymore are deleted/removed in order to avoid errors later on by accidentally using the wrong variables.

# Author and date

The script has been prepared by BlauBeereB in the context of the course project for the Coursera course "Getting and Cleaning Data" provided by Johns Hopkins University in January 2015.


