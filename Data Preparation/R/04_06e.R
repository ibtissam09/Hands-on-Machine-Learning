# Load necessary libraries
library(caret)

# Load the Breast Cancer dataset
data("BreastCancer", package="mlbench")
bc_data <- BreastCancer[, -1]  # Remove ID column

# Convert factors to numeric
bc_data[] <- lapply(bc_data, function(x) as.numeric(as.character(x)))

# Standardize the data
bc_scaled <- scale(bc_data[, -10])  # Exclude the target column

# Apply PCA
pca <- prcomp(bc_scaled, center = TRUE, scale. = TRUE)

# Create a data frame with the PCA results
pca_df <- data.frame(pca$x[, 1:5], Target = bc_data$Class)

# View the first few rows of the transformed dataset
head(pca_df)

# Plot the PCA results
ggplot(pca_df, aes(x = PC1, y = PC2, color = Target)) +
  geom_point() +
  ggtitle("PCA on Breast Cancer Dataset")
