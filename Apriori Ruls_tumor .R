#Zachary Godwin
#DAta 630
#Exercies 1

#Load the data display first 6 lines and structure
setwd("/Users/Zac/Desktop/Data 630/Assignment 1")
data <- read.csv(file="primary-tumor.csv", head=TRUE, sep=",")

head(data)
str(data)
summary(data)
names(data)
attributes(data$class)
levels(data$degree.of.diffe)
# The number of missing values for each row
apply(data, 1, function (data) sum(is.na(data)))

#The number of missing values for each variable
apply(data, 2, function (data) sum(is.na(data)))

#define var
age <- grep("age=", itemLabels(rules), value=TRUE)
sex <- grep("sex=", itemLabels(rules), value=TRUE)
hist <- grep("histologic.type=", itemLabels(rules), value=TRUE)
deg <- grep("degree.of.diffe=", itemLabels(rules), value=TRUE)
yes <- grep("=yes", itemLabels(rules), value=TRUE)

#rules

#_______________________________________________________________
#Generated apriori rules for all instances
rules <- apriori(data, parameter = list(supp=0.4, conf=0.6, minlen=1))
inspect(rules[1:10])
inspect(subset(rules, subset = rhs %pin% c("=yes")))
inspect(subset(rules, subset = lhs %pin% c("=yes")))

#removing redundent rules
rules.sorted <- sort(rules, by="lift")
subset.matrix <- is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- F
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned[1:15])
plot(rules.pruned, method="graph", control=list(type="items"))
plot(rules.pruned)
plot(rules.pruned[1:10], method="graph")
summary(rules.pruned)
#__________________________________________________________________
#Change confidence and support and inspect new values
newrules <- apriori(data, parameter = list(supp=0.23, conf=0.2, minlen=3), 
                    appearance = list(rhs=c(yes), default="lhs"))

inspect(subset(newrules, subset = rhs %pin% c("=yes")))
inspect(subset(newrules, subset = lhs %pin% c("=yes")))

newrules.sorted <- sort(newrules, by="lift")
newsubset.matrix <- is.subset(newrules.sorted, newrules.sorted)
newsubset.matrix[lower.tri(subset.matrix, diag=T)] <- F
newredundant <- colSums(newsubset.matrix, na.rm=T) >= 1
which(newredundant)
newrules.pruned <- newrules.sorted[!newredundant]
inspect(newrules.pruned[1:10])
plot(newrules.pruned[1:10], method="graph", control=list(type="items"))
plot(newrules.pruned)

newrules.sorted <- sort(newrules, by="confidence")
inspect(newrules.sorted[1:15])
newrules.sorted <- sort(newrules, by="support")
inspect(newrules.sorted[1:15])

summary(newrules.pruned)
levels(data$class)
str(data$class)


#____________________________________________________________
#searches for cross section of metastasized tumor via contraining lhs and rhs

#define some more variable
bone<- grep("bone=", itemLabels(rules), value=TRUE)
bone.marrow<- grep("bone.marrow=", itemLabels(rules), value=TRUE)
lung<- grep("lung=", itemLabels(rules), value=TRUE)
pleura<- grep("pleura=", itemLabels(rules), value=TRUE)
liver<- grep("liver=", itemLabels(rules), value=TRUE)
brain<- grep("brain=", itemLabels(rules), value=TRUE)
skin<- grep("skin=", itemLabels(rules), value=TRUE)
neck<- grep("neck=", itemLabels(rules), value=TRUE)
supraclavicular<- grep("supraclavicular=", itemLabels(rules), value=TRUE)
axillar<- grep("axillar=", itemLabels(rules), value=TRUE)
mediastinum<- grep("mediastinum=", itemLabels(rules), value=TRUE)
abdominal<- grep("abdominal=", itemLabels(rules), value=TRUE)

classrules <- apriori(data, parameter = list(supp=0.23, conf=0.2, minlen=2), 
                      appearance = list(lhs=c(age,sex,hist,deg,bone, bone.marrow, lung, pleura, liver, brain,
                                              skin, neck, supraclavicular, axillar, mediastinum, abdominal),
                                        rhs=c("class='cervix uteri'",
                                              "class='corpus uteri'", 
                                              "class='duoden and sm.int'",
                                              "class='head and neck'",
                                              "class='salivary glands'",
                                              "class=bladder",
                                              "class=breast",
                                              "class=colon",
                                              "class=esophagus",
                                              "class=gallbladder",
                                              "class=kidney",
                                              "class=liver",
                                              "class=lung",
                                              "class=ovary",
                                              "class=pancreas",
                                              "class=prostate",
                                              "class=rectum",
                                              "class=stomach",
                                              "class=testis",
                                              "class=thyroid",
                                              "class=vagina"), default="none"))



#...nothin