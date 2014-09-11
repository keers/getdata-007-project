#!/usr/bin/env Rscript

# Download dataset
if (!file.exists("UCI HAR Dataset")){
    dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
    temp <- tempfile()
    download.file(dataset_url, destfile = temp, method="curl", mode="wb")
    unzip(temp)
    unlink(temp)
}

#Read raw data
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names =  c("id", "label"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "name"))


