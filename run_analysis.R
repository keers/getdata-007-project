#!/usr/bin/env Rscript

root_data_folder <- "UCI HAR Dataset"

# Download dataset if it is not present. Assumes that downloaded zip archive extracts to 
# "UCI HAR Dataset" folder with appropriate structure of test and train folders.
if (!file.exists(root_data_folder)){
    dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
    temp <- tempfile()
    download.file(dataset_url, destfile = temp, method="curl", mode="wb")
    unzip(temp)
    unlink(temp)
}

# Read common data for all sets
activity_labels <- read.table(paste0(root_data_folder, "/activity_labels.txt"), 
                              col.names =  c("activity.id", "activity.label"))
features <- read.table(paste0(root_data_folder, "/features.txt"), col.names = c("id", "name"))

# Reads data for given set: "test" or "train". Does not check input parameter, so be careful
# Since reading data might take some time, prints output messages to console indicating
# which file is being processed.
readset <- function(setname) {
    set_folder <- paste0(root_data_folder,"/", setname)    
    x_path <- paste0(set_folder, "/X_", setname, ".txt")
    y_path <- paste0(set_folder, "/y_", setname, ".txt") 
    subject_path <- paste0(set_folder, "/subject_", setname, ".txt")
    
    message(paste("reading data from:", x_path))    
    x <- read.table(x_path, col.names = features$name)
    
    message(paste("reading data from:", y_path))
    y <- read.table(y_path, col.names = "activity.id")
    
    message(paste("reading data from:", subject_path))
    subjects <- read.table(subject_path, col.names = "subject.id")
    
    xy <- cbind(x, y, subjects)
    
    message(paste(setname, "data loaded"))
    xy
}

train_data <- readset("train")
test_data <- readset("test")

# 1. Merge the training and the test sets to create one data set.
#    Use descriptive activity names to name the activities in the data set
all_data <- merge(rbind(train_data, test_data), activity_labels, by = "activity.id")

# 2. Extract only the measurements on the mean and standard deviation for each measurement.
#    "subject.id" and "activity.label" columns are also included.
filtered_columns <- grep("\\.(mean|std)\\.", names(all_data), value=TRUE)
filtered_data <- all_data[, c("subject.id", "activity.label", filtered_columns)]

# 3. From the data set in step 2, create a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
aggregated_data <- aggregate(filtered_data[,filtered_columns], 
                             by = list("activity.label" = filtered_data$activity.label, 
                                       "subject.id" = filtered_data$subject.id), 
                             FUN=mean)

write.table(aggregated_data, file = "aggregated_data.txt", row.name=FALSE)

message("aggregated_data.txt file created")
