# Load necessary libraries
library(ggplot2)

# Load the dataset
data <- read.csv("https://raw.githubusercontent.com/jbrownlee/Datasets/master/airline-passengers.csv")

# Display the first few rows
head(data)

# Apply Z-score normalization
data$Passengers_Zscore <- scale(data$Passengers)

# Display the updated dataframe
head(data)

# Plot the original data
ggplot(data, aes(x = 1:nrow(data), y = Passengers)) +
  geom_line(color = "blue") +
  ggtitle("Original Data") +
  xlab("Month") +
  ylab("Passengers")

# Plot the Z-score normalized data
ggplot(data, aes(x = 1:nrow(data), y = Passengers_Zscore)) +
  geom_line(color = "red") +
  ggtitle("Z-Score Normalized Data") +
  xlab("Month") +
  ylab("Z-Score")

# Apply Min-Max normalization
data$Passengers_MinMax <- (data$Passengers - min(data$Passengers)) / 
                           (max(data$Passengers) - min(data$Passengers))

# Display the updated dataframe
head(data)

# Plot the original data
ggplot(data, aes(x = 1:nrow(data), y = Passengers)) +
  geom_line(color = "blue") +
  ggtitle("Original Data") +
  xlab("Month") +
  ylab("Passengers")

# Plot the Min-Max normalized data
ggplot(data, aes(x = 1:nrow(data), y = Passengers_MinMax)) +
  geom_line(color = "red") +
  ggtitle("Min-Max Normalized Data") +
  xlab("Month") +
  ylab("Min-Max")

# Apply Log normalization
data$Passengers_Log <- log1p(data$Passengers)

# Display the updated dataframe
head(data)

# Plot the original data
ggplot(data, aes(x = 1:nrow(data), y = Passengers)) +
  geom_line(color = "blue") +
  ggtitle("Original Data") +
  xlab("Month") +
  ylab("Passengers")

# Plot the log-normalized data
ggplot(data, aes(x = 1:nrow(data), y = Passengers_Log)) +
  geom_line(color = "red") +
  ggtitle("Log Normalized Data") +
  xlab("Month") +
  ylab("Log Passengers")



