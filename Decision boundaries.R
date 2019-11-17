#problem 1
# built a decision tree with 5 boundaries and 6 regions

par(xpd = NA)
plot(NA, NA, type = "n", xlim = c(0, 200), ylim = c(0, 200), xlab = "X", ylab = "Y")

lines(x =c(0,200),y=c(100,100))
text(x = -2, y = 100, labels = c("t1"), col = "red")

lines(x =c(100,100),y=c(100,200))
text(x = 100, y = 203, labels = c("t2"), col = "red")

lines(x =c(0,100),y=c(150,150))
text(x = -2, y = 150, labels = c("t3"), col = "red")

lines(x =c(0,200),y=c(50,50))
text(x = -2, y = 50, labels = c("t4"), col = "red")

lines(x =c(150,150),y=c(50,0))
text(x = 150, y = 54, labels = c("t5"), col = "red")

text(x = 50, y = 125, labels = c("R1"))
text(x = 150, y = 150, labels = c("R2"))
text(x = 50, y = 175, labels = c("R3"))
text(x =100, y = 75, labels = c("R4"))
text(x = 75, y = 25, labels = c("R5"))
text(x = 175, y = 25, labels = c("R6"))

#problem 2
p = seq(0, 1, 0.05)
gini = p * (1 - p) * 2
entropy = -(p * log(p) + (1 - p) * log(1 - p))
class.err = 1 - pmax(p, 1 - p)
matplot(p, cbind(gini, entropy, class.err), col = c("red", "green", "blue"))

#problem 3
#a
library(ISLR)
library(tree)
library(rpart)
library(rpart.plot)
attach(Carseats)

samplesize <- floor(0.75*nrow(Carseats))

set.seed(123)
train_ind <- sample(seq_len(nrow(Carseats)))
train <- sample(seq_len(nrow(Carseats)),size = samplesize)
train1 <- Carseats[train_ind,]
test <- Carseats[-train_ind,]

#b
#fitting a regression tree
model <- tree(Sales~., data=train1)
summary(model)

#c   
plot(model)
text(model)

pred <- predict(model,test)
mean((test$Sales - pred)^2)

#8.10
library(ISLR)

#a
summary(Hitters$Salary)
Hitters = Hitters[!is.na(Hitters$Salary),]
nrow(Hitters)
Hitters$Salary = log(Hitters$Salary)

#b
split = 1:200
Hitters_train= Hitters[split,]
Hitters_test= Hitters[-split,]

#c
library(gbm)

set.seed(123)
pows = seq(-15, 0, by = 0.15)
lambdas = 10^pows
lamlen = length(lambdas)  
train_error = rep(NA, lamlen)
test_error = rep(NA, lamlen)
for (i in 1:lamlen){
  boost = gbm(Salary~., data=Hitters_train, distribution="gaussian", n.trees = 1000, shrinkage = lambdas[i])
  train_pred = predict(boost, Hitters_train, n.trees = 1000)
  test_pred = predict(boost, Hitters_test, n.trees = 1000)
  train_error[i] = mean((Hitters_train$Salary - train_pred)^2)
  test_error[i] = mean((Hitters_test$Salary - test_pred )^2)
}

plot(lambdas, train_error, type = "b", xlab = "Shrinkages", ylab = "Train Mean Square Error", col="blue", pch=20)

#d
plot(lambdas, test_error, type = "b", xlab = "Shrinkages", ylab = "Test Mean Square Error", col="red", pch=20) 

min(test_error)

lambdas[which.min(test_error)]
#e
#Finding the MSE of linear regression model

linear_model = lm(Salary~., data = Hitters_train)
linear_model.predict = predict(linear_model, Hitters_test)
mean((Hitters_test$Salary - linear_model.predict)^2)

library(glmnet)
set.seed(169)
predictors = model.matrix(Salary~.,data= Hitters_train)
targetvar = Hitters_train$Salary
predictors_test = model.matrix(Salary~.,data = Hitters_test)
lasso = glmnet(predictors,targetvar, alpha=1)
lasso_pred = predict(lasso, s=0.01, newx = predictors_test)
mean((Hitters_test$Salary - lasso_pred)^2)

#f
boostbest = gbm(Salary~., data=Hitters_train, distribution="gaussian", n.trees = 1000, shrinkage = lambdas[which.min(test_error)])
summary(boostbest)

#g
library(randomForest)

set.seed(69)
rf = randomForest(Salary~., data =Hitters_train, ntree = 500, mtry= 15)
rf_pred = predict(rf, Hitters_test)
mean((Hitters_test$Salary - rf_pred)^2)
#test MSE for bagging is 0.23, which is a little bit lower than test MSE for boosting 