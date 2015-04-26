## Data Munging
Author: Sanjay Bhatikar

## Table of Contents
I have created one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Merge the training and test sets

The steps I follow are:

1. Download file using `download.file`
2. Unzip using `unzip`
3. Read data from the unzipped files in their folder with `read.table`

There are three text files (.txt) in the training data set:

1. **x_train** that reports 561 variables for 21 subjects.
2. **y_train** with the 6 activties monitored, encoded by integers.
3. **subject_train** with the subject ids.

These files are contain 7352 records (i.e. rows). The testing data set is identically organized except that the files contain  2947 records (i.e rows).

To create one consolidated data set, I have used `cbind` to put three pieces in each set together, followed by `rbind` to merge the training and testing sets.

Lastly, I have used the feature names in **features** (.txt) to label the columns of the consolidate data frame `x.set`.

### Extract measurements only on mean and std. deviation

The `grep` command comes in handy for pattern matching. I have stored the variable names (i.e. column names) in a vector `x.labels` and then located matching columns by position using patterns "mean" and "std".

The `sort` command helps retain the relative order of selected columns. 

Retaining only the selected columns, with the columns for subject id and activity code, I arrive at the data frame `x.set.mean.std`.

### Use descriptive activity names 

The activty labels are in the file named **activity_labels** (.txt). The `merge` command comes in handy for adding activty labels. I have added a cross-tabulation step with `table` on the columns referring to activity by no. and label to verify.

### Label the data set with descriptive variable names

I have employed the descriptive labels provided in the file **features** earlier.

### Report averages for each variable for each activity and subject

The features of `data.table` come in handy for this purpose. I have preferred this over plyr for reasons of speed and simplicity. After converting the data frame to a data table, I use supply arguments as follows:

1. Use `lapply` with `.SD` to run `mean` over all columns
2. Use `.SDcols` to tweak this behavior and include only variables
3. Use `by` to segment the analysis by subject (1:30) and activity (1:6)

The output is a data table `out` converted to data frame `df`. Finally, `write.table` generates the tidy output file, **tidy_output** (.txt) on disk.






