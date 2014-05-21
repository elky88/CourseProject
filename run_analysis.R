#1) Merge the training and test sets to create one data set
#First, get the data into R
zippedDataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zippedDataURL, destfile="./data/UCIharData.zip", method="curl")
unzip("./data/UCIharData.zip")
Xtest = read.table("./UCI HAR Dataset/test/X_test.txt")
Xtrain = read.table("./UCI HAR Dataset/train/X_train.txt")
SubjectTest = read.table("./UCI HAR Dataset/test/subject_test.txt")
SubjectTrain = read.table("./UCI HAR Dataset/train/subject_train.txt")
TestLabels = read.table("./UCI HAR Dataset/test/y_test.txt")
TrainLabels = read.table("./UCI HAR Dataset/train/y_train.txt")
FeatureNames = read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=F)
ActivityLabels = read.table("./UCI HAR Dataset/activity_labels.txt")

#do a little digging to see what belongs where
dim(SubjectTrain)
dim(Xtrain)
dim(TrainLabels)
dim(SubjectTest)
dim(Xtest)
dim(TestLabels)

#bind the subject (Subject*) and activities (*Labels) to the main test data (X*)
#first rename the columns in SubjectTest and TestLabels so there are not three V1 variable names in the final data set:
names(SubjectTest)<-"Subject"
names(TestLabels)<-"Activity"
#then bind these columns to the data
AllTest=cbind(Xtest,SubjectTest,TestLabels)
dim(AllTest)
AllTest[1:5, 560:563]

#similarly for Train
names(SubjectTrain)<-"Subject"
names(TrainLabels)<-"Activity"
AllTrain =cbind(Xtrain,SubjectTrain,TrainLabels)
dim(AllTrain)
AllTrain[1:5, 560:563]

#Now merge train and test by using rbind which addends each data set to one another (since we have no common ids, we can't use the R function merge)
AllData = rbind(AllTrain, AllTest)

#Make sure the merge occurred as expected:
#these two sets should be the same
AllData[1:5, 560:563]
AllTrain[1:5, 560:563]
#as should these
AllData[7353:7357, 560:563]
AllTest[1:5, 560:563]

#2) Extract only the measurements on mean and standard deviation for each measurement
#FeatureNames contains the names for the variables, currently labeled V1:V561
dim(FeatureNames)
head(FeatureNames)
FeatureNames$V2
#replace the column names of AllData with these.
names(AllData)
names(AllData)[1:561]
names(AllData)[1:561]<- FeatureNames$V2
names(AllData)

#Now find variable names with "mean()" or "std()" in them
#make list of column names that contain those strings:
wantTheseCols <- c()
for(name in names(AllData)){
  if(grepl("mean\\(\\)", name) | grepl("std\\(\\)", name) | name == "Activity" | name == "Subject"){
    #any column names that are Subject, Activity (columns we want to keep), or contain mean(), or std() (more columns we want to keep), add them to the keep list
    wantTheseCols <- c(wantTheseCols, name)
  }
}
wantTheseCols

MeanSTDsubset <- AllData[wantTheseCols]
dim(MeanSTDsubset)

#these two sets won't be the same, but the values in the last two columns should be, so it is worth it to check
AllData[1:5, 560:563]
MeanSTDsubset[1:5, 65:68]

AllData[7353:7357, 560:563]
MeanSTDsubset[7353:7357, 65:68]

#3) Use descriptive activity names to name the activities in the data set
#(and replace them in the data)
#I personally like the names provided in the "activity_labels.txt" file, so I will use names similar to those
temp = MeanSTDsubset
length = nrow(MeanSTDsubset)
for(i in 1:length){
  val = MeanSTDsubset[i,68]
  if(val==1){newname <- "walking"}
  else if(val ==2){newname <- "walkingUpstairs"}
  else if(val ==3){newname <- "walkingDownstairs"}
  else if(val ==4){newname <- "sitting"}
  else if(val ==5){newname <- "standing"}
  else {newname <- "laying"}
  MeanSTDsubset[i,68] <- newname
}
#testing to make sure it worked.
MeanSTDsubset[,68]
temp[,68]

#4) Appropriately label the data set with the descriptive activity names
#reworded to "replace the column labels with more easily understood versions"
names(MeanSTDsubset)

#create a list of new variable names based on rules for tidying data like remove punctuation and spell out words
newNames <- c()
}
for(name in names(MeanSTDsubset)){
  replaceWith <- gsub("[-\\(\\)]", "", name)
  replaceWith <- gsub("^t", "time", replaceWith) #prefix t means time
  replaceWith <- gsub("Mag", "Magnitude", replaceWith) #Mag means magnitude
  replaceWith <- gsub("Acc", "Acceleration", replaceWith) #Acc means acceleration
  replaceWith <- gsub("^f", "frequencyDomainSignal", replaceWith) #prefix f means frequency domain signal
  replaceWith <- gsub("BodyBody", "Body", replaceWith) #BodyBody isn't necessary. Replace with one Body
  newNames <- c(newNames, replaceWith)
}
newNames
tidyMeanSTDsubset = MeanSTDsubset
names(tidyMeanSTDsubset) <- newNames

#5) Create a second, independent tidy data set with the average of each variable for each activity and each subject
#separate by activity and subject
meltedTidy <- melt(tidyMeanSTDsubset, id = c("Subject", "Activity"))
#this produces a 66*10299 dimension result because we have 66 variables (that aren't Subject or Activity) and 10299 rows on which to separate out those variables
dim(tidyMeanSTDsubset)
dim(meltedTidy)

#now, reshape the data set into a 180 X 68 set that contains rows with the means for each variable done by each subject doing each activity
variableMeansBySubjectAndActivity <- dcast(meltedTidy, Subject + Activity ~ variable, mean)
head(variableMeansBySubjectAndActivity)
dim(variableMeansBySubjectAndActivity)

#write the tidy data set out and post it to the project website!
write.table(variableMeansBySubjectAndActivity, file = "./CourseProject/averagedTidyData.txt", sep = "\t")
