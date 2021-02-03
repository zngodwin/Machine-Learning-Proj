install.packages("neuralnet")
library("neuralnet")

setwd("/Users/Zac/Desktop/Assignment 4")
fishing <- read.csv(file="phishing.csv", head = TRUE)
fishing2 <- read.csv(file="phishing2.csv", head = TRUE)
fishing3 <- read.csv(file="phishing3.csv", head = TRUE)

head(fishing)
summary(fishing)

#scaling is for the work function
fishing[1:30]<-scale(fishing[1:30])
fishing2[1:20]<-scale(fishing2[1:20])
fishing3[1:10]<-scale(fishing3[1:10])

set.seed(12345)
ind <- sample(2, nrow(fishing), replace = TRUE, prob = c(0.7, 0.3))
train.data <- fishing[ind == 1,]
test.data <- fishing[ind ==2,]

names(fishing)
View(fishing)
labels(fishing)

#nn form for all attributes
form = Result~Request_URL+URL_of_Anchor+Links_in_tags+SFH+Submitting_to_email+Abnormal_URL+Redirect+on_mouseover+RightClick+popUpWidnow+Iframe+age_of_domain+DNSRecord+web_traffic+Page_Rank+
  Google_Index+Links_pointing_to_page+Statistical_report

##nn form for binary attributes
form.bin = Result~having_IP_Address+Shortining_Service+having_At_Symbol+double_slash_redirecting+Prefix_Suffix+Domain_registeration_length+Favicon+port+HTTPS_token+Submitting_to_email+
  Abnormal_URL+on_mouseover+RightClick+popUpWidnow+Iframe+age_of_domain+DNSRecord+Page_Rank+Google_Index+Statistical_report

##nn form for ternary attributes
form.Trn = Result~URL_Length+having_Sub_Domain+SSLfinal_State+URL_of_Anchor+Links_in_tags+SFH+web_traffic+Links_pointing_to_page+Request_URL+Redirect

#workhorse
nn<-neuralnet(form, data = train.data, hidden=2, act.fct="tanh", linear.output = FALSE)
names(nn)
nn$call
nn$response
nn$weights
nn$result.matrix #
nn$covariate #
nn$model.list 
nn$net.result

#predicted probabilites
nn$net.result[[1]][1:10]
nn$startweights
nn$result.matrix
plot(nn)

mypredict<-compute(nn, nn$covariate)$net.result
mypredict<-apply(mypredict, c(1), round)
table(mypredict, train.data$Result, dnn =c("Predicted", "Actual"))

testPred <- compute(nn, test.data[, 0:18])$net.result #of variables consided for nn
testPred<-apply(testPred, c(1), round)
table(testPred, test.data$Result, dnn =c("Predicted", "Actual"))
