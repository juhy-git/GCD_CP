# Getting and Cleaning Data - Course Project

The script works as follows:

- It reads the data from "UCI HAR Dataset" directory and it merges the training and the test sets.
- It sets the names of variables according to list from "features.txt".
- It uses the stringr library to search for variable names that include "mean" or "std". Then it makes the names syntactically valid.
- It adds variables activity variable and subjects variable. Then it sets the activity label according to list from "activity_labels.txt".
- It uses the dplyr library to create a dataset with the average of each variable for each activity and subject.
- It saves the dataset to txt file.
