sub_test <- read.table("C:/Users/User/Desktop/R_Practice/Exercise_3_HAR_Samsung/data/test/subject_test.txt")
x_test <- read.table("C:/Users/User/Desktop/R_Practice/Exercise_3_HAR_Samsung/data/test/X_test.txt")
y_test <- read.table("C:/Users/User/Desktop/R_Practice/Exercise_3_HAR_Samsung/data/test/y_test.txt")
sub_train <- read.table("C:/Users/User/Desktop/R_Practice/Exercise_3_HAR_Samsung/data/train/subject_train.txt")
x_train <- read.table("C:/Users/User/Desktop/R_Practice/Exercise_3_HAR_Samsung/data/train/X_train.txt")
y_train <- read.table("C:/Users/User/Desktop/R_Practice/Exercise_3_HAR_Samsung/data/train/y_train.txt")
features <- read.table("C:/Users/User/Desktop/R_Practice/Exercise_3_HAR_Samsung/data/features.txt")
df_train <- cbind(x_train, sub_train, y_train)
df_test <- cbind(x_test, sub_test, y_test)
df_data <- rbind (df_train, df_test)

features_N <- unlist(lapply(features[,2], as.character))
features_new <- c(features_N, "subjects", "ActivityLabel")

colnames(df_data) <- features_new

colnames(df_data) <- make.names(colnames(df_data), unique = TRUE)

activity <- read.table("C:/Users/User/Desktop/R_Practice/Exercise_3_HAR_Samsung/data/activity_labels.txt")
colnames(activity) <- c("ActivityLabel", "ActivityName")
df_data <- full_join(df_data, activity, by = "ActivityLabel")

tidy_data <- df_data %>%
  group_by(ActivityName, subjects) %>%
  summarise_all(mean) %>%
  select(-ActivityLabel)

write.csv(tidy_data, file = 'C:/Users/User/Desktop/R_Practice/Exercise_3_HAR_Samsung/src/tidy_data.csv')
