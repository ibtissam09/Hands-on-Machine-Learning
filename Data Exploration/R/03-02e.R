# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load the dataset
supermarkets <- read.csv("../data/supermarket sales.csv")

# Comparison Graph: Boxplot
ggplot(supermarkets, aes(x = `Product.line`, y = Total)) +
  geom_boxplot() +
  labs(title = 'Boxplot of Total Sales by Product Line') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Relationship Graph: Scatter plot
ggplot(supermarkets, aes(x = Unit.price, y = Quantity, color = `Product.line`)) +
  geom_point() +
  labs(title = 'Scatter Plot of Unit Price vs Quantity by Product Line')

# Distribution Graph: Histogram
ggplot(supermarkets, aes(x = Total)) +
  geom_histogram(bins = 20, fill = 'skyblue', color = 'black') +
  geom_density(aes(y = ..density.. * max(..count..)), color = 'red') +
  labs(title = 'Distribution of Total Sales', x = 'Total Sales')

# Composition Graph: Bar chart
supermarkets %>%
  count(`Product.line`) %>%
  ggplot(aes(x = reorder(`Product.line`, n), y = n)) +
  geom_bar(stat = "identity", fill = 'skyblue') +
  labs(title = 'Bar Chart of Product Line Distribution', x = 'Product Line', y = 'Count') +
  coord_flip()

# Composition Graph: Stacked Bar chart
supermarkets %>%
  count(Gender, `Product.line`) %>%
  ggplot(aes(x = Gender, y = n, fill = `Product.line`)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = 'Stacked Bar Chart of Product Line by Gender', x = 'Gender', y = 'Count')

# Composition Graph: Pie chart
supermarkets %>%
  count(Gender) %>%
  ggplot(aes(x = "", y = n, fill = Gender)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = 'Pie Chart of Gender Distribution') +
  theme_void() +
  geom_text(aes(label = scales::percent(n / sum(n))), position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = c('lightblue', 'lightgreen'))
