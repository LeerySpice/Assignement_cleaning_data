rm(list = ls())
start.time <- Sys.time()

# Step1. Merges the training and the test sets to create one data set.
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_s <- read.table("./UCI HAR Dataset/test/subject_test.txt")
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_s <- read.table("./UCI HAR Dataset/train/subject_train.txt")

data <- rbind(test_x,train_x)
label <- rbind(test_y,train_y)
subject <- rbind(test_s,train_s)
rm(list = ls(pattern = "_"))

# Step2. Extracts only the measurements on the mean and sd for each measurement. 
features <- read.table("./UCI HAR Dataset/features.txt")
data <- data[,grep("mean\\(\\)|std\\(\\)", features[,2])]
colnames(data) <- grep("mean\\(\\)|std\\(\\)", features[,2], value = TRUE)

# Step3: Uses descriptive activity names to name the activities in the data set
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
label[,1] <- as.character(activity[label[,1],2])

# Step4. Appropriately labels the data set with descriptive variable names.
DF <- data.frame(data=data, activity=label, subject=subject)

# Step5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject 
colnames(DF)[67] <- "activity"
colnames(DF)[68] <- "subject"

DFT <- c()
for(i in 1:length(table(subject))){
  for (j in 1:length(activity$V1)){
    k <- colMeans(DF[(DF$subject==i | DF$activity == activity$V2[j]),1:66])
    DFtidy <- data.frame(subject = i, activity = activity$V2[j], t(k))
    DFT <- rbind(DFT, DFtidy)
  }
}

dim(DFT)
# [1] 180  68

saveRDS(DFT, file = "./DF_tidy.rds") #Tidy data clean
saveRDS(DF, file = "./DF_total.rds" ) # merged total DF

Sys.time() - start.time
write.table(DFT, file = "DFT.csv", row.names = FALSE)
rm(list = ls())



