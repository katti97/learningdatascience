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

#3
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
