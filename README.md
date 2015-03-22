# Samsung_Project
"Getting and Cleaning Data" project script and details
The 'run_analysis.R' script performs the following functions in the following orders:

1. Checks to see if there is a "./data" folder already created in the working director. If not, it creates a "./data" folder in the working directory.
2. Downloads the "JHP.zip" file from the hyperlink provided in the project instructions.
3. Unzips the "JHP.zip" file and places its contents in the "./data" folder.
4. Reads the 'X_test.txt' data into R.
5. Reads the 'X_train.txt' data into R.
6. Merges the 'X_test.txt' and 'X_train.txt' data together, by rows, into a new data set named 'xbind'.
7. Reads the 'features.txt' file into R as a data set titled 'features'.
8. Removes and punctuation characters from the values in the second column of the 'features' data set and saves the values in a new data set titled 'feat_rem'.
9. Creates a new data fram that merges the feature identifier column from the 'features' data set and the feature description column from the 'feat_rem' data set into a new data set titled 'features2'.
10. Renames the titles of the 'features2' data set to 'V1' and 'V2'.
11. Creates a new columnar data set, titled 'keep_features', that notates "keep" if the 'V2' column in the 'features2' data set contains either 'mean' or 'std', and notates "discard" if the row does not. However, it also notates "discard" for rows that contain 'meanFreq'.
12. Merges the 'keep_features' data set and 'xbind' data set together, titled 'feature_ID'.
13. Creates a new data set, titled 'keep_features1', that only includes the columns containing "keep" in the first row of the 'feature_ID' data set.
14. Removes the first row from the 'keep_features1' data set that was used to identify which columns to keep, in a new data set titled 'keep_features2'.
15. Changes all values in 'keep_features2' data set from character to numeric.
16. Changes the column headers of the data set to be the measurement description variable names.
17. Reads the 'Y_test.txt' data into R.
18. Reads the 'Y_train.txt' data into R.
19. Merges the 'Y_test.txt' and 'Y_train.txt' data together, by rows, into a new data set named 'ybind'.
20. Creates an additionl column on the 'ybind' data set that gives the activity description associated with the numeric activity identifiers, and titles the data set 'descr'.
21. Merges the 'activity' data sets activity descriptions column with the 'keep_features3' data set in a new data set titled 'activity_id'.
22. Renames the activity descriptions column of the 'activity_id' to 'activity'.
23. Reads the 'subject_test.txt' data into R.
24. Reads the 'subject_train.txt' data into R.
25. Merges the 'subject_test.txt' and 'subject_train.txt' data together, by rows, into a new data set named 'subjectbind'.
26. Renames the single column in the 'subjectbind' data set to 'subject'.
27. Merges the 'subjectbind' data set with the 'activity_id' data set, by columns, into a new data set names 'final_bind'.
28. Computes the averages of measurement description variable columns from the 'final_bind' data set by the 'activity' and 'subject' columns in a new data set titled 'averages'.
29. Creates a new data set, titled 'tidy', that sorts the 'averages' data set by the 'activity' column descending order, and then by the 'subject' column descending order.
30. Writes the 'tidy' data set into a .txt file and places it in the "./data" folder of the working director.

END PROGRAM
