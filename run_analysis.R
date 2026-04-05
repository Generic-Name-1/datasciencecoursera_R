#Step 1: Import the data after downloading

library(here)

File <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if ( file.exists() == FALSE) {
  
  #temp_download <- tempfile(pattern = "file", fileext = ".zip")
  
  olddir <- getwd()
  
  new_dir <- paste(here(),"/Getting_and_Cleaning_Data_Module3/Getting_and_Cleaning_data_Course_Project_Assignment/", sep = "")
  
  setwd(new_dir)
  
  download.file(url = File, destfile = , method = "curl")  
  
  unzip(new_dir, exdir = ".")
  
  names_of_files <- unzip(temp_download, list = TRUE)
  
  setwd(olddir)
  
}

  olddir <- getwd()
  #Step 2: Reading in the Data after unzipping it
  list.files(file.path(new_dir,"UCI HAR Dataset/train")
  

  #Step 3: Import the Base Training Data

 train_files <- list.files(file.path(new_dir,"UCI HAR Dataset/train/"), full.names = TRUE) 
 print(train_files)
 
 subject_train <- read.table(file.path(new_dir,"UCI HAR Dataset/train/subject_train.txt"))
 x_train <- read.table(file.path(new_dir,"UCI HAR Dataset/train/x_Train.txt"))
 y_train <- read.table(file.path(new_dir,"UCI HAR Dataset/train/y_train.txt"))
 
  colnames(subject_train) <- "Subject_ID"
  colnames(y_train) <- "Subject_Activity"
  full_train <- cbind(subject_train, y_train, x_train)
  
  full_train$Subject_Type <- "Train" 
  
  full_train <- full_train %>% 
    group_by(`Subject ID`) %>% 
    arrange(., `Subject Activity`, .by_group = TRUE ) %>% ungroup()
 
  
  #Step 4: Import the Base Test Data
  
  test_files <- list.files(file.path(new_dir,"UCI HAR Dataset/test/"), full.names = TRUE) 
  print(test_files)
  
  subject_test <- read.table(file.path(new_dir,"UCI HAR Dataset/test/subject_test.txt"))
  x_test <- read.table(file.path(new_dir,"UCI HAR Dataset/test/X_test.txt"))
  y_test <- read.table(file.path(new_dir,"UCI HAR Dataset/test/y_test.txt"))
  
  colnames(subject_test) <- "Subject_ID"
  colnames(y_test) <- "Subject_Activity"
  full_test <- cbind(subject_test, y_test, x_test)
  
  full_test$Subject_Type <- "Test" 
  
  
  #Step 5: Create the combined dataset and re-arrange the columns (not necessary)
  
  Merged_Set <- rbind(full_train, full_test)
  
  Merged_Set <- Merged_Set %>% relocate(., Subject_Type)
  
  #Step 6: Get the names of each of the columns and rename the columns
  
  
  features <- read.table(file.path(new_dir,"UCI HAR Dataset/features.txt")) 
  features <- features %>% select(V2)
  features_2 <- c(features$V2)
  
  colnames(Merged_Set)[4:length(colnames(Merged_Set))] <- features_2
  
  #Step 7: Make the Column Names Tidy
  
  library(janitor)
  
  Merged_Set <- Merged_Set %>% 
    clean_names() 
  
  colnames(Merged_Set) <- gsub(colnames(Merged_Set), pattern = "t_body_acc", replacement = "total_body_acceleration")
  colnames(Merged_Set) <- gsub(colnames(Merged_Set), pattern = "tGravityAcc", replacement = "total_gravity_acceleration")
  colnames(Merged_Set) <- gsub(colnames(Merged_Set), pattern = "f_body_acc", replacement = "frequency_body_acceleration")
  colnames(Merged_Set) <- gsub(colnames(Merged_Set), pattern = "fGravityAcc", replacement = "frequency_gravity_acceleration")
  
  
  # Step 8: Select the Columns where the data can be used for finding the mean of the columns that contains the standard deviations
  
  Subset_Merged <- Merged_Set %>% 
    select(contains("Subject") | contains(c("mean", "std")))
  
  mean_subset <- Subset_Merged %>%
    group_by(subject_type,subject_id, subject_activity) %>%
    summarize(across(everything(), mean))
  
  #Step 9: Recode the Subject Activity
  
  mean_subset <- mean_subset %>%
    ungroup() %>%
    mutate(subject_activity = as.numeric(subject_activity)) %>% 
    #mutate(subject_activity = factor(subject_activity), levels = c(1:6)) %>%
    mutate(subject_activity = recode(subject_activity,
                 `1` = "WALKING",
                 `2` = "WALKING_UPSTAIRS",
                 `3` = "WALKING_DOWNSTAIRS",
                 `4` = "SITTING",
                 `5` = "STANDING",
                 `6` = "LAYING")))
  
  #Step 10: Export the data
  olddir <- getwd()
  
  setwd(file.path(new_dir,"UCI HAR Dataset/"))  
  
  write.table(mean_subset, file = "Tidy_Data.txt")
  
  setwd(olddir)
      
 