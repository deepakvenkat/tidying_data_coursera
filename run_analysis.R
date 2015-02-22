library(plyr)
library(dplyr)
library(tidyr)

#Function to read and merge data
#This can be used to read the data once
# so that the merged data can be cached.
readAndMergeData <- function () {
  x_test <- read.table("data/test/X_test.txt")
  x_train <- read.table("data/train/X_train.txt")
  #use bind_cols of the dplyr package. Returns a tbl_df
  data <- bind_rows(x_test, x_train)
  return (data)
}

# Function to select only those columns from xData
# which correspond to mean and standard deviation
selectCols <- function (xData) {
  features <- read.table("data/features.txt")
  #Valid cols will now contain 
  # the indices of all rows which have mean and std in their names. 
  validCols <- features %>%
    filter(grepl("mean", V2) | grepl("std", V2))
  cleanData <- xData %>%
    select(validCols$V1)
  names(cleanData) <- validCols$V2
  return (cleanData)
  
}

if(is.null(xData)) {
  xData <- readAndMergeData()
}

cleanData <- selectCols(xData)

#Combining the activity
y_test <- read.table("data/test/y_test.txt")
y_train <- read.table("data/train/y_train.txt")
ydata <- bind_rows(y_test, y_train)
cleanData <- bind_cols(ydata, cleanData)
colnames(cleanData)[1] <- "activity_type"

#Combining the subject
sub_test <- read.table("data/test/subject_test.txt")
sub_train <- read.table("data/train/subject_train.txt")
subData <- bind_rows(sub_test, sub_train)
cleanData <- bind_cols(subData, cleanData)
colnames(cleanData)[1] <- "subject"

#Merge activity labels with the data set
activity_labels <- read.table("data/activity_labels.txt")
colnames(activity_labels) <- c("type", "activity")
cleanData <- merge(activity_labels, cleanData, y.by = "activity_type", x.by = "type", all = FALSE)

# Remove type and activity_type from the merge since the activity labels are described 
# activity column.
cleanData <- select(cleanData, -activity_type, -type)

#make.names removes special characters but leaves behind "."
# use gsub to remove that.
cols <- gsub("\\.", "", make.names(names(cleanData)))
names(cleanData) <- cols

#cleanDataLong <- gather(cleanData, subject, activity)
#Question 5
meanMeasure <- ddply(cleanData, c("subject","activity"), numcolwise(mean))
meanMeasureLong <-gather(meanMeasure, subject, activity)
colnames(meanMeasureLong) <- c("subject", "activity", "signal", "mean")
write.table(meanMeasureLong, "clean_data.txt", row.names = FALSE)
