##Read Me Document

This readme document will explain step by step the code that is used to import the data and clean it to be in the proper format according to the instructions
for the "Getting and Cleaning Data Course Project" for coursera. This took me longer than it should have because it took me longer than it should have to 
identify what I actually had to do and that I don't think i had to mess with the data in the "inertial signals" folder. However, once I figured out what I actually
needed to do, the code was not actually too bad. I guess I just had trouble understanding the original readme.md that came with the downloaded data.
I only say this because if I ended up doing the assignment wrong or did not do the right thing, it is because I misinterpreted what I was actually supp


Step 1: The first step is that I wrote a if statement that will download the zip file if the zip file is not downloaded and then the file is unzipped

Step 2: Reading in the Data after unzipping it so I can understand what file there are and what I need to upload.

Step 3: Import the training dataset from the folder and then after importing the training dataset, I made sure to rename the columns in those dataframes
so that when I combine all the data together in the same step. Then, I want to arrange the data so that when I use glimpse() or str() that the data starts in order even
though when I combine it later on, it will remove that ordering. This was combined into the full_train dataframe

Step 4: Here, I repeated the exact same thing where I imported the test data into R and changed the names and then combined all the data into the full_test dataframe

Step 5: Then, I use rbind to bind the rows of the full_train and full_test dataframes together so that they are combined into a single merged dataframe

Step 6: I extracted the column names from the features.txt file adn then applied them to the merged dataset so that each column has the appropriate name of what it is actually measuring

Step 7: Using a combination of the janitor package and the clean_names() function along with using gsub, I was able to remove the abbrevations in the names for each
column and convert it into the full name so that it is easier to understand what is being measured

Step 8: Then, I was able to group the data by subject_activity, subject_id and subject_type and use the summarize function from the dplyr package to calculate 
the mean of each column for each grouping.

Step 9: I recoded the subject_activity so that the numbers in the dataframe of the dataset is converted to what activity is actually being performed per the
activity_labels.txt file

Step 10: Then, I wrote the dataframe into a txt file and labeled it Tidy_Data.txt



NOTE: The run_analysis_copy.R is my original file writing the code before I realize that I might have been doing it wrong, so I wrote made a copy and made
ther relevant changes in the run_analysis.R file which is to be read. I didn't want to delete it and I find the github and version control, at least at this moment,
still confusing to understand.