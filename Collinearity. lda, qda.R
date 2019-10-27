#2
#a
set.seed(1)
x1 = runif(100)
x2= 0.5*x1+rnorm(100)/10
y = 2+2*x1+0.3*x2+rnorm(100)

#b
cor(x1,x2)
plot(x1,x2)

#c
lmodel = lm(y~x1+x2)
summary(lmodel)

#d
lmodel1 = lm(y~x1)
summary(lmodel1)

#e
lmodel2 = lm(y~x2)
summary(lmodel2)

#g)
x1 = c(x1, 0.1)
x2 = c(x2, 0.8)
y = c(y,6)
lm1.fit = lm(y~x1+x2)
summary(lm1.fit)

lm2.fit = lm(y~x1)
summary(lm2.fit)

lm3.fit = lm(y~x2)
summary(lm3.fit)

par(mfrow=c(2,2))
plot(lm1.fit)

par(mfrow=c(2,2))
plot(lm2.fit)

#5
library(ISLR)
library(MASS)
library(class)
summary(Weekly)
pairs(Weekly)
nrow(Weekly)
train <- Weekly[1:872,]
test <- Weekly[873:1089,]
model1 <- glm(Weekly$Direction~Weekly$Lag1+Weekly$Lag2+Weekly$Lag3+Weekly$Lag4+Weekly$Lag5, family = binomial(link = 'logit'), data = Weekly)
summary(model1)

pred1 <- predict(model1, type = "response")
model1.pred <- rep("Down", length(pred1))
model1.pred[pred1 >0.5] = "Up"
table(model1.pred, Weekly$Direction)

#d
attach(Weekly)
y = (Year<2009)
nineten = Weekly[!y,]
model2 = glm(Direction~Lag2, data = Weekly, family = binomial, subset = y)
prob = predict(model2, nineten, type = "response")
pred2 = rep("Down", length(prob))
pred2[prob>0.5] = "Up"
Direction.nineten = Direction[!y]
table(pred2, Direction.nineten)
mean(pred2 == Direction.nineten)

#e
lda1 = lda(Direction~Lag2, data = Weekly, subset = y)
predlda = predict(lda1,nineten)
table(predlda$class, Direction.nineten)
mean(predlda$class == Direction.nineten)


#f
qda1 = qda(Direction~Lag2, data = Weekly, subset = y)
predqda = predict(qda1,nineten)
table(predqda$class, Direction.nineten)
mean(predqda$class == Direction.nineten)

#g building k nearest neighbour model with k=1
traink = as.matrix(Lag2[y])
testk = as.matrix(Lag2[!y])
y.Direction = Direction[y]
set.seed(1)
knnpred = knn(traink, testk,y.Direction, k=1)
table(knnpred, Direction.nineten)
mean(knnpred == Direction.nineten)

#i

#Logistic regression with year and volume
y = (Year<2009)
nineten = Weekly[!y,]
model3 = glm(Direction~Year:Volume, data = Weekly, family = binomial, subset = y)
prob = predict(model3, nineten, type = "response")
pred3 = rep("Down", length(prob))
pred3[prob>0.5] = "Up"
Direction.nineten = Direction[!y]
table(pred3, Direction.nineten)
mean(pred3 == Direction.nineten)

#lda with year and volume
lda2 = lda(Direction~Year:Volume, data = Weekly, subset = y)
predlda2 = predict(lda2,nineten)
table(predlda2$class, Direction.nineten)
mean(predlda2$class == Direction.nineten)

# QDA with (sqrt(Lag2))
qda2 = qda(Direction~(sqrt(Lag2)), data = Weekly, subset = y)
predqda = predict(qda1,nineten)
table(predqda$class, Direction.nineten)
mean(predqda$class == Direction.nineten)

#knn model with k=10
y.Direction = Direction[y]
knnpred = knn(traink, testk,y.Direction, k=10)
table(knnpred, Direction.nineten)
mean(knnpred == Direction.nineten)