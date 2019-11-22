#2
length(which(Manipal.data == 'Unknown')) 
#there are only 10 instances of Unknown values in the dataset
library(dplyr)
??library(DMwR)

sum(is.na(Manipal.data))
#we find that NA values are 0 in the dataset
Manipal.data <- Manipal.data%>%mutate(State = replace(State, State=="Unknown", NA))
Manipal.data <- Manipal.data%>%mutate(STATEZONE = replace(STATEZONE, STATEZONE=="Unknown", NA))
sum(is.na(Manipal.data)) 
#replaced Unknown values with NA values so that library DMwR can be used

knnimpute <- knnImputation(Manipal.data[, !names(Manipal.data) %in% "NPS_Status"])

#knnimpute <- kNN(Manipal.data,variable = c("State","STATE"), k=3)
summary(knnimpute)

anyNA(knnimpute)
#the above results in FALSE which means there are no NA values

summary(knnimpute$State)
summary(knnimpute$STATEZONE)

#problem 3

x1 <- c(1,2,2,0,1,0)
x2 <- c(1,2,0,0,0,1)
class1 <- c('+','+','+','-','-','-')
colors = c("red", "red", "red", "blue", "blue", "blue")
plot(x1,x2, col = colors, xlim = c(0, 3), ylim = c(0, 3))
abline(1.38,-1)

data = data.frame(x1,x2,class1)
data

#classifying + as 1 and - as 0 i.e coverting categorical to numerical values
data$class1 <- recode(data$class1, '+'= 1,'-' = 0)
data
