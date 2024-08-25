# Load necessary libraries
# In R, 'readr' is used for reading CSV files, and 'dplyr' for data manipulation
library(readr)
library(dplyr)

# Load the dataset from a CSV file
# Ensure to replace the path with the correct path to your dataset
supermarkets <- read_csv("../data/supermarket sales.csv")

# Display the first few rows of the dataset
# This is similar to 'head()' in Python
head(supermarkets)

# Get information about the dataset
# 'str()' in R is equivalent to 'info()' in Python
str(supermarkets)

# Generate descriptive statistics for the dataset
# 'summary()' in R provides similar statistics to 'describe()' in Python
summary(supermarkets)

# Describe a specific column ('Gender')
# Using 'summary()' to describe categorical data
summary(supermarkets$Gender)

# Describe another specific column ('Unit price')
# 'summary()' will provide the min, max, median, and mean among other stats
summary(supermarkets$`Unit price`)

# Calculate the frequency distribution of a categorical column ('Product line')
# 'table()' combined with 'prop.table()' gives the normalized value counts
prop.table(table(supermarkets$`Product line`))

# Calculate the mean of the 'Unit price' column
# 'mean()' in R calculates the average value
mean(supermarkets$`Unit price`)

# Group by 'Product line' and calculate the mean of 'Unit price'
# In R, 'group_by()' combined with 'summarize()' can achieve this
supermarkets %>%
  group_by(`Product line`) %>%
  summarize(mean_unit_price = mean(`Unit price`))

# Perform multiple aggregations (mean, max, min) on 'Unit price' grouped by 'Product line'
# 'summarize()' with multiple functions allows for complex aggregations
supermarkets %>%
  group_by(`Product line`) %>%
  summarize(mean_unit_price = mean(`Unit price`),
            max_unit_price = max(`Unit price`),
            min_unit_price = min(`Unit price`))
