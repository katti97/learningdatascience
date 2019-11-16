#loading inbuilt iris dataset
iris

#building a principal component model
irispca = princomp(iris[-5])
summary(irispca)

#loading of each principal components can be found
irispca$loadings

#code below gives analysis of the score of each individual's contribution to 
irispca$scores
