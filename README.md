====================================================================
A tidy version of 
====================================================================    
    Human Activity Recognition Using Smartphones Dataset Version 1.0
    ================================================================
    Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
    Smartlab - Non Linear Complex Systems Laboratory
    DITEN - Universit?degli Studi di Genova.
    Via Opera Pia 11A, I-16145, Genoa, Italy.
    activityrecognition@smartlab.ws
    www.smartlab.ws
====================================================================

There are 561 features vector in the original dataset. The original databset consists of 2 parts, training and testing set. They can be found in folder "UCI HAR Dataset". Full list of features can be found in "UCI HAR Dataset/features.txt" and their information can be found in "UCI HAR Dataset/features_info.txt".

Tidy version of the original dataset combines both the training and testing set into single dataset which consists only the measurements on the mean and standard deviation for each measurement. Each variables and records are properly labeled.

A secondary dataset is deduced from the primary databset which contains the average of each variables for each activity and each subject.

For each record it is provided:
======================================

Primary dataset
- A 50-feature vector with measurements on the mean and standard deviation for each measurement in original dataset.
- Its activity label.
- An identifier of the subject who carried out the experiment.

Secondary dataset
- A 50-feature vector with average of each measurements for each activity and each subject.
- Its activity label.
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- "README.txt"
- "UCI HAR Dataset": Folder consists of the original datasetl
- "primary_data.txt": primary dataset.
- "primary_label.txt": primary dataset label.
- "primary_codebook.txt": primary dataset codebook.
- "secondary_data.txt": secondary dataset.
- "secondary_label.txt": secondary dataset label.
- "secondary_codebook.txt": secondary dataset codebook.

Each record in primary & secondary dataset are 1 activity that is performed by a subject. There are 30 subjects recorded in the dataset ranging from 1 to 30.

Notes:
======

- Measurements are normalized and bounded within [-1,1].
- Original dataset can be found in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- To run the script "run_analysis.R", download and unzip the original dataset and put the unzipped dataset ("UCI HAR Dataset" folder) together with the script.
