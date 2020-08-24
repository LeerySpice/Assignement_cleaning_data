Getting and Cleaning Data Course Project
========================================
This file describes how run_analysis.R script works.

* First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder with "data".
* Make sure the folder "data" and the data_cleaning.R script are both in the current working directory.
* Second, use script "data_cleaning.R" in RStudio. 
* Third, you will find two output files are generated in the current working directory:
  - DF_total (4.8 Mb): it contains a data frame called with 10299*68 dimension.
  - DF_tidy (1 Kb): it contains a data frame called result with 180*68 dimension.
* Finally, use data <- readRDS("DF_tidy.rds") command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features. 

©LeerySpice 2020 All Rights reserved.