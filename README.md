This README markdown file explains how all the scripts in this Repo work and how they are connected.
====================================================================================================

First things first, there is only one script.

I use camel case. It is tidy because it is more human readable than trying to make a variable likethiswhereallthewordsruntogether. This isMuchEasierToRead, and thus more tidy as human readable is the point of tidy.


How I chose which variables to include in the subset of the data that extracts mean and standard deviation measurements:
The "features_info.txt" file says that a number of functions were applied to each feature, including a mean() and std() function. The project instructions said to extract only those measurements which had these functions applied to them. Since the features were renamed based on the function that was applied to them, all the features the had the mean() and std() function applied to them contained the string "mean()" or "std()". Thus, I used grepl to choose all features that contained these strings. I also kept the Subject and Activity columns, which are necessary for other analyses. I did not include any other columns that had the words mean or std in them because these were not a direct application of the functions specified in the "features_info.txt" file. This was my interpretation.