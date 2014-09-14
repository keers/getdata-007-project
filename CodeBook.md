Script processes the following files from downloaded archive:

* UCI HAR Dataset/activity_labels.txt
* UCI HAR Dataset/features.txt
* UCI HAR Dataset/test/X_test.txt
* UCI HAR Dataset/test/y_test.txt
* UCI HAR Dataset/test/subject_test.txt
* UCI HAR Dataset/train/X_train.txt
* UCI HAR Dataset/train/y_train.txt
* UCI HAR Dataset/train/subject_train.txt

Inertial Signals folder is ignored in both test and train data sets.

Train and test data are processed identically. Transformations are the following:
1. X_test.txt (or X_train.txt) read as table with columns from features.txt file. Each column represents measurement
of a particular feature
2. y_test.txt (or y_train.txt) read as a column of activity identifiers and appended to the table obtained in the
previous step.
3. subject_test.txt (or subject_train.txt) read as a column of subjects and appended to the table obtained in the
previous step.

So at this point subroutine for "test" and "train" data sets produces the table where each row represents a measurement
of features for particular subject performing particular activity.

Next, train and test data are combined into one data set (called all_data in the script) and for each activity identifier
appropriate label is retrieved from activity_labels.txt file.

For given task we leave only columns for mean and standard deviation measurements. Corresponding columns should contain
"-std()" or "-mean()" in their names. Since R transforms special characters into dots (".") for column names, the 
following regexp is used for filtering:
```
"\\.(mean|std)\\."
```
This regexp ignores features like "fBodyAccJerk-meanFreq()-X"

In the end filtered data (stored in the filtered_data variable) is aggregated by subjects and activities and 
saved as a result in aggregated_data.txt file. Each row in the result data represents mean value of mean and std 
feature measurements for particular subject and activity.