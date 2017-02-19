# Getting-and-cleaning-assignment
Peer-graded Assignment: Getting and Cleaning Data Course Project Submit by February 19, 11:59 PM PST

#Compiles training data
First the script loads data from train subject number, train activity labels and the main training data, and combines it together. 
A new column is added to indicate whether the observation is a training or testing observation.
The features data is used for the column/variable names.

#Compiles test data
Similar to previous compilation of training data

#Merges both datasets into one
Both training and test datasets are joined together through rbind.

#Activity labels are changed from numbers to their corresponding activities
Based on the data/codes for activity labels, the numbered codes are changed to their corresponding activities in the train_test column

#Summarize with mean function to summarise variable data
This completes the final task to find the average of all the variable data, according to the subject number, activity and training/testing datasets (assuming that both are to be analyzed separately).
