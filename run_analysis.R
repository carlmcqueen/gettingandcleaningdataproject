## Carl McQueen
## getting and cleaning data project
## 5-23-14


# 1. Merges the training and the test sets to create one data set.

## the file for the course
## fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## download the file
## download.file(fileURL,destfile="./data/dataset.zip",method="curl",quiet=TRUE)
## unzip the file
## unzip("./data/dataset.zip",list=FALSE,overwrite=TRUE,exdir="data")
## set wd to zipped file path
## setwd("./data/UCI HAR Dataset/")

## read in the training and test X data sets
tmp1 <- read.table("train/X_train.txt")
tmp2 <- read.table("test/X_test.txt")
## combine them together
tblOne <- rbind(tmp1, tmp2)

## read in the training and test subject data sets
tmp1 <- read.table("train/subject_train.txt")
tmp2 <- read.table("test/subject_test.txt")
## combine them together
subjectData <- rbind(tmp1, tmp2)

## read in the y data sets
tmp1 <- read.table("train/y_train.txt")
tmp2 <- read.table("test/y_test.txt")
## combine them together
tblTwo <- rbind(tmp1, tmp2)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
meanStd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
tblOne <- tblOne[, meanStd]
names(tblOne) <- features[meanStd, 2]
names(tblOne) <- gsub("\\(|\\)", "", names(tblOne))
## odd for a week 4 lecture to be in a week 3 assignment...
names(tblOne) <- tolower(names(tblOne))  # see last slide of the lecture Editing Text Variables (week 4)

# 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")
## substitutions, replacement and making lower case
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
tblTwo[,1] = activities[tblTwo[,1], 2]
names(tblTwo) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(subjectData) <- "subject"
cleanSet <- cbind(subjectData, tblTwo, tblOne)
## cleanSet labeled document
write.table(cleanSet, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(subjectData)[,1]
numSubjects = length(unique(subjectData)[,1])
numActivities = length(activities[,1])
numCols = dim(cleanSet)[2]
result = cleanSet[1:(numSubjects*numActivities), ]

## for loops to populate the new cleaned table
## runs through for the total number of subjects and activities then builds the result table
row = 1
for (i in 1:numSubjects) {
        for (j in 1:numActivities) {
                result[row, 1] = uniqueSubjects[i]
                result[row, 2] = activities[j, 2]
                ## temp var with results within it for mean calculation
                tmp <- cleanSet[cleanSet$subject==i & cleanSet$activity==activities[j, 2], ]
                ## add the mean to result
                result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row+1
        }
}
## finally, write the results
write.table(result, "data_set_with_the_averages.txt")

## validation
# validationTmp <- read.table("data_set_with_the_averages.txt")
# result[4,4]
# validationTmp[4,4]
# validationTmp[4,4]==result[4,4]
# result[6,4]
# validationTmp[6,4]
# validationTmp[6,4]==result[6,4]