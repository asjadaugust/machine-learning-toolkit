# Multiple Linear Regression

# Importing the dataset
dataset = read.csv('50_Startups.csv')

# Encoding categorical data
dataset$State = factor(dataset$State, 
                         levels = c('New York', 'California', 'Florida'),
                         labels = c(1,2,3))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Fitting Multiple Linear Regression to the Training Set
regressor = lm(formula = Profit ~ ., data = training_set)
summary(regressor)

# Predicting the Test Set results
y_pred = predict(regressor, newdata = test_set)

# Building the optimal model using Backward Elimination
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State, dataset)
summary(regressor)

# Removing State2
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend, dataset)
summary(regressor)

# Removing Administration
regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend, dataset)
summary(regressor)

# Removing Marketing.Spend
regressor = lm(formula = Profit ~ R.D.Spend, training_set)
summary(regressor)

# Predicting the Test Set results
y_pred2 = predict(regressor, newdata = test_set)
