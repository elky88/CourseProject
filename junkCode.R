#Junk Code from course project
#rbind, which just addends the one data set onto the other, the variable (aka column) names must be the same. I check this the following way:
setdiff(names(AllTest), names(AllTrain))

#The row names must also not be the same, so I change the row names:
row.names(AllTrain) <- paste(row.names(AllTrain), ".train", sep="")
row.names(AllTest) <- paste(row.names(AllTest), ".test", sep="")
row.names(AllTrain)
row.names(AllTest)

#Now "merge" the data sets
head(AllData)
dim(AllData)
names(AllTrain)

class(AllTrain)
class(AllTrain$V1)
class(AllTrain$Subject)
AllTrain$Subject


#testing
#myList = c("fBodyAccJerk-mean()-Z", "fBodyBodyAccJerkMag-std()","Subject", "Activity", "tGravityAcc-std()-X" )
#for(name in myList){