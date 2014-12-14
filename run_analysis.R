# Download zip file to the current directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ", destfile="getdata-projectfiles-UCI HAR Dataset.zip", mode='wb')

# Unzip this file into the current directory
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

# Directory "UCI HAR Dataset" is now created in the working directory with data inside

# As explained in https://class.coursera.org/getdata-016/forum/thread?thread_id=50, Inertial Signals can just be ignored for the exercice (though no mean nor std inside)
# We first merge training dataset
# Total number of rows is 7352

# First column will be the subject (from subject_train.txt file)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Second column will be the activity label (from y_train.txt)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Following next ones will be the 561 columns from X_train.txt
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

# "c"Merge into a data frame called "training"
training <- cbind(subject_train, y_train, X_train)

# Do the same for test data (2947 entries)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

# "c"Merge into a data frame called "test"
test <- cbind(subject_test, y_test, X_test)

# Now "r"merge training and test to get one data set "global_data_set" of size (10299 x 563)
global_data_set <- rbind(training, test)

# Set a vector colnames_vector containing the descriptive variable names in file features.txt
features <- read.table("./UCI HAR Dataset/features.txt")
colnames_vector <- as.vector(features[,2])

# Append "subject" and "activity" at the beginning of this vector to fit merged data
colnames_vector <- append(c("subject","activity"), colnames_vector)

# Set global_data_set column names with colnames_vector data
colnames(global_data_set) <- colnames_vector

# Extract only the measurements on the mean and standard deviation for each measurement
# That is only descriptions containing the words "mean" and "std", but we keep also the newly added columns "subject" and "activity"

# Use dplyr
library(dplyr)
# column names are duplicated so deduplicate with make.unique
colnames(global_data_set) <- make.unique(colnames(global_data_set))
filtered_data_set <- select(global_data_set, matches("subject"), matches("activity"), contains("mean()"), contains("std()"))

# Name the activity : replace indices (1 to 6) with activity names in file activity_labels.txt
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Loop over the number of rows of filtered_data_set to replace the items in the second column
for (i in 1:nrow(filtered_data_set)) {
    filtered_data_set[i,2] <- as.character(activity_labels[filtered_data_set[i,2],2])
}
# Here filtered_data_set is the tidy data set as required at step 4. Write it to file "step4_data_set.txt"
write.table(filtered_data_set,"step4_data_set.txt", row.name=FALSE)

# Let's create the step 5 tidy data set in a new data frame called step5_tidy_data
step5_tidy_data <- aggregate(select(filtered_data_set, -c(1,2)), 
                             list(subject = filtered_data_set$subject, activity = filtered_data_set$activity), 
                             mean)

#sort by subject then activity
step5_tidy_data <- arrange(step5_tidy_data, subject, activity)

# step5_tidy_data is our proper tidy data. Write it to file "step5_data_set.txt"
write.table(step5_tidy_data,"step5_data_set.txt", row.name=FALSE)
