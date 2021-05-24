library(tidyverse)
library(dplyr)

#1. Merges the training and the test sets to create one data set.

# Download the dataset
if(!file.exists("./Course 3 Project")){dir.create("./Course 3 Project")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "../Course 3 Project/UCI HAR Dataset/.zip")

# Unzip the dataset
unzip(zipfile = "../Course 3 Project/UCI HAR Dataset/.zip", exdir = "./Course 3 Project")

#read in features names
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE, sep = "", dec = ".", colClasses = "character")
features <- features[,2] #remove indices column

#read in train and test files
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", dec = ".", col.names = features) #read test data with corresponding features names
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", dec = ".", col.names = "activity") #read in test activity column
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", dec = ".", col.names = "subject") #read in test subject column
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", dec = ".", col.names = features) #read train data with corresponding features names
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", dec = ".", col.names = "activity") #read in train activity column
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", dec = ".", col.names = "subject") #read in train subject column

test_set <- cbind(subject_test, y_test, x_test) #combine test files into one table
train_set <- cbind(subject_train, y_train, x_train) #combine train files into one table

test_set$type = "test" #add identifying column for test data
train_set$type = "train" #add identifying column for train data

total_set <- rbind(test_set, train_set) #combine train and test data 
total_set <- total_set[ , c(1:2,564,3:563) ] #reorder columns so that identifying columns are at beginning

#3. Extract only the measurements on the mean and standard deviation for each measurement.
#extracting columns with "mean()" and "std()" because those columns were created by the mean and 
#standard deviation functions. Other columns just containing "mean" or "std" are not direct means and standard deviations
mean_columns <- grepl("mean." , names(total_set), fixed = TRUE) #create T/F vector for columns containing "mean."
    #Including the "." prevents any columns that are meanFreq (mean frequency) measures from being included
std_columns <- grepl("std" , names(total_set)) #create T/F vector for columns containing "std()"

means_stds <- total_set[, mean_columns | std_columns] #extract mean & std columns into separate df
identifiers <- total_set[,1:3] #extract subject, activity, and type (test or train) columns into separate df
extracted_set <- cbind(identifiers,means_stds) #combine mean/stds and identifiers

#4. Uses descriptive activity names to name the activities in the data set
#Relabel factor levels 1-6 of activity column to activity names
extracted_set$activity[extracted_set$activity == 1] <- "Walking"
extracted_set$activity[extracted_set$activity == 2] <- "Walking Upstairs"
extracted_set$activity[extracted_set$activity == 3] <- "Walking Downstairs"
extracted_set$activity[extracted_set$activity == 4] <- "Sitting"
extracted_set$activity[extracted_set$activity == 5] <- "Standing"
extracted_set$activity[extracted_set$activity == 6] <- "Laying"

colnames(extracted_set) <- gsub("\\.+", ".", colnames(extracted_set)) #remove ".." & "..." from column names and replace with "."
colnames(extracted_set) <- gsub("[.]$", "", colnames(extracted_set)) #remove "." at end of column name

extracted_set$subject <- as.factor(extracted_set$subject) #convert "subject" column to factor
extracted_set$activity <- as.factor(extracted_set$activity) #convert "activity" column to factor
extracted_set$type <- as.factor(extracted_set$type) #convert "type" column to factor
extracted_set

#5. From the data set in step 4, creates a second, independent tidy data set with the average 
#of each variable for each activity and each subject.

#remove "test/train" label variable
new_data <- extracted_set[,-3]
#Pivoting longer to be able to index by subject, activity, and measured variable
new_data <- new_data %>% pivot_longer(!c(subject, activity), names_to = "variable")
#Index by subject, activity, and measured variable and calculating means
new_data <- new_data %>%
  group_by(subject, activity, variable) %>%
  summarise_at(vars(value), list(name = mean))
#Pivot wider so rows contain unique subject/activity and columns contain variable means
new_data <- new_data %>% pivot_wider(values_from = name, names_from = variable)
#Write file with tidy data from step 5
write.table(new_data, "tidydata.txt", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

