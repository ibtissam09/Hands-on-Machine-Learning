# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load the dataset
supermarket <- read.csv("detailed_supermarket_sales.csv")
head(supermarket)
str(supermarket)
# Comparison Graph: Boxplot
ggplot(supermarket, aes(x = `Product.line`, y = Total)) +
  geom_boxplot() +
  labs(title = 'Boxplot of Total Sales by Product Line') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Relationship Graph: Scatter plot
ggplot(supermarket, aes(x = Unit.price, y = Quantity, color = `Product.line`)) +
  geom_point() +
  labs(title = 'Scatter Plot of Unit Price vs Quantity by Product Line')

# Distribution Graph: Histogram
ggplot(supermarket, aes(x = Total)) +
  geom_histogram(bins = 20, fill = 'skyblue', color = 'black') +
  geom_density(aes(y = ..density.. * max(..count..)), color = 'red') +
  labs(title = 'Distribution of Total Sales', x = 'Total Sales')

# Composition Graph: Bar chart
supermarket %>%
  count(`Product.line`) %>%
  ggplot(aes(x = reorder(`Product.line`, n), y = n)) +
  geom_bar(stat = "identity", fill = 'skyblue') +
  labs(title = 'Bar Chart of Product Line Distribution', x = 'Product Line', y = 'Count') +
  coord_flip()
# Composition Graph: Stacked Bar chart
supermarket %>%
  count(Gender, `Product.line`) %>%
  ggplot(aes(x = Gender, y = n, fill = `Product.line`)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = 'Stacked Bar Chart of Product Line by Gender', x = 'Gender', y = 'Count')

# Composition Graph: Pie chart

supermarket %>%
  count(Gender) %>%
  ggplot(aes(x = "", y = n, fill = Gender)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = 'Pie Chart of Gender Distribution') +
  theme_void() +
  geom_text(aes(label = scales::percent(n / sum(n))), position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = c('lightblue', 'lightgreen'))


# Load necessary libraries

library(gridExtra)


# 1. Boxplot: Total Sales by Product Line
p1 <- ggplot(supermarket, aes(x = `Product.line`, y = Total)) +
  geom_boxplot() +
  labs(title = 'Boxplot of Total Sales by Product Line') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 2. Scatter plot: Unit Price vs Quantity by Product Line
p2 <- ggplot(supermarket, aes(x = Unit.price, y = Quantity, color = `Product.line`)) +
  geom_point() +
  labs(title = 'Scatter Plot of Unit Price vs Quantity by Product Line')

# 3. Histogram: Distribution of Total Sales
p3 <- ggplot(supermarket, aes(x = Total)) +
  geom_histogram(bins = 20, fill = 'skyblue', color = 'black') +
  geom_density(aes(y = ..density.. * max(..count..)), color = 'red') +
  labs(title = 'Distribution of Total Sales', x = 'Total Sales')

# 4. Bar chart: Product Line Distribution
p4 <- supermarket %>%
  count(`Product.line`) %>%
  ggplot(aes(x = reorder(`Product.line`, n), y = n)) +
  geom_bar(stat = "identity", fill = 'skyblue') +
  labs(title = 'Bar Chart of Product Line Distribution', x = 'Product Line', y = 'Count') +
  coord_flip()

# 5. Stacked Bar chart: Product Line by Gender
p5 <- supermarket %>%
  count(Gender, `Product.line`) %>%
  ggplot(aes(x = Gender, y = n, fill = `Product.line`)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = 'Stacked Bar Chart of Product Line by Gender', x = 'Gender', y = 'Count')

# 6. Pie chart: Gender Distribution
p6 <- supermarket %>%
  count(Gender) %>%
  ggplot(aes(x = "", y = n, fill = Gender)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = 'Pie Chart of Gender Distribution') +
  theme_void() +
  geom_text(aes(label = scales::percent(n / sum(n))), position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = c('lightblue', 'lightgreen'))

# Arrange the plots into a 3x2 grid
grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 2)
