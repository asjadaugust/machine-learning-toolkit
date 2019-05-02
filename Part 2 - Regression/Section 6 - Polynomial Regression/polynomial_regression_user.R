# Polynomial Regression

# Importing the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
# library(caTools)
# set.seed(123)
# split = sample.split(dataset$DependentVariable, SplitRatio = 0.8)
# training_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Fitting Linear Regression to the dataset
linreg = lm(formula = Salary ~ Level, data = dataset)
summary(linreg)


# Fitting Polynomial Regression to the dataset
dataset$Level2 = dataset$Level ^ 2
dataset$Level3 = dataset$Level ^ 3
dataset$Level4 = dataset$Level ^ 4
polyreg = lm(formula = Salary ~ ., data = dataset)
summary(polyreg)

# Visualizing the Linear Regression results
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary), 
             colour = "red") +
  geom_line(aes(x = dataset$Level, y = predict(linreg, newdata = dataset)),
            colour = "blue") +
  ggtitle("Truth or bluff (Linear Regression)") +
  xlab("Position Level") +
  ylab("Salary")

# Visualizing the Polynomial Regression results
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary), 
             colour = "red") +
  geom_line(aes(x = x_grid, y = predict(polyreg, newdata = data.frame(Level = x_grid,  Level2 = x_grid^2,
                                                                                       Level3 = x_grid^3,
                                                                                       Level4 = x_grid^4))),
            colour = "blue") +
  ggtitle("Truth or bluff (Polynomial Regression)") +
  xlab("Position Level") +
  ylab("Salary")


# Predicting a new result with Linear Regression
y_pred = predict(linreg, data.frame(Level = 6.5))

# Predicting a new result with Linear Regression
y_pred_poly = predict(polyreg, data.frame(Level = 6.5, 
                                          Level2 = 6.5^2,
                                          Level3 = 6.5^3,
                                          Level4 = 6.5^4))
