# IDS 572: homework 1


# install.packages("rattle")
# install.packages("rpart.plot")
# install.packages("ggplot2")
# install.packages("knitr")

library(rpart)
library(party)
library(rpart.plot)
library(ggplot2)
library(MASS)
library(plyr)
library(dplyr)
library(tibble)
library(knitr)
library(RColorBrewer)


set.seed(1234)

# you can just update the app

path = "C:/Users/jkasongo/Documents/UIC/FALL 2019/IDS 572 Data mining/hw1/"
setwd(path)
# getwd()


# Question 3

data(attitude)

#a 
summary(attitude)

#b

str(attitude)

#c

plot(attitude)

# Question 4

library(readxl)
hw1 <- read_excel("hw1.xls")
hw1 <- data.frame(hw1)

# b

g_freq = ddply(hw1, .(Your.gender), summarize, 
               frequency=length(Your.gender))

plot = ggplot(g_freq, aes(x=Your.gender, y=frequency)) 
plot = plot + geom_bar(stat="identity", width = .05) 
plot


#c

ggplot(hw1, aes(x=hw1$Your.Height.in.inches)) + geom_histogram(binwidth = .5)


#d

fried_food = c()

for (f in hw1[, 6]){
  if(f == "None"){
    fried_food = c(fried_food, 0)
  } else if (f == "Less than 3 times" ){
    fried_food = c(fried_food, 1)
  } else {
    fried_food = c(fried_food, 2)}
}


fried_food = data.frame(fried_food)
fried_freq = ddply(fried_food, .(fried_food), summarize, 
                   frequency= length(fried_food))

plot = ggplot(fried_freq, aes(x=fried_freq, y= frequency, 
                              fill=gend_freq$frequency ))
plot + geom_col(width = .1)


#e

#http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
cor(hw1$Your.Weight.in.pounds, hw1$Your.Height.in.inches)
# weak to almost no correlation between height and weight
# or linear relationship.

plot = ggplot(hw1, aes(x=hw1$Your.Weight.in.pounds, 
                       y=hw1$Your.Height.in.inches))

plot + geom_point()

#f               Review

height_stats = boxplot.stats(hw1$Your.Height.in.inches)$stats
# presence of 1 outlier at 6 inches

# Question 5
#http://stats4stem.weebly.com/r-birthwt-data.html

data(birthwt)
str(birthwt)

birthwt_a = birthwt
birthwt_b = birthwt

#a

# categorical variables
for (var in names(birthwt_a)){
  birthwt_a[, var]=  factor(birthwt_a[, var])
}
str(birthwt_a)

#b            


#c

tapply(birthwt$bwt, birthwt$smoke, mean)
# infants of mothers smoking during pregnancy weight on average 
# 280 gm less than infants of mothers that did not.
tapply(birthwt$bwt, birthwt$race, mean)
# infants of white mothers weight on average arround 380 gm more than 
# infants of black mothers at birth and 300 for other races.

table_bwt = tapply(birthwt$bwt, list(birthwt$smoke, birthwt$race), mean)
table_bwt
# Yes, smoking status has an effect on birth weight. Infants of 
# mothers smoking during pregnancy weight on average more than 
# infants of mothers that did not.

# Race also plays a major role. No matter the smoking status, on average
# infants of black mothers have the lowest weights, followed by infants 
# of mothers of other races and finally, infants of white mothers with 
# the highest weights. 

#d
kable(table_bwt)


#e
tapply(birthwt$bwt, birthwt$race, mean)
table_bwt = ddply(birthwt, .(race), summarize, mean= round(mean(bwt),2))
table_bwt
# values are the same. 

#f            Review

df_bwt = data.frame(table_bwt)
ggplot(df_bwt, aes(x=race, y=mean)) + geom_col(width = 0.5)

#g                      
#https://stackoverflow.com/questions/18057081/ddply-summarise-proportional-count

total = dim(birthwt)[1]
ddply(birthwt[, c("bwt","smoke","low")], .(smoke),
      summarize, average_bwt= round(mean(bwt),2),
      p_low_bwt = round(length(low)/total,4))

#i
r = cor(birthwt$age, birthwt$bwt)
r # 0.09033
# weak correlation.
ddply(birthwt,.(smoke),summarise,corr = cor(bwt,age))


#Question 6
#https://www.tutorialgateway.org/r-ggplot2-histogram/
#http://varianceexplained.org/RData/code/code_lesson2/
data(diamonds)

#a
str(diamonds)
#price is a quantitative variable (continous).


# expect it to be right skewed because most diamonds found are small 
# and fall within a lower price range compared to large
# diamonds which are more difficult to find and are more expensive.


# ggplot(diamonds, aes(x=carat, y=price)) + geom_point()
ggplot(diamonds, aes(x=price)) + geom_histogram(binwidth = 10)
# yes, it met my expectations.


#b
#https://ggplot2.tidyverse.org/reference/diamonds.html

# boxplot(diamonds$price)
# boxplot.stats(diamonds$price)$stats
# min=326.0   Q1=950.0  M=2401.0  Q3=5324.5 max=11886.0

boxplot.stats(diamonds$carat)$stats
hist(diamonds$carat)
# the statistics for carats of diamonds are somewhat similar to 
# the statistics of the price with a large difference between the Q3
# and max and a right skewed distribution. 
# min=0.20 Q1=0.40 M=0.70 Q3=1.04 max=2.00

#c

# color is a qualitative variable (ordinal variable)
ggplot(diamonds, aes(x=color)) + geom_bar(width = .5)
# the most present color is G.

#d

ggplot(diamonds, aes(x=cut)) + geom_bar(width = .5)   
# cut has a left skewed distribution with most of the data falling in
# the Ideal category in the far right. 


#e

ggplot(diamonds, aes(x=depth,fill=cut))+geom_histogram(binwidth = .2)
# ggplot(diamonds, aes(x=depth, fill=cut))+geom_histogram(binwidth = .2)+facet_wrap(~ cut)
# typically, diamonds with a depth between 60-65 have the best cut. 


#f

# ggplot(diamonds, aes(x=cut, y=price)) + geom_point()
ggplot(data = diamonds, aes(x = price, fill = cut))+geom_histogram(binwidth = 250, color = "midnightblue") + theme(legend.position = "top")
# it is unsual that the quality of the cut has no apparent relationship
# with the price of the diamonds. 

#g

# ggplot(diamonds, aes(x=carat, y=price, color=clarity)) + geom_point()
ggplot(diamonds, aes(x=carat, y=price)) + geom_point()

#h

ggplot(diamonds, aes(x=carat, y=price, color=clarity)) + geom_point(alpha=0.1)

#i

ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + facet_wrap(~ clarity)


#Question 7


df = read.csv(paste(c(path,"Pima Indian Diabetes.csv"), collapse=""), header=T)
# class(df)
# names(df)


#missing values
# df2_index <- na.omit(df$Class.variable) 
# for (col_name in names(df)){
#   print(col_name)
#   print(sum(is.na(df$col_name))) 
# }


#a

dim(df)  # 9 variables and 768 observations
# str(df)
# attributes(data)


#b

# for missing values na.omit()
num_obs = dim(df)[1]

index_80 = round(num_obs*.8)
# train_index = seq(index_80)
# test_index = seq(index_80 +1, num_obs)

df.train <- df[1:index_80, ]
df.test <- df[index_80 +1: num_obs, ]


#c

diabetes_rpart <- rpart(Class.variable ~., data=df.train, method="class",
                        parms = list(split = "gini"))
# summary(diabetes_tree)

#predictions
train_preds <- predict(diabetes_rpart, data=df.train$Class.variable, type="class")

#confusion matrix
conf <- table(train$Class.variable, train_preds)  # True , preds

TP <- conf[1, 1] # true positive
FN <- conf[1, 2] # false negative
FP <- conf[2,1] # false positive
TN <- conf[2,2] # true negative

# accuracy
acc <- (TP+TN) / (TP+TN+FN+FP)
print(acc)    # 82.25%


#d

rpart.plot(diabetes_rpart)
# 12 leaves that are not pure.


#e

# I choose first to split on  
# Plasma.glucose.concentration.a.2.hours.in.an.oral.glucose.
# tolerance.test <= 154 has it provides the (strongest statistic 
# of = 128.977) with Gini of 0.

# My second choice is on Body.mass.index <= 26.3 which provides 
# the second statistic of 45.898.

# It's Plasma.glucose.concentration.a.2.hours.in.an.oral.glucose.
# tolerance.test and Body.mass.index. 

#f

# prediction
test_preds <- predict(diabetes_rpart, newdata = test, type="class")

# accuracy
conf = table(test_preds, test$Class.variable)

TP <- conf[1, 1] # true positive
FN <- conf[1, 2] # false negative
FP <- conf[2,1] # false positive
TN <- conf[2,2] # true negative
acc <- (TP+TN) / (TP+TN+FN+FP)
print(acc)  # 77.27%


#g

# train$Class.variable <- factor(train$Class.variable)
diabetes_tree <- ctree(factor(Class.variable) ~., data=train)
conf <- table(predict(diabetes_tree), train$Class.variable)

TP <- conf[1, 1] # true positive
FN <- conf[1, 2] # false negative
FP <- conf[2,1] # false positive
TN <- conf[2,2] # true negative
acc <- (TP+TN) / (TP+TN+FN+FP)
print(acc)  # 77.36%


# h
ind <-   sample(2, nrow(df), replace=TRUE, prob=c(0.8, 0.2))
train = df[ind==1,]
test = df[ind==2,]

predict(diabetes_rpart, train$Class.variable, type="class")
