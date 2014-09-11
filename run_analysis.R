#!/usr/bin/env Rscript

root_data_folder <- "UCI HAR Dataset"

# Download dataset
if (!file.exists(root_data_folder)){
    dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
    temp <- tempfile()
    download.file(dataset_url, destfile = temp, method="curl", mode="wb")
    unzip(temp)
    unlink(temp)
}

# Read raw data
# common
activity_labels <- read.table(paste0(root_data_folder, "/activity_labels.txt"), col.names =  c("activity.id", "activity.label"))
features <- read.table(paste0(root_data_folder, "/features.txt"), col.names = c("id", "name"))

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

all_data <- rbind(train_data, test_data)
data <- merge(all_data, activity_labels, by="activity.id")


#x_test <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$name)

