## Codebook

This code book describes the variables, the data, and any transformations and work that was performed to clean up the data.

### Script
The script "run_analysis.R" executes the following :

* Download zip file to the current directory
* Unzip this file into the current directory
* Directory "UCI HAR Dataset" is now created in the working directory with data inside
* First merge training dataset
	* First column will be the subject (from subject_train.txt file)
	* Second column will be the activity label (from y_train.txt)
	* Following next ones will be the 561 columns from X_train.txt
	* "c"Merge into a data frame called "training"
* Do the same for test data (2947 entries)
	* "c"Merge into a data frame called "test"
* Then "r"merge training and test to get one data set "global_data_set" of size (10299 x 563)
* Set a vector colnames_vector containing the descriptive variable names in file features.txt
* Append "subject" and "activity" at the beginning of this vector to fit merged data
* Set global_data_set column names with colnames_vector data
* Extract only the measurements on the mean and standard deviation for each measurement.
	That is only descriptions containing the words "mean" and "std", 
	but we keep also the newly added columns "subject" and "activity"
* column names are duplicated so deduplicate with make.unique
* Name the activity : replace indices (1 to 6) with activity names in file activity_labels.txt
* Loop over the number of rows of filtered_data_set to replace the items in the second column
* Here filtered_data_set is the tidy data set as required at step 4. Write it to file "step4_data_set.txt"
* Create the step 5 tidy data set in a new data frame called step5_tidy_data (with function aggregate())
* sort by subject then activity (with arrange())
* step5_tidy_data is our proper tidy data. Write it to file "step5_data_set.txt"

### Resulting data

The resulting tidy data set is in the file "step5_data_set.txt"
It contains the means per subject and per activity of all the fields related to mean and standard deviation in the original data.
Once the script executed, the data can be loaded thanks to the following command :

* tab = read.table("step5_data_set.txt", header = TRUE)

This data set has 180 rows of 68 columns, detailed herebelow :
* "1" "subject"
* "2" "activity"
* "3" "tBodyAcc.mean...X"
* "4" "tBodyAcc.mean...Y"
* "5" "tBodyAcc.mean...Z"
* "6" "tGravityAcc.mean...X"
* "7" "tGravityAcc.mean...Y"
* "8" "tGravityAcc.mean...Z"
* "9" "tBodyAccJerk.mean...X"
* "10" "tBodyAccJerk.mean...Y"
* "11" "tBodyAccJerk.mean...Z"
* "12" "tBodyGyro.mean...X"
* "13" "tBodyGyro.mean...Y"
* "14" "tBodyGyro.mean...Z"
* "15" "tBodyGyroJerk.mean...X"
* "16" "tBodyGyroJerk.mean...Y"
* "17" "tBodyGyroJerk.mean...Z"
* "18" "tBodyAccMag.mean.."
* "19" "tGravityAccMag.mean.."
* "20" "tBodyAccJerkMag.mean.."
* "21" "tBodyGyroMag.mean.."
* "22" "tBodyGyroJerkMag.mean.."
* "23" "fBodyAcc.mean...X"
* "24" "fBodyAcc.mean...Y"
* "25" "fBodyAcc.mean...Z"
* "26" "fBodyAccJerk.mean...X"
* "27" "fBodyAccJerk.mean...Y"
* "28" "fBodyAccJerk.mean...Z"
* "29" "fBodyGyro.mean...X"
* "30" "fBodyGyro.mean...Y"
* "31" "fBodyGyro.mean...Z"
* "32" "fBodyAccMag.mean.."
* "33" "fBodyBodyAccJerkMag.mean.."
* "34" "fBodyBodyGyroMag.mean.."
* "35" "fBodyBodyGyroJerkMag.mean.."
* "36" "tBodyAcc.std...X"
* "37" "tBodyAcc.std...Y"
* "38" "tBodyAcc.std...Z"
* "39" "tGravityAcc.std...X"
* "40" "tGravityAcc.std...Y"
* "41" "tGravityAcc.std...Z"
* "42" "tBodyAccJerk.std...X"
* "43" "tBodyAccJerk.std...Y"
* "44" "tBodyAccJerk.std...Z"
* "45" "tBodyGyro.std...X"
* "46" "tBodyGyro.std...Y"
* "47" "tBodyGyro.std...Z"
* "48" "tBodyGyroJerk.std...X"
* "49" "tBodyGyroJerk.std...Y"
* "50" "tBodyGyroJerk.std...Z"
* "51" "tBodyAccMag.std.."
* "52" "tGravityAccMag.std.."
* "53" "tBodyAccJerkMag.std.."
* "54" "tBodyGyroMag.std.."
* "55" "tBodyGyroJerkMag.std.."
* "56" "fBodyAcc.std...X"
* "57" "fBodyAcc.std...Y"
* "58" "fBodyAcc.std...Z"
* "59" "fBodyAccJerk.std...X"
* "60" "fBodyAccJerk.std...Y"
* "61" "fBodyAccJerk.std...Z"
* "62" "fBodyGyro.std...X"
* "63" "fBodyGyro.std...Y"
* "64" "fBodyGyro.std...Z"
* "65" "fBodyAccMag.std.."
* "66" "fBodyBodyAccJerkMag.std.."
* "67" "fBodyBodyGyroMag.std.."
* "68" "fBodyBodyGyroJerkMag.std.."
