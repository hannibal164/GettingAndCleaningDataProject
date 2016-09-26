# TODO: Add comment
# 
# Author: hannibal164
###############################################################################
library(dplyr)
library(data.table)


##THE STEPS ARE NOT IN THE SAME ORDER AS THE INSTRUCTIONS

#The zip file has been downloaded and unzipped to the local documents drive

setwd("C:\\Users\\michmcbr\\Documents\\UCI HAR Dataset")

#Start loading the metadata
features <- fread("features.txt")
activity_labels <- fread("activity_labels.txt")

#Change names of activity data to match datasets
names(activity_labels)<-c("labels","activity")

#Load the test set
subject_test <- fread("test\\subject_test.txt")
X_test <-  fread("test\\X_test.txt")
Y_test<- fread("test\\Y_test.txt")

#STEP 4 Appropriately labels the data set with descriptive variable names. 
names(X_test)<-features$V2

#merge subject data & Y data to X dataset
X_test$subject<-subject_test
X_test$labels<-Y_test

#Load the train set 
subject_train<- fread("train\\subject_train.txt")
X_train <-  fread("train\\X_train.txt")
Y_train<- fread("train\\Y_train.txt")

#STEP 4 Appropriately labels the data set with descriptive variable names.
names(X_train)<-features$V2

#merge subject data & Y data to X dataset
X_train$subject<-subject_train
X_train$labels<-Y_train


#Identify columns with Mean and STD columns. 562 and 563 are for the "labels" and "subject" columns.
MeanSTDfeatures <- grep(".*mean.*|.*std.*", features$V2)
xcols<-c(MeanSTDfeatures,562,563)

#STEP 1 Merges the training and the test sets to create one data set.
X<-rbind(X_test,X_train)

#STEP 2 Extracts only the measurements on the mean and standard deviation for each measurement. labels and subject columns
X<-X[,xcols, with = FALSE]
		
#STEP 3 Uses descriptive activity names to name the activities in the data set
X<-merge(X, activity_labels, by = "labels", all.x = TRUE)

#STEP 4 was previously completed, see lines 27 and 39

#STEP 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy<- X%>%
		select(-labels)%>%
		group_by(activity,subject)%>%
		summarise_each(funs(mean))

#Write the new tiday dataset to local drive.
write.csv(tidy,"tidy_dataset.txt",row.names = FALSE)