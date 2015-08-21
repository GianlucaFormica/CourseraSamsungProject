#set working directory
#install.packages("tidyr")
#install.packages("dplyr")
##setwd("C:/Users/Gianluca/Documents/R/")

#Load dplyr and tidyr
library(dplyr)
library(tidyr)

#Read the X-files
X_train_df<-read.table("./UCI HAR Dataset/train/X_train.txt")
X_test_df <-read.table("./UCI HAR Dataset/test/X_test.txt")

#Join the X-data
X_df<-dplyr::bind_rows(X_train_df,X_test_df)

#Remove unused X-data from memory
rm(X_train_df, X_test_df)

#Read the features file
##setwd("./UCI HAR Dataset/")
features_list<-read.table("./UCI HAR Dataset/features.txt")

##change back to dir
##setwd("C:/Users/Gianluca/Documents/R/")

#add labels to X-data
colnames(X_df)<-features_list[,2]

#new step
std_mean_X_cols<-grep("mean|std",features_list[,2])
X_df_2<-X_df[,std_mean_X_cols]

##select varibales with std and mean
##std_X_cols<-grep("mean|std",colnames(X_df))
##mean_X_cols<-grep("mean",colnames(X_df))

##get the observations
##std_cols_data  <- X_df[, std_X_cols]
##mean_cols_data <- X_df[, mean_X_cols]

#Free up memory
rm(X_df)

#Read y-files
y_train_df<-read.table("./UCI HAR Dataset/train/y_train.txt")
y_test_df <-read.table("./UCI HAR Dataset/test/y_test.txt")

#Join y-files
y_df<-dplyr::bind_rows(y_train_df,y_test_df)
rm(y_train_df, y_test_df)

#Replace activity number with actual activity
activity<-c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
l<-dim(y_df)
ii<-1:l[1]
for (i in ii){
  y_df[i,1]<-activity[as.numeric(y_df[i,1])]
}

#Add Activity label to y_df
colnames(y_df)<-"Activity"

#Read s-files
s_train_df<-read.table("./UCI HAR Dataset/train/subject_train.txt")
s_test_df <-read.table("./UCI HAR Dataset/test/subject_test.txt")

#Combine s-data 
s_df<-dplyr::bind_rows(s_train_df,s_test_df)

#Remove unused s-Data from environment 
rm(s_train_df, s_test_df)

#Add label to s_df
colnames(s_df)<-"Subject"

#Combine all s,y,X-data 
syXdata<-dplyr::bind_cols(s_df,y_df, X_df_2)

#Remove unused s,y,X-Data from environment 
rm(s_df,y_df, X_df_2)

#Group by Subject and Activity
syXdataGrouped<-dplyr::group_by(syXdata, Subject, Activity)

#Remove unused syXdata from environment 
rm(syXdata)

#Take the means 
syXdataGroupedMeans<-dplyr::summarise_each(syXdataGrouped, funs(mean))

#Write to text.file
write.table(syXdataGroupedMeans, file="myTidyData.txt", row.name=FALSE)