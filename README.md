GCD Final Project
=================

Files:
- run_analysis.R: This script writes out a text file of the final tidy data set for step 5 (averages of measurements for each activity for each subject)
- step5-subject-activity-averages.txt: File written out by run_analysis.R
- CodeBook.md: Code book describing all variables in output table.

------

# Overview
1. Load in all required libraries
2. Load in all test and training data
3. Individually combine all test and train data into full test and train sets
4. Combine observations of test and train sets to one full data set
5. Relabel Columns to be more descriptive
6. Update activity types with more descriptive names
7. Reduce table down to only the variables we care about
8. Group data by subject and activity type, in order to run final calcuation (mean)
9. Output final table

