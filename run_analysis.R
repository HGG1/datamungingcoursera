setwd("C:\\Users\\ssbhat3\\Desktop\\Coursera Data Munging")
getwd()

library(data.table)

# Fetch data from source
dataSource <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDestination <- "munging.zip"

download.file(dataSource, dataDestination, mode="wb")

# Unzip
unzip(dataDestination)

# Read files

# Merge train and test sets
# Data: 561 variables in each set
x.train <- read.table(".\\UCI HAR Dataset\\train\\x_train.txt")       # 7352 obs.
x.test <- read.table(".\\UCI HAR Dataset\\test\\x_test.txt")           # 2947 obs.

# Training Labels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, 
#                   SITTING, STANDING, LAYING
# See: activity_labels.txt 
y.train <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")       # 1 through 6
y.test <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")           # 1 through 6

# Subject labels
subject.train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")  # 21 subjects
subject.test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")    # 9 subjects

set.train = cbind(subject.train, y.train, x.train)  # Assemble training set
set.test = cbind(subject.test, y.test, x.test)      # Assemble testing set
x.set <- rbind(set.train, set.test)                 # Merge train and test sets

# Give descriptive labels
x.names <- read.table(".\\UCI HAR Dataset\\features.txt")
x.labels <- c("Subject", "Activity", as.character(x.names[["V2"]]))

colnames(x.set) <- x.labels

# Retain only those with mean and std
x.labels.mean <- x.labels[grep("mean", x.labels)]
x.labels.std <- x.labels[grep("std", x.labels)]
x.labels.mean.std <- x.labels[sort(c(1, 2, grep("mean", x.labels), grep("std", x.labels)))]

x.set.mean.std <- x.set[x.labels.mean.std]
x.set.mean.std                                      # 10299 obs of 79 variables,
                                                    # with subject ID, and
                                                    # activity label.

# Add descriptive activity label

activity.labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")  
colnames(activity.labels) <- c("Activity", "ActivityName")

x.set.mean.std <- merge(x.set.mean.std, activity.labels, by="Activity")
dim(x.set.mean.std)                                 # Now 82 after merge
table(x.set.mean.std$Activity, x.set.mean.std$ActivityName) # Check assignment map
unique(x.set.mean.std$ActivityName)                 # Check activity labels data

# Create a separate tidy dataset with mean of each variable for each subject
# and each activity
# Using data.table
dt <- data.table(x.set.mean.std)
out <- dt[, lapply(.SD, mean, na.rm=TRUE), 
           by=c("Subject", "ActivityName"), 
           .SDcols=3:81]
setkey(out, "Subject")
df <- data.frame(out)
dim(df)

# Write output table
write.table(df, "tidy_output.txt", sep="\t", row.names=FALSE)
