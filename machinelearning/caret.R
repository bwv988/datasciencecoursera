# Caret example
# RS11052015

library(caret)
library(kernlab)
library(e1071)

data(spam)

# Create training set indexes with 75% of data
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)

# Subset spam data to training.
training <- spam[inTrain, ]
# Subset spam data (the rest) to test.
testing <- spam[-inTrain, ]

# Dimension of original and training dataset.
rbind("original dataset" = dim(spam), "training set" = dim(training))

# Fit model.
modelFit <- train(training$type ~ ., method="glm", data=training)
predictions <- predict(modelFit, newdata = testing)
confusionMatrix(predictions, testing$type)