# Week 3 quiz

library(datasets)

# Load iris data
data("iris")

?iris

mean(iris$Sepal.Length[iris$Species == "virginica"])

colMeans(iris[,1:4])

apply(iris[,1:4], 2, mean)



# library(datasets)
data(mtcars)

?mtcars


tapply(mtcars$mpg, mtcars$cyl, mean)

with(mtcars, tapply(mpg, cyl, mean))

sapply(split(mtcars$mpg, mtcars$cyl), mean)

abs(mean(mtcars$hp[mtcars$cyl == 4]) - mean(mtcars$hp[mtcars$cyl == 8]))

debug(ls)

ls()
