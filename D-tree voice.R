#Zachary Godwin
#Data 630
#Assignment 3

#install and loadpackage into memory
install.packages("party")
library("party")
library(e1071)
library(rpart)
install.packages("mlbench")

#Set the working directory and read the csv
setwd("/cloud/project")
voice <- read.csv(file="voice.csv", head=TRUE, sep=",")

#Data exploration
str(voice)
View(voice)
summary(voice)
#Decesion tree method, split data into training and test data
set.seed(5678)
index <- sample(2, nrow(voice), replace = TRUE, prob = c(0.7, 0.3))
train.voice <- voice[ind ==1,] 
test.voice <- voice[ind ==2,]

#Implements decision tree funcition
myformula <- label~.
voice_ctree <- ctree(myformula, data = train.voice)
print(voice_ctree)
plot(voice_ctree)
plot(voice_ctree, type="simple")

#Generates the confusion matrix
table(predict(voice_ctree), train.voice$label)
prop.table(table(predict(voice_ctree), train.voice$label))

#Implements model on test data
testPred <- predict(voice_ctree, newdata = test.voice)
table (testPred, test.voice$label)
prop.table(table(predict(voice_ctree, test.voice), test.voice$label))
plot(testPred)

#svm
svm.model<- svm(label~., data = train.voice, cost=100, gamma=1)
svm.pred <- predict(svm.model, test.voice)
print(svm.model)
plot(svm.pred,  ylim = c(0,600))
table(pred = svm.pred, true=test.voice$label)
prop.table(table(predict(svm.model, test.voice), test.voice$label))

#Alternative method
rpart.model <- rpart(label~., data=train.voice)
rpart.pred <- predict(rpart.model, test.voice, type="class")
plot(rpart.pred)
table(pred = svm.pred, true=test.voice$label)
