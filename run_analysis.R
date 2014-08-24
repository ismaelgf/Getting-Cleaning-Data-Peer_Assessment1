data<- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
data.dir<- './UCI HAR Dataset'
data.file<- './original-dataset.zip'
tidy.data<- './tidy UCI HAR.csv'
mean.data<- './mean UCI HAR.txt'
library(reshape2)

## Download file if needed
if(file.exists(data.file)==FALSE){
        download.file(data, destfile= data.file, method="curl")
}

## Unzip file if needed
if ( file.exists(data.dir)==FALSE){
        unzip(data.file)
}

## Read activities and features
activity<- read.table(paste(data.dir, "activity_labels.txt", sep="/"), header=F)
names(activity)<- c("ID", "Name")
features<- read.table(paste(data.dir, "features.txt", sep="/"), header=F)
names(features)<- c("ID", "Name")

## Read test files
test.x<-read.table(paste(data.dir, "test", "X_test.txt", sep="/"), header=F)
test.y<-read.table(paste(data.dir, "test", "y_test.txt", sep="/"), header=F)
test.subject<- read.table(paste(data.dir, "test", "subject_test.txt", 
                                sep="/"), header=F)
names(test.x)<- features$Name
names(test.y)<- "Activity"
names(test.subject)<- "Subject"

## Read train files
train.x<-read.table(paste(data.dir, "train", "X_train.txt", sep="/"), header=F)
train.y<-read.table(paste(data.dir, "train", "y_train.txt", sep="/"), header=F)
train.subject<- read.table(paste(data.dir, "train", "subject_train.txt", 
                                sep="/"), header=F)
names(train.x)<- features$Name
names(train.y)<- "Activity"
names(train.subject)<- "Subject"

## Merge train and test
## Excercis 1:
## Merges the training and the test sets to create one data set.
data.x<- rbind(train.x, test.x)
data.y<- rbind(train.y, test.y)
data.s<- rbind(train.subject, test.subject)

## Excercise 2:
## Extracts only the measurements on the mean and 
## standard deviation for each measurement. 
data.x<- data.x[,grep("mean|std", features$Name)]

## Excercise 3:
## Uses descriptive activity names to name the activities in the data set
data.y$Activity<- activity[data.y$Activity, ]$Name

## Excercise 4:
## Appropriately labels the data set with descriptive variable names
full.data<- cbind(data.s, data.y, data.x)
write.csv(full.data, tidy.data)

## Excercise 5:
## Creates a second, independent tidy data set with 
## the average of each variable for each activity and each subject.
data.mean<- aggregate(full.data, 
                      by=list(Activity=full.data$Activity, Subject=full.data$Subject), 
                      mean)
data.mean[,3]=NULL
data.mean[,3]=NULL
write.table(data.mean, mean.data, row.name=F)
