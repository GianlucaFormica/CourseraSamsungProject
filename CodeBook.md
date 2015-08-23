
The myTidyData.txt file contains 81 variables. The first two variables, Subject and Activity are described below and the remaining variables are summarised in Features.

Subject:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
run_analysis.R reads in two files namely:
  subject_test.txt - 9 subjects in file (1, 4, 9, 10, 12, 13, 18, 20, 24)
  subject_train.txt - the remaining 21 subjects
An identifier between 1 and 30 of the subject who carried out the experiment.


Activity:

Each person performed six activities.
run_analysis.R reads in two files namely:
y_test.txt y_train.txt contain activities numbers 
activity_labels.txt is used to  the map between Activity number and Activity label
There are six activities per subject

Features:

The sensor signals (accelerometer and gyroscope) input data is Normalised variables value is within the range -1:1
run_analysis.R reads in two files namely:
X_test.txt X_train.txt
features.txt contains the mapping between the feature numbers and feature labels
labels used are from features_info.txt
variables selected are
mean(): Mean value (this includes both meanFreq() and mean() variables in case both are needed) 
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
std(): Standard deviation
This results in 79 variables
