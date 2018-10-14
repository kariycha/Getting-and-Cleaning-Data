# Code book for "Getting and Cleaning Data" course project

## Background information
This project involves getting and tidying up data collected from the accelerometers from a Samsung Galaxy S smartphone. A full description is available at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Data Source

Zip file containing all required data was downloaded and extraced to the working directory. Site data downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



The structure of the data set is described in the [Data](#data) section, its variables are listed in the [Variables](#variables) section, and the transformations that were carried out to obtain the data set based on the source data are presented in the [Transformations](#transformations) section.

## Data <a name="data"></a>

### Variables <a name="variables"></a>

Final data set "hcrmean" contains the mean for each measurement, for given subject and activity 

### Identifiers <a name="identifiers"></a>
Subject identifier, integer, ranges from 1 to 30.

Activity identifier, string with 6 possible values:

	-WALKING
	-WALKING_UPSTAIRS
	-WALKING_DOWNSTAIRS
	-SITTING
	-STANDING
	-LAYING


## Processing <a name="processing"></a>

The following step were carried out to clean and tidy original data sets:

1. The training and test sets were merged to create one data set.
1. The measurements on the mean and standard deviation were extracted for further processing 
1. The activity identifiers (originally coded as integers between 1 and 6) were replaced with descriptive activity names (strings). Change column name from 'activityid' to 'activity'
1. The column names were modified to be more readale:
	- Remove '(', and ')'
	- Replace 'BodyBody' with 'Body'
1. From the data set in step 4, the final data set was created with the average of each variable for each activity and each subject.

The collection of the source data and the transformations listed above were implemented by the `run_analysis.R` R script (see `README.md` file for usage instructions).
