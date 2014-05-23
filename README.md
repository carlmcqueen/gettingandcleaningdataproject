gettingandcleaningdataproject
=============================

Data for this is to be uploaded.  As a result, code to pull and unpackage have been commented out.

RunAnalysis.R

This script uses the UCI HAR Dataset data which can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once this file is unzipped it makes directories for testing and training.

This script makes combined data sets for the X var, the Y var and the Subject data.

Once these have been combined it goes into the new data and computes and extracts the mean and standard deviation of the data for each of the subject, x, and y data.

It then finds unique subjects, counts them, numbers the activities and runs two for loops to populate the data.

Finally it writes the data to a table called 'data_set_with_the_averages.txt.'

Finally it runs validations on the data, which I have commented out.
