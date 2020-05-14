library(parallel)
library(doParallel)

cluster <- makeCluster(detectCores() - 1) # convention to leave 1 core for OS
registerDoParallel(cluster)


library(caret)
library(dplyr)

setwd("~/Sync/R/training/08-PracticalMachineLearning/week4/project")

fullTraining <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv")
fullTesting <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv")

trainingNAs <- colSums(is.na(fullTraining))
sum(trainingNAs>0)

allNaCols <- colSums(is.na(fullTesting)) == nrow(fullTesting)
naColsToRemove <- c("X", names(fullTesting)[allNaCols])
sum(allNaCols)

testSubSet <- fullTesting %>%
    select(-all_of(naColsToRemove))

nzvIdx <- nearZeroVar(testSubSet)
names(testSubSet)[nzvIdx]

testSubSet <- testSubSet %>% select(-new_window, -problem_id)
trainingColumnsToRemove <- c("X", naColsToRemove, "new_window")
trainSubSet <- fullTraining %>% select(-all_of(trainingColumnsToRemove))

inTraining <- createDataPartition(trainSubSet$classe, p = .75, list=FALSE)
training <- trainSubSet[inTraining,]
testing <- trainSubSet[-inTraining,]

x <- training[,-58]
y <- training[,58]

fitControl <- trainControl(method = "cv",
                           number = 5,
                           allowParallel = TRUE)

my_model <- train(x, y, method="rf", data=training, trControl = fitControl)

saveRDS(my_model, "model2.rds")
my_model <- readRDS("model2.rds")


stopCluster(cluster)
registerDoSEQ()

cMrf <- confusionMatrix(predict(my_model, newdata = testing), testing$classe)
cMrf$overall




# Workaround, class mismatch in model between training and test
testSubSet <- rbind(trainSubSet[1, -58] , testSubSet)
testSubSet <- testSubSet[-1,]

predictTest <- predict(my_model, newdata = testSubSet)
predictTest

plot(my_model)
