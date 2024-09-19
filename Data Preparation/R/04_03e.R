# Load necessary libraries
library(readr)
library(dplyr)
library(caret)

# Load the dataset
df <- read_csv('../data/customer_loan_data.csv')

# Display the first few rows of the data
head(df)

# Set the response variable
response <- 'decision'
y <- df %>% select(all_of(response))
head(y)

# Define the predictors
predictors <- setdiff(names(df), response)
X <- df %>% select(all_of(predictors))
head(X)

# Train-test split
set.seed(1234)
trainIndex <- createDataPartition(df$purpose, p = 0.99, list = FALSE)
X_train <- X[trainIndex, ]
X_test <- X[-trainIndex, ]
y_train <- y[trainIndex, ]
y_test <- y[-trainIndex, ]

# Check the distribution of the 'purpose' column in the test set
prop.table(table(X_test$purpose))