# read training & test data set.
# data is separated by space, read.table with sep = "" will automatically
# read all the data and separate each value with a/multiple space as delimiter.
# there should be 561 columns according to features.txt
train_data <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "")
test_data <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "")

# read the row names (activities label) from y_train.txt or y_test.txt
train_activity_label <- read.table("UCI HAR Dataset/train/y_train.txt")
test_activity_label <- read.table("UCI HAR Dataset/test/y_test.txt")
# set row names (activity label) to train_data & test_data
train_data <- cbind(activity_label = train_activity_label, train_data)
test_data <- cbind(activity_label = test_activity_label, test_data)
colnames(train_data)[1] <- "activity_label"
colnames(test_data)[1] <- "activity_label"

# read the subject names from subject_train & subject_test
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
# set row names (subject) to train_data & test_data
train_data <- cbind(subject = train_subject, train_data)
test_data <- cbind(subject = test_subject, test_data)
colnames(train_data)[1] <- "subject"
colnames(test_data)[1] <- "subject"

# merge training & test data set
merged_data <- merge(x = test_data, y = train_data, all = TRUE)

# read the column names from features.txt
# the column names are having the format of numbers, followed by some text and 
# ends with close parenthesis. The regular expression is ^[0-9]+ .+)$
variable_names <- readLines("UCI HAR Dataset/features.txt")
# add the "subject" & "activity_name" we added previously to the variable_names
variable_names <- c("subject", "activity_label", variable_names)
# set column names to merged_data
names(merged_data) <- variable_names
# convert the subject to factor
merged_data$subject <- as.factor(merged_data$subject)

# extracts only the measurements on the mean and standard deviation for each measurement
# find the logical vector for column names subject, we need to preserve the subject
columns_with_subject <- grepl(x = names(merged_data),pattern = "subject")
# find the logical vector for column names activity_label, we need to preserve the name
columns_with_activity <- grepl(x = names(merged_data),pattern = "activity_label")
# find the logical vector for column names with mean()
columns_with_mean <- grepl(x = names(merged_data),pattern = ".+mean\\(\\).+")
# find the logical vector for column names with std()
columns_with_std <- grepl(x = names(merged_data),pattern = ".+std\\(\\).+")
# find the logical vector for columns names with either mean() or std()
columns_with_mean_std <- Reduce(f = "|",x = list(
    columns_with_subject, columns_with_activity, columns_with_mean, columns_with_std))
# remove columns from merged_data that is not mean or std
primary_data <- merged_data[,columns_with_mean_std]


# uses descriptive activity names to name the activities in the data set
# swap the activity label in train_activity_name & test_activity_name to the actual text label
activity_label <- setNames(c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                             "SITTING", "STANDING", "LAYING"),
                           c(1,2,3,4,5,6))
primary_data$activity_label <- activity_label[as.character(primary_data$activity_label)]
# convert the activity column to factor
primary_data$activity_label <- as.factor(primary_data$activity_label)
# save tidy primary data to file
write.table(x = primary_data, file = "primary_data.txt")
# save tidy primary data's label to file
write.table(x = names(primary_data), file = "primary_label.txt", quote = FALSE, 
            append = FALSE, row.names = FALSE, col.names = FALSE)

# create an independent tidy data set with average of each variable for each activity
# and each subject based on the primary_data
# convert data into dplyr data frame
if("dplyr" %in% rownames(installed.packages()) == FALSE){
    install.packages("dplyr")
}
library(dplyr)
df_reduced <- tbl_df(data = primary_data)
df_reduced_group <- group_by(df_reduced, activity_label, subject)
secondary_data <- summarise_each(df_reduced_group, funs(mean))
# save tidy second data to file
write.table(x = secondary_data, file = "second_data.txt")
# save tidy second data's label to file
write.table(x = names(secondary_data), file = "secondary_label.txt", quote = FALSE, 
            append = FALSE, row.names = FALSE, col.names = FALSE)


# generate code book
if("memisc" %in% rownames(installed.packages()) == FALSE){
    install.packages("memisc")
}
library(memisc)
capture.output(codebook(primary_data), file = "primary_codebook.txt", append = FALSE)
# secondary data is class of groupped df, hence unable to pass into codebook method
# convert secondary data back to data.frame
secondary_data_ndf <- data.frame(secondary_data)
# after converted back to data.frame, the factor in activity column is missing
# convert the activity column to factor
secondary_data_ndf$activity_label <- as.factor(secondary_data_ndf$activity_label)
capture.output(codebook(secondary_data_ndf), file = "secondary_codebook.txt", append = FALSE)