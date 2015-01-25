# This script performs various pre-processing operations 
# on the assigment data set in order to produce a tidy set.

# Clear any old variables:
#rm(list = ls())

# Check if folder with data exists:
dataDir <- "UCI HAR Dataset"
if (!file.exists(dataDir)) {
    stop("Folder with data does not exist.")
}

# Set name for file in which data set is saved:
joinName <- 'joinedData.r'
tidyName <- 'tidyData.txt'

########## Part 1 ##########

# Load previously saved data set or create one data set from files:
if (file.exists(joinName)) {
    # Load previously saved data set:
    load(joinName)
    print('Joined data set has been loaded from file.')
} else {
    # Create one data set from various input files:
    
    # Loop over training and test cases:
    caseList <- c("train", "test")
    for (caseStr in caseList) {
        
        # Loop over files in current case:
        fileList <- c("X", "subject", "y")
        for (fileStr in fileList) {
            
            # Construct name of path to directory for current case:
            dataName <- paste0(dataDir, "/", caseStr, '/', 
                               fileStr, "_", caseStr, ".txt")
            
            if (fileStr == fileList[1]) {
                # Read current file for current (first) case:
                dataSet <- read.table(dataName)
            } else {
                # Read current file for current case:
                addSet <- read.table(dataName)
                # Join this with previously read data:
                joinedSet <- cbind(dataSet, addSet)
                # Rename (actually copy) joined data set:
                dataSet <- joinedSet
                # Delete previous/separate data sets:
                remove(addSet)
                remove(joinedSet)
            }
            
            # Delete name of path:
            remove(dataName)
        }
        
        if (caseStr == caseList[1]) {
            # Rename (actually copy) data set for current (first) case:
            caseSet <- dataSet
            # Delete data set with old name:
            remove(dataSet)
        } else {
            # Join data from current case with data from previous case:
            joinedSet <- rbind(caseSet, dataSet)
            # Delete separate data sets:
            remove(caseSet, dataSet)
        }
    }
    
    # Delete variables that are not needed anymore:
    remove(caseStr)
    remove(caseList)
    remove(fileStr)
    remove(fileList)
    
    # Save joined data set as a file:
    save(joinedSet, file=joinName)
    print('Joined data set has been saved to file.')
}

########## Part 2 ##########

# Load text with names of features, i.e. (most) columns in data:
featureTable <- read.table(paste0(dataDir, "/features.txt"), stringsAsFactors=FALSE)

# Extract column with feature names, i.e. second column of table:
featureNames <- featureTable$V2
remove(featureTable)
numFeatures <- length(featureNames)

# Add names for two last columns in joined data set:
featureNames[numFeatures + 1] <- "subject"
featureNames[numFeatures + 2] <- "activity"
remove(numFeatures)

# Rename columns of joined data set with corresponding names:
colnames(joinedSet) <- featureNames

# Find indices for feature names that contain "mean" and not "meanFreq":
indForMean1 <- grep("mean", featureNames)
indForMean2 <- grep("meanFreq", featureNames, invert=TRUE)
indForMean <- intersect(indForMean1, indForMean2)
remove(indForMean1, indForMean2)

# Find indices for feature names that contain "std:
indForStd <- grep("std", featureNames)

# Combine indices for selected features into one list:
indForBoth <- union(indForMean, indForStd)
remove(indForMean, indForStd)

# Sort indices in ascending order:
indForBoth <- sort(indForBoth)

# Obtain feature names correponding to indices:
namesForBoth <- featureNames[indForBoth]
remove(featureNames)

# Obtain number of selected features (needed later):
numSelected <- length(namesForBoth)

# Add subject and activity to list of names:
namesForExtraction <- c(namesForBoth, "subject", "activity")
remove(namesForBoth)

# Extract only measurements that are mean or standard deviation:
extractedSet <- joinedSet[, namesForExtraction]
remove(namesForExtraction)
remove(joinedSet)

########## Part 3 ##########

# Load text with activity labels, i.e. labels for numbers in last column:
labelsTable <- read.table(paste0(dataDir, "/activity_labels.txt"), stringsAsFactors=FALSE)

# Replace numbers in activity column into labels:
for (index in seq_along(labelsTable$V1)) {
    extractedSet$activity <- gsub(labelsTable$V1[index], labelsTable$V2[index], extractedSet$activity, fixed=TRUE)
}
remove(index)

########## Part 4 ##########

# Extract current labels of data set, i.e. column names:
labelNames <- colnames(extractedSet)

# Remove "()" from labels:
labelNames <- gsub("()", "", labelNames, fixed=TRUE)

# Remove "-" in front of "mean" and "std" and put them in upper case:
labelNames <- gsub("-mean", "Mean", labelNames, fixed=TRUE)
labelNames <- gsub("-std", "Std", labelNames, fixed=TRUE)

# Remove "-" in front of "X", "Y" and "Z":
labelNames <- gsub("-X", "X", labelNames, fixed=TRUE)
labelNames <- gsub("-Y", "Y", labelNames, fixed=TRUE)
labelNames <- gsub("-Z", "Z", labelNames, fixed=TRUE)

# Replace "t" by "time" and "f" by "freq" when at beginning of label:
labelNames <- gsub("tBody", "timeBody", labelNames, fixed=TRUE)
labelNames <- gsub("tGravity", "timeGravity", labelNames, fixed=TRUE)
labelNames <- gsub("fBody", "freqBody", labelNames, fixed=TRUE)
labelNames <- gsub("fGravity", "freqGravity", labelNames, fixed=TRUE)

# Replace "BodyBody" by "Body":
labelNames <- gsub("BodyBody", "Body", labelNames, fixed=TRUE)

# Put descriptive column names into data set:
colnames(extractedSet) <- labelNames

########## Part 5 ##########

# Obtain the labels of the subjects:
subjectLabels <- sort(unique(extractedSet$subject))

# Get number of subjects:
numSubjects <- length(subjectLabels)

# Loop over the activities:
for (currActivity in labelsTable$V2) {
    
    # Find rows with current activity:
    currIndices <- which(extractedSet$activity == currActivity)
    
    # Extract subset of data for current activity:
    currActivitySet <- extractedSet[currIndices, ]
    remove(currIndices)
    
    # Loop over the subjects:
    for (currSubject in subjectLabels) {
        
        # Find rows with current subject:
        currIndices <- which(currActivitySet$subject == currSubject)
        
        # Extract subset of data for current activitiy and subject:
        currSet <- currActivitySet[currIndices, ]
        remove(currIndices)
        
        # Calculate averages (skip activity and subject columns):
        avrgCurrSet <- colMeans(currSet[, seq(1, numSelected, by=1)])
        remove(currSet)
        
        # Collect activity, subject and averages into one vector:
        currRow <- c(currActivity, currSubject, avrgCurrSet)
        remove(avrgCurrSet)
        
        if (currActivity == labelsTable$V2[1] & currSubject == subjectLabels[1]) {
            # For first activity and first subject, start new data set:
            tidySet <- currRow
        } else {
            # For all other combinations, add to data set:
            tidySet <- rbind(tidySet, currRow)
        }
        remove(currRow)        
    }
    remove(currActivitySet)
}
remove(extractedSet)
remove(labelsTable)

# Update column names (first two were missing):
tidyNames <- colnames(tidySet)
tidyNames[1] <- "activity"
tidyNames[2] <- "subject"
colnames(tidySet) <- tidyNames
remove(tidyNames)

# Save tidy data set as a txt file:
write.table(tidySet, file=tidyName, row.name=FALSE)
print('Tidy data set has been saved to file.')

