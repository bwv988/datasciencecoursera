# run_analysis.R - Perform cleaning and analysis.

# X - 561 feature vector.
# subject - The subject carrying out the activity.
# y - The activity.

kPathPrefix <- "UCI HAR Dataset"
kFileList <- c("X", "subject", "y")
kKindPrefix <- c("test", "train")
kActivity <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
               "SITTING", "STANDING", "LAYING")

MergeSets <- function() {
  # Generate the filenames for the test and training sets.
  allFilesTest <- paste(kPathPrefix, "/", kKindPrefix[1], "/", kFileList, "_", kKindPrefix[1], ".txt", sep="")
  allFilesTrain <- paste(kPathPrefix, "/", kKindPrefix[2], "/", kFileList, "_", kKindPrefix[2], ".txt", sep="")
  
  # Read the list of variable names.
  features <- read.table(paste(kPathPrefix, "/", "features.txt", sep=""), 
                         colClasses=c("integer", "character"), sep=" ")
  
  # Only select mean and standard deviation columns.
  features$V2[which(!features$V2 %in% features$V2[grep("mean|std", features$V2)])] <- "NULL"
  
  # Merge the training and the test sets to create one data set.    
  # Only include the selected column names.
  col.classes <- ifelse(features$V2=="NULL", "NULL", "numeric")
    
  # Load the test data.
  data <- read.table(allFilesTest[1], colClasses=col.classes)
  data <- cbind(data, read.table(allFilesTest[2]))
  data <- cbind(data, read.table(allFilesTest[3]))     
  
  # Load the training data.
  data2 <- read.table(allFilesTrain[1], colClasses=col.classes)
  data2 <- cbind(data2, read.table(allFilesTrain[2]))
  data2 <- cbind(data2, read.table(allFilesTrain[3]))     
  
  # Merged data.
  data <- rbind(data, data2)
    
  # Set column names.
  col.names <- features$V2[features$V2 != "NULL"]  
  
  # Remove "()" and "-" from column names.
  col.names <- gsub("\\(\\)", "", col.names)  
  col.names <- gsub("-", ".", col.names)  
  names(data) <- c(col.names, "subject", "activity")
  
  # Replace activity data with meaningful names.
  for(i in 1:length(kActivity)) {
    data$activity[data$activity == i] <- kActivity[i]  
  }
  
  num.rows <- length(unique(data$subject)) * length(kActivity)
  
  # Pre-allocate data frame for efficiency.
  data.new <- data.frame(matrix(nrow=num.rows, ncol=length(col.names) + 2))    
  count <- 1
  for(act in kActivity) {
    for (subj in unique(data$subject)) {      
      subs <- data[data$activity==act & data$subject==subj,]
      # Remove last 2 columns and calculate column mean.
      result <- colMeans(subs[, 1:(dim(subs)[2]-2)])            
      data.new[count, ] <- c(as.numeric(result), subj, act)
      count <- count + 1
    }
  }
  
  names(data.new) <- c(paste("Mean.of.", col.names, sep=""), "subject", "activity")
 
  # Create output files.
  write.table(data, "data_combined_tidy.txt", quote=FALSE, sep="\t")
  write.table(data.new, "data_means_tidy.txt", quote=FALSE, sep="\t")
  
  # Write variables names (for codebook)
  listOfVariables <- data.frame(names(data.new))
  write.csv(listOfVariables,"listOfVariables.csv")
  
  # Return the modified datasets.
  list(data=data, data.new=data.new)
}