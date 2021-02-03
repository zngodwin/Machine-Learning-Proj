#South African Heart Disease 
install.packages("e1071")

#Load the data display first 6 lines and structure
setwd("/Users/Zac/Desktop/Assignment 2")
data <- read.csv(file="SAheart.csv", head=TRUE, sep=",")

head(data)
str(data)
summary(data)
names(data)
apply(data, 2, function(data) sum(is.na(data)))
data[!complete.cases(data)]

#change CHD to a factor 
data$chd <- factor(data$chd)
data$age <- discretize(data$age, method="interval", breaks = 6) 
summary(data$age)

#Naive Bays
set.seed(1234)
ind <- sample(2, nrow(data), replace = TRUE, prob = c(0.7, 0.3))
train.data <- data[ind == 1, ]
test.data <- data[ind == 2, ]
#workhorse function
model<-naiveBayes(pep~., train.data)

