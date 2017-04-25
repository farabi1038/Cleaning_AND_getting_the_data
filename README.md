Getting and Cleaning Data - Project

This basically for a course project in coursera. The R script, run_analysis.R, does the following:

    First ,it will lload necessary packages (reshape2 and data.table)
    It will download the dataset if could not find the dataset in directory its working 
    Then it will unzip the data that has been downloaded if it is not .
    Get  the activity and feature file information
    Loads both the training and test datasets, keeping only those columns which contains   mean or standard deviation
    Then, the activity and subject data for each dataset will be loaded , and wil be merged those columns with the dataset
    Then the two dataset will be merged
    Converts the activity and subject columns into factors
    Lastly, it will create a tidy dataset that consists of the mean value of each variable for each subject and activity .

At last the  result will be  shown in the file tidyData.txt.
