#Clustering Method

install.packages("cluster")
install.packages("readr")
library(readr)

setwd("/cloud/project")
data <- read.csv(file="ionosphere.csv", head=TRUE, sep =",")

summary(data)
str(data)
head(data)
View(data)
table(data$Class)
View(data)

newdata <- data
#newdata[1:18] <- scale(newdata[1:18])
newdata$class <- NULL
#newdata$a01 <- as.numeric(newdata$a01)
#newdata$a02 <- as.numeric(newdata$a02)
newdata$a01 <- NULL
newdata$a02 <- NULL
str(newdata)
head(newdata)

#This code came from https://www.r-bloggers.com/finding-optimal-number-of-clusters/
#Elbow Method for finding the optimal number of clusters
set.seed(123)
# Compute and plot wss for k = 2 to k = 15.
k.max <- 20
wss <- sapply(1:k.max,function(k){kmeans(newdata, k, nstart=50,iter.max = 20 )$tot.withinss})
wss
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")

kc <- kmeans(newdata, 5)
print(kc)
kc$betweenss
kc$withinss
kc$tot.withinss
kc$iter
kc$totss

table(data$class, kc$cluster)
clusplot(newdata, kc$cluster, coor=TRUE, shade=TRUE, labels=2, lines=0)


