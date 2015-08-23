#Do once if tidyr & dplyr packages are not yet installed
#install.packages("tidyr")
#install.packages("dplyr")

#Load dplyr and tidyr
library(dplyr)
library(tidyr)

#Read the X-files: X_test.txt X_train.txt
X_train_df<-read.table("./UCI HAR Dataset/train/X_train.txt")
X_test_df <-read.table("./UCI HAR Dataset/test/X_test.txt")

#Join the X-data
X_df<-dplyr::bind_rows(X_train_df,X_test_df)

#Read the features.txt file
features_list<-read.table("./UCI HAR Dataset/features.txt")

#Add the labels from features.txt to X-data
colnames(X_df)<-features_list[,2]

#Select feature labels that contain mean() or std()
std_mean_X_cols<-grep("mean()|std()",features_list[,2])

#Keep only selected variables
X_df_2<-X_df[,std_mean_X_cols]

#Free up memory
rm(X_df, features_list, std_mean_X_cols, X_train_df, X_test_df)

#Read in y-files: y_test.txt y_train.txt
y_train_df<-read.table("./UCI HAR Dataset/train/y_train.txt")
y_test_df <-read.table("./UCI HAR Dataset/test/y_test.txt")

#Join y-files
y_df<-dplyr::bind_rows(y_train_df,y_test_df)

#Replace activity numbers in y-data with activity labels
activity<-c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
l<-dim(y_df)
ii<-1:l[1]
for (i in ii){
  y_df[i,1]<-activity[as.numeric(y_df[i,1])]
}

#Add Activity label to y_df
colnames(y_df)<-"Activity"

#Free up memory
rm(activity, activity_labels, i, ii, l, y_train_df, y_test_df)

#Read s-files
s_train_df<-read.table("./UCI HAR Dataset/train/subject_train.txt")
s_test_df <-read.table("./UCI HAR Dataset/test/subject_test.txt")

#Combine s-data 
s_df<-dplyr::bind_rows(s_train_df,s_test_df)

#Add label to s_df
colnames(s_df)<-"Subject"

#Remove unused s-Data from environment 
rm(s_train_df, s_test_df)

#Combine all s,y,X-data 
syXdata<-dplyr::bind_cols(s_df,y_df, X_df_2)

#Group by Subject and Activity
syXdataGrouped<-dplyr::group_by(syXdata, Subject, Activity)

#Take the means of each variable per activity and per subject
syXdataGroupedMeans<-dplyr::summarise_each(syXdataGrouped, funs(mean))

#Remove unused data 
rm(syXdataGrouped, syXdata, s_df, y_df, X_df_2)

#Write to text.file 
write.table(syXdataGroupedMeans, file="myTidyData.txt", row.name=FALSE)