# Human Activity Recognition Using Samsung Galaxy SII
=====================================================
By Ismael González Flores

## General information
======================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Data process
===============
This section describes the code of the **run_analysis.R** file attached in this repossitory.

1. Lines *1-8* contain the names and directories needed to create and read the files.

2. We will need the library **reshape2** to compute the code.
`library(reshape2)`

3. Lines *9 - 18* have the code to download the data if needed and the code to unzip the file.

4. Lines *19 to 24* first create a tebale with tehe activity names and ids and then a new table with the features names and ids.

5. Lines *25 to 32* do the next steps.

5.1 Create a table with `test.x` and assing the names from `features`.

5.2. Create a table from `test.y`and assign the name `Activity` to tha table.

5.3 Create a table with the `test.subject`.

6. On lines *34 to 41* we repeat the steps from **5** but instead of ussing the test files, we will use the **train files**.

The following code is the one necessary to comlete the excercises.

1. Merges the training and the test sets to create one data set.

        data.x<- rbind(train.x, test.x)
        data.y<- rbind(train.y, test.y)
        data.s<- rbind(train.subject, test.subject)
        
2. Extracts only the measurements on the mean and standard deviation for each measurement.

        data.x<- data.x[,grep("mean|std", features$Name)]
        
3. Uses descriptive activity names to name the activities in the data set

        data.y$Activity<- activity[data.y$Activity, ]$Name
        
4. Appropriately labels the data set with descriptive variable names. 

        full.data<- cbind(data.s, data.y, data.x)
        write.csv(full.data, tidy.data)
        
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


        data.mean<- aggregate(full.data, 
                      by=list(Activity=full.data$Activity, Subject=full.data$Subject), 
                      mean)

For purposu of submission  I create the next code to make a table in **.txt** extenssion for submission and a **.csv** file extension to visualize the final tidy data.

        write.table(data.mean, mean.data, row.name=F)
        write.csv(data.mean, mean.data1, row.name=T)