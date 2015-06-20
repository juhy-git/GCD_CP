## Read the labels (activity names)
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(labels) <- c("number", "activity")

## Read the features (names)
features <- read.table("./UCI HAR Dataset/features.txt")

## Read the subjects from the training and the test sets
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(subject_train, subject_test)

## Read the activities from the training and the test sets
activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
activity <- rbind(activity_train, activity_test)

## Read the training and the test sets
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
X <- rbind(X_train, X_test)

## Set the names of variables in X
names(X) <- features$V2

## Extracts only the measurements on the mean and standard deviation
library(stringr)
str_mean <- str_detect(names(X),"mean\\(\\)")
str_sd <- str_detect(names(X),"std\\(\\)")
str_mean_sd <- c(names(X[str_mean]), names(X[str_sd]))
X <- X[,str_mean_sd]
names(X) <- make.names(names(X), unique=TRUE)
names(X) <- str_replace_all(names(X), "\\.\\.", "")

## Add activities variable and subjects variable
X$activities <- activity$V1
X$subjects <- subject$V1

## Name activities
X = merge(X,labels,by.x="activities",by.y="number",all=TRUE)
X$activities <- NULL

## Create a data set with the average of each variable for each activity and subject
library(dplyr)
X <- tbl_df(X)
by_as <- group_by(X, activity, subjects)
X <- summarise_each(by_as, funs(mean))

## Save txt
write.table(X, file = "GCD_CP_tidy-data.txt", row.name=FALSE)
