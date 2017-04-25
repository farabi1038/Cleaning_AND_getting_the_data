#Loading the packages
packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)
#fileName
file<-"getdata_projectfiles_UCI HAR Dataset.zip"


#download the file if it is not in the directory
if (!file.exists(file)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(fileURL, destfile = file, method="curl")
} 
#Unzip the file if is not unzipped already
if (!file.exists("UCI HAR Dataset")) { 
    unzip(file) 
}
#Getting the activity levels and features 
actL <- read.table("UCI HAR Dataset/activity_labels.txt")
actL[,2] <- as.character(actL[,2])
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]
measurements <- gsub('[()]', '', measurements)

#Getting th test set

tt <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
ttAct <- read.table("UCI HAR Dataset/test/Y_test.txt")
ttSub <- read.table("UCI HAR Dataset/test/subject_test.txt")
tt <- cbind(ttSub, ttAct, tt)

#Getting the training sets
tn <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
tnAct <- read.table("UCI HAR Dataset/train/Y_train.txt")
tnSub <- read.table("UCI HAR Dataset/train/subject_train.txt")
tn <- cbind(trainSubjects, trainActivities, tn)

#merging the data from training and data set after cbinding 
allData <- rbind(tn, tt)
#assigning column names
colnames(allData) <- c("subject", "activity", measurements)
#Changuing this to factor 
allData$subject <- as.factor(allData$subject)
allData$activity <- factor(allData$activity, levels = actL[,1], labels = actL[,2])
allData$subject <- as.factor(allData$subject)

#Melting the data
allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

#Creating the tidy data set 
write.table(allData.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)
