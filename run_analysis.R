# Read in raw training data.
X_train <- read.table("Coursera/Getting-And-Cleaning-Data/UCI HAR Dataset/train/X_train.txt", header = F)
Y_train <- read.table("Coursera/Getting-And-Cleaning-Data/UCI HAR Dataset/train/Y_train.txt", header = F)
subject_train <- read.table("Coursera/Getting-And-Cleaning-Data/UCI HAR Dataset/train/subject_train.txt", header = F)

# Combine training data sets into one table.
training <- cbind(X_train, Y_train, subject_train)

# Read in raw test data
X_test <- read.table("Coursera/Getting-And-Cleaning-Data/UCI HAR Dataset/test/X_test.txt", header = F)
Y_test <- read.table("Coursera/Getting-And-Cleaning-Data/UCI HAR Dataset/test/Y_test.txt", header = F)
subject_test <- read.table("Coursera/Getting-And-Cleaning-Data/UCI HAR Dataset/test/subject_test.txt", header = F)

# combine test data sets into one table.
test <- cbind(X_test, Y_test, subject_test)

# Combine test and training data into one table.
data <- rbind(training, test)

# Read in activity labes and features data sets.
activity_labels <- read.table("Coursera/Getting-And-Cleaning-Data/UCI HAR Dataset/activity_labels.txt", header = F)
features <- read.table("Coursera/Getting-And-Cleaning-Data/UCI HAR Dataset/features.txt", header = F)

# Change feature names containing "-mean" and "-std" to "Mean" and "Std" so all names have same format.
features[,2] = gsub("-mean", "Mean", features[,2])
features[,2] = gsub("-std", "Std", features[,2])
# Remove any parenthsis, dashes or brackets from feature names.
features[,2] = gsub("[-()]", "", features[,2])

# Only get feature names that contain "Mean" and "Std".
features_names <- grep(".*Mean.*|.*Std.*", features[,2])
features <- features[features_names,]

# Add last two column indexes to features_names, so can subset data and keep Y_test and subject_test
features_names <- c(features_names, 562, 563)
data <- data[,features_names]

# Give activity and subject columns descriptive column names.
colnames(data) <- c(features$V2, "Activity", "Subject")

# Replace activity number with its actual activity name.
# Make activity and subject columns into factor types.
data$Activity <- factor(data$Activity, levels = activity_labels$V1, labels = activity_labels$V2)
data$Subject <- as.factor(data$Subject)

# Aggregate data by activity and subject, taking the mean of each variable for each activity and each subject.
tidy_data <- aggregate(data, by=list(Activity = data$Activity, Subject = data$Subject), mean)
# Remove last two Activity and Subject rows since they are now Null after aggregation.
tidy_data <- tidy_data[,1:88]

write.table(tidy_data, "Coursera/Getting-And-Cleaning-Data/tidy.txt", sep="\t", row.names=FALSE)
