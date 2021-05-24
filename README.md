---
title: "README for getting-and-cleaning-data-week-4-project repository"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## README: Getting and Cleaning Data Week 4 Project
This README is for the repository, containing the Week 4 project for the Getting and Cleaning Data course.

The data were collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. Source data can be obtained here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

### Files
*CodeBook.md* contains information about the variables and analyses run.

*run_analysis.R* contains the data cleaning and analysis for this project that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

*tidydata.txt* is the output tidy data set from step 5 above.

In order to produce the tidy "tidydata.txt", download and execute the "run_analysis.R" script.