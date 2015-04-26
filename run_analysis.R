# load required libraries
library(dplyr)
library(tidyr)
library(data.table)

# load in common tables needed for lookup and labeling later
activity.labels <- read.table("data/activity_labels.txt")
features <- read.table("data/features.txt")

# load in all test data
x.test <- read.table("data/test/X_test.txt")
y.test <- read.table("data/test/y_test.txt")
subject.test <- read.table("data/test/subject_test.txt")

# combine all test data to one test data frame
full.test <- cbind(subject.test, y.test, x.test)

# load in all train data
x.train <- read.table("data/train/X_train.txt")
y.train <- read.table("data/train/y_train.txt")
subject.train <- read.table("data/train/subject_train.txt")

# combine all train data to one train data frame
full.train <- cbind(subject.train, y.train, x.train)

# combine test and train data to one full data set
full.dataset <- rbind(full.test, full.train)

# turn it into a tbl_df for use with dplyr and tidyr
full.tbl <- tbl_df(full.dataset)

# give descriptive names to first two columns merged from common tables above
colnames(full.tbl)[1] <- "subject.id"
colnames(full.tbl)[2] <- "activity.type"

# define measurements we want extracted
mean.ids <- features$V1[grep("mean", features$V2)]
std.ids <- features$V1[grep("std", features$V2)]
all.ids <- c(mean.ids, std.ids)

# label activity types (names in activity table should be descriptive enough)
full.tbl <- full.tbl %>%
  mutate(activity.type.desc = activity.labels$V2[activity.type])

# reduce full table to only the variables we care about
full.tbl <- full.tbl %>% 
  select(subject.id, activity.type.desc, all.ids + 2)

# label variable names (names in feature table should be descriptive enough).
# note: reference code book for full definition of variables
setnames(full.tbl, 
         old = colnames(full.tbl[3:81]), 
         new = as.character(features$V2[all.ids]))

# make table for step 5.
# averages of measurements for each activity for each subject
subject.activity.averages.tbl <- full.tbl %>%
  group_by(subject.id, activity.type.desc) %>%
  summarise_each(funs(mean))

# write out table for step 5
write.table(subject.activity.averages.tbl,
            "data/step5-subject-activity-averages.txt",
            row.names = FALSE)

