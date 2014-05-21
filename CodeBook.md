Getting and Cleaning Data Course Project CodeBook
=================================================

This codebook will describe the variables, data and any transformations or work I performed to clean up the data.

Note on all my variable names, including those tidied for this assignment: I use camel case. It is tidy because it is more human readable than trying to make a variable likethiswhereallthewordsruntogether. This isMuchEasierToRead, and thus more tidy, as human readable is one point of being tidy.

##Step One: Merge
*Read each file in after going through the data README and each data file to determine what it contains
*Acquaint yourself with the data by exploring its dimensions and variable names and snippets of the data itself
*Add the Subject and Activity columns to the test and train data, respectively. These data sets are called AllTest and AllTrain.
*Merge the test and train data into one dataframe, called AllData
*Ensure the Merge went properly

###About the Data
X_train.txt and X_test.txt both contain observations for 561 different variables which are explained further in the data's README file.
subject_train.txt and subject_test.txt contain the subject ID for the person who performed each of those observations.
y_train.txt and y_test.txt contain the activity ID for the activity the person was performing during each of those observations.
The Intertial Signals folders were ignored based on advice from the discussion forums.
The activity_labels.txt file is the code for what the activity IDs mean.
The features.txt file contains the variable names for the columns in the X_train.txt and X_test.txt files.
The features_info.txt file explains the variable naming scheme.

##Step Two: Extract
Use the features.txt file, stored into FeatureNames, to change the names of the first 561 variables in AllData
*Note you need to use FeatureNames$V2 since the second column is the one that contains the names.
*Note also that you don't change all the names because the last two columns are the Subject and Activity columns you already added and named

###mean() and std()
How I chose which variables to include in the subset of the data that extracts mean and standard deviation measurements: The "features_info.txt" file says that a number of functions were applied to each feature, including a mean() and std() function. The project instructions said to extract only those measurements which had these functions applied to them. Since the features were renamed based on the function that was applied to them, all the features the had the mean() and std() function applied to them contained the string "mean()" or "std()". Thus, I used grepl to choose all features that contained these strings. I also kept the Subject and Activity columns, which are necessary for other analyses. I did not include any other columns that had the words mean or std in them because these were not a direct application of the functions specified in the "features_info.txt" file. This was my interpretation.
This data is stored in MeanSTDsubset.

##Step Three: Describe
I took the lead from the activity_labels.txt file to label each activity, rather using camelCase for reasons described above.
Example activities: walking, laying, sitting, etc...

##Step Four: Label
Now we need to make those awful column names more tidy. This was done by applying some rules:
*no punctuation
*no abbreviations
*clean up the variable names
I did this by:
*removing hyphens and parenthesis
*replacing t with time and f with frequencyDomainSignal as specified in the features_info.txt file
*elongating abbreviations like Acc for Acceleration and Mag for Magnitude
*removing repeats of the word Body where they appeared
This data is in tidyMeadSTDsubset
Example tidied variables: timeBodyAccelerationstdZ --> was tBodyBodyAcc-std()-Z

##Step Five: Average
*First, melt the tidy data set so that it is organized by Subject and Activity
*Then, cast the melted data set so that each variable is organized by Subject and Activity, while simultaneously performing the mean function
*This results in the variableMeansBySubjectAndActivity data set while contains the mean of every variable organized by Subject and Activity
*Send this table to a file and boom, you're done.