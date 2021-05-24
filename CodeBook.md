---
title: 'Codebook: Getting and Cleaning Data Week 4 Project'
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
## Variable and data information:

The data were collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. Source data can be obtained here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

### Tidydata.txt
The tidy data has 180 rows and 68 columns. Rows are defined by subject and activity type, which subjects defined as thenumbers "1-30" and activities for each subject as follows:

WALKING
WALKING UPSTAIRS
WALKING DOWNSTAIRS
SITTING
STANDING
LAYING

"subject" and "activity" columns are factors. All other columns in the tidy dataset are numeric and represent the average of the variable for each subject/activity pair.

## Script information:
The run_anaylsis script completes steps 1-5, and creates the "tidydata.txt" output file. Further details on transformation steps are below.

1. Merges the training and the test sets to create one data set.
- download the dataset
- unzip the dataset
- read in features names
- read in train and test files
- combine columns of train files into one table and test files into one table
- add identifying column for train and test data
- combine train and test data by binding rows

2. Extract only the measurements on the mean and standard deviation for each measurement.
- Extracting columns with "mean()" and "std()" in col name because those columns were created by the mean and 
standard deviation functions. Other columns just containing "mean" or "std" are not direct means and standard deviations

3. Uses descriptive activity names to name the activities in the data set
- Relabel factor levels 1-6 of activity column to activity names

4. Appropriately labels the data set with descriptive variable names. 
- Remove extra characters from col names

5. From the data set in step 4, creates a second, independent tidy data set with the average 
of each variable for each activity and each subject.
- remove "test/train" label variable
- Pivoting longer to be able to index by subject, activity, and measured variable
- Index by subject, activity, and measured variable and calculating means
- Pivot wider so rows contain unique subject/activity and columns contain variable means
- Write file with tidy data from step 5

