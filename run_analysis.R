###   run_analysis.R is for 
###1. merging training and test datasets 
###2. extracting measurements involving mean and st.dev. of data
###3. replace activity no. labels with their corresponding descriptions
###4. label variables or column names as required
###5. summarize mean of all variables into new dataset

## Compiling train data
XsubTrain<-read.table("train/subject_train.txt") #loads train subject no. into vector
Trainlabels<-read.table("train/y_train.txt") #loads train activity label no. into vector
XTrain<-read.table("train/X_train.txt") #loads main train data
Tr<-c(rep("Training",7352)) #for adding as a column to signify training dataset label
train<-cbind(XsubTrain, Trainlabels, Tr, XTrain) 
  #merged 3 new columns to train data for subject no., activity label no. and training dataset label

##Load features.txt into a vector to add as column heading names to dataframes
features<-read.table("features.txt") #load features into vector
feat1<-as.character(features[,2]) #removes the 1st column of numbers
cn<-append(c("sub_no", "act_labels", "test_train"),feat1) #adds 3 new categories to vector
colnames(train)<-cn #vector for changing column names of overall merged dataset 
##built first dataframe for Training data

## Compiling test data. Follows the same steps as above for train data.
XsubTest<-read.table("test/subject_test.txt") #loads test subject no. into vector
Testlabels<-read.table("test/y_test.txt") #loads test activity label no. into vector
XTest<-read.table("test/X_test.txt") #loads main test data
Te<-c(rep("Testing",2947)) #for adding as a column to signify testing dataset label
test<-cbind(XsubTest, Testlabels, Te, XTest)
colnames(test)<-cn
##built second dataframe for Test data

##Merge both dataframes by rbind
Samsung<-rbind(train,test) #merged dataframe with train data on top, test, data below.
##Successfully merged data for Task 1.

##To identify the columns for 'mean and std':
grep("mean()", feat1)->mn #selects only for columnns with character "mean()" in them 
grep("std()", feat1)->std #selects only for columnns with character "std()" in them
append(mn, std)->mnstd
SS<-Samsung[,c(1,2,3,mnstd+3)]# expression 'mnstd+3' because dataframe had 3 new columns added to it
##Successfully selected 'mean' and 'std' data for Task 2.

library(dplyr) #to load dplyr
library(plyr)  #to load plyr

act<-mapvalues(SS$act_labels, c(1:6), 
          c("WALKING","WALKING_UPSTR","WALKING_DWNSTR","SITTING","STANDING","LAYING"))
#replace number of activity labels with activity name
SS$act_labels<-act
##Successfully completed task 3, task 4 completed by adding column names prior.

S<-tbl_df(SS) #convert to tlb_df for dyplr
summ<-group_by(S, sub_no, act_labels, test_train)
summ_all<-summarise_all(summ, mean)
summ_all
##Successfully completed task 5 for summarising all variable data

####end
