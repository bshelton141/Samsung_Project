if(!file.exists("./data")){dir.create("./data")}                #create a directory to download the file
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"     #create a name for the file link
download.file(fileURL,destfile="./data/JHProject.zip")          #download the file from the link, into the destination folder
unzip("./data/JHProject.zip",exdir="./data")                    #unzip the file
xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")   #read in the x_test file to R
xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")#read in the x_train file to R
xbind <- rbind(xtest,xtrain)                                    #merge the x_test and x_train files together
features <- read.table("./data/UCI HAR Dataset/features.txt")   #read in the features file to R
feat_rem <- gsub("[[:punct:]]", "", features$V2)                #remove punctuations from column V2
features2 <- data.frame(features$V1,feat_rem)
colnames(features2) <- c("V1","V2")
keep_features <- ifelse(grepl("meanFreq",features2$V2), "discard", ifelse(grepl("(mean)|(std)", features2$V2), "keep", "discard")) #returns "keep" for those variables that are means and standard deviations and returns "discard" for all else
feature_ID <- rbind(keep_features,xbind)                        #includes a row to xbind that tells me whether or not the column is a mean or standard deviation measurement
keep_features1 <- feature_ID[,c(feature_ID[1,]=="keep")]         #removes columns that do not measure either the mean or standard deviation
keep_features2 <- keep_features1[-1,]                            #removes the "keep" identifier from the dataset
keep_features3 <- data.frame(lapply(keep_features2,as.numeric)) #changes the values from character to numeric
features2$V1 <- sub("^", "V", features2$V1)                      #adds a "V" to the beginning of column V1, in order to replace headers in keep_features2
names(keep_features3) <- features2$V2[match(names(keep_features3),features2$V1)]  #changes the keep_features2 headers to the actual names of the measurements
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")   #read in the y_test file to R
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")#read in the y_train file to R
ybind <- rbind(ytest,ytrain)                                    #merge the y_test and y_train files together
V1 <- c(1,2,3,4,5,6)            
activity <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
descr_match <- data.frame(V1,activity)                          #creates a dataframe to match the y numeric descriptions with the activity that they represent
library(plyr)           
descr <- join(ybind,descr_match,by="V1")                        #matches the y numeric descriptions of the 10299 obs. with the activity that they represent
activity_id <- cbind(descr$activity, keep_features3)
library(data.table)                                             #loads the package that contains the 'setnames' function
setnames(activity_id, "descr$activity", "activity")             #changes the name of "descr$activity" to "activity"
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")#read in the subject_test file to R
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")#read in the subject_train file to R
subjectbind <- rbind(subject_test,subject_train)
colnames(subjectbind) <- c("subject")
final_bind <- cbind(subjectbind,activity_id)
averages <- aggregate( . ~ activity + subject , data = final_bind , FUN = mean )
tidy <- averages[order(averages$activity,averages$subject),]
write.table(tidy, "./data/Tidy_Data_Set.txt", sep="\t", row.name=FALSE)