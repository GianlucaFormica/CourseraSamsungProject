
The myTidyData.txt file contains 81 variables and 180 observations. The first two variables, Subject and Activity are described below and the remaining variables are summarised in Features.

Subject:
An identifier between 1 and 30 of the subject who carried out the experiment.
The experiments have been carried out with a group of 30 volunteers. Information on the subjects can  be found at the following url.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The run_analysis.R file reads in two files namely:subject_test.txt, subject_train.txt
The test group contains 9 subjects (1, 4, 9, 10, 12, 13, 18, 20, 24) the remaining 21 subjects are in the train file. The files are joined so the group information (test/train) is lost. 

Activity:
A label showing the six activities performed by each subject.
run_analysis.R reads in two files namely: y_test.txt y_train.txt which contain activities numbers. The activity number is replaced by an Activity label.


Features:
The remaining 79 variables in myTidyData are averages of the mean and standard deviation of measurements which are described in more detail at the following url 
http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names
run_analysis.R reads in two files namely: X_test.txt X_train.txt
The data is already normalised and therefore has no units.
The features.txt contains the feature labels
variables selected are
- mean(): Mean value (this includes both meanFreq() and mean() variables in case both are needed) 
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- std(): Standard deviation
