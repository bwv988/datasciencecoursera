# activity_prediction.R - For machine learning course submision.
# RT23052015

#
# Helper function to drop unneccessary columns and transform variables to numberic.
#
preprocess_data <- function(in.df, drop.cols) {
  out.df <- in.df[, -drop.cols]
  t <- apply(out.df[, 1:52], 2, as.numeric)
  out.df <- data.frame(t, classe=out.df[, 53])  
  return(out.df)
}


#
# Helper function for submission prep.
#
pml_write_files = function(x) {
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_", i, ".txt")
    write.table(x[i], file=filename, quote=FALSE, row.names=FALSE, col.names=FALSE)
  }
}


#
# Read the data.
#
training.raw <- read.csv2('~/Dropbox/coursera/data_science/machine_learning/assignment/data/pml-training.csv', sep=',', na.strings=c("#DIV/0!", "", "NA"), row.names = 1)
test.raw <- read.csv2('~/Dropbox/coursera/data_science/machine_learning/assignment/data/pml-testing.csv', sep=',', na.strings=c("#DIV/0!", "", "NA"), row.names = 1)


#
# Pre-processing.
#

# Drop cols 1-6 and all other colls with only NA values in the test set.
drop.cols <- c(1:6,  which(apply(is.na(test.raw), 2, all)==TRUE))
training <- preprocess_data(training.raw, drop.cols)


#
# Build model.
#
library(caret)
library(randomForest)


# Sub-split training data into training and test data so we can later test the model performance.
#in.train <- createDataPartition(y=training$classe, p=0.9, list=FALSE)
in.train <- createDataPartition(y=training$classe, p=0.75, list=FALSE)
#in.train <- createDataPartition(y=training$classe, p=0.1, list=FALSE)
training.train <- training[in.train, ]
training.verify <- training[-in.train, ]

# Build random forest model.
rf.model <- randomForest(classe ~ ., data = training, subset = in.train)

# Prediction on verification set.
predictions.verif <- predict(rf.model, newdata = training.verify)

# Print confusion matrix.
confusionMatrix(predictions.verif, training.verify$classe)


#
# Predict on test set.
#

# Remove last column as it contains the problem id.
test <- preprocess_data(test.raw, drop.cols)
test <- test[, -53]
predictions.check <- predict(rf.model, newdata = test)

#
# Re-build model with full original training set and predict.
#
rf.model.full <- randomForest(classe ~ ., data = training)
predictions.full <- predict(rf.model.full, newdata = test)

# See if predictions concur.
all(predictions.full==predictions.check)


#
# Now use train function in caret package.
# This takes ages to run so only for verification.
#

# 10-fold CV.
library(doMC)
registerDoMC(4)
fitControl <- trainControl(method = "cv", 
                           number = 10,
                           repeats = 1,
                           verboseIter = TRUE, 
                           allowParallel = TRUE)
rf.model.new <- train(classe ~ ., data = training, method="rf", trControl = fitControl, 
                      tuneLength = 1)

predictions.new <- predict(rf.model.new, newdata = test)
all(predictions.full == predictions.new)
