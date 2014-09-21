Coursera Getting and Cleaning Data: Course Project
========================================================

### Intro
Repository for Getting and Cleaning Data Course Project.

### About the raw data
Two Test and Training data sets contain a features set of 561 variables, 1 activity label variable, and 1 subject variable.

### My script
* I created a script called run_analysis.R that reads in the raw data sets and merges them together.
* Used `gsub()` to find all column names containing "-mean" and "std", and changed them to "Mean" and "Std" so that the format of each column name is the same and could easily subset the features data set. 
* Labels are added and only variables about mean and standard deviation are kept fromt the original data.  
* Next I make the data tidy by applying the `aggregate()`function to aggregate the data by Activity and Subject, then take the mean of each variable for each activity and each subject.
* Null values are removed to keep the data tidy.
* The resulting clean and tidy data set is written into a tab-deliminated text file called tidy.txt, which is also uploaded to this repository.

* Descriptive commenting in my code explains each step in my analysis.

### My CodeBook
My CodeBook.md file explains my variables and process.
