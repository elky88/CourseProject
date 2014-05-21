README for Course Project Scripts
=================================
This README markdown file explains how all the scripts in this Repo work and how they are connected.

##The Script
First things first, there is only one script. It is called run_analysis.R.

This script does the five things stated in the course assignment. The result is a tidy data set stored as "averagedTidyData.txt" with the following properties:
* 180 rows and 68 columns
* Column 1 specifies the ID number of the Subject
* Column 2 specifies the Activity that Subject was performing
* Columns 3 through 68 specify the mean for each variable of the values that variable took while the Subject was performing that specific Activity

The script does not require you to have the data downloaded. It will run in your current working directory.

The script is fairly well commented, indicating what the various steps of the course assignment were and how the script completes them.

##The CodeBook
The CodeBook.md file specifies the variables, the data, and the transformations done to clean the data. It also has a good description of the steps of the assignment and how the script completes these.

##Original Data
The Original Data and course project can be found at the following URL: https://class.coursera.org/getdata-003/human_grading/view/courses/972136/assessments/3/submissions

The End.