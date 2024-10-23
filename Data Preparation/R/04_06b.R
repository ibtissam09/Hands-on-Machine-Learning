# Load necessary libraries
library(caret)

# Load the Breast Cancer dataset


# Convert factors to numeric


# Standardize the data

# Apply PCA


# Create a data frame with the PCA results


# View the first few rows of the transformed dataset


# Plot the PCA results
library(ggplot2)
ggplot(pca_df, aes(x=PC1, y= PC2, color = Target))+
  geom_point() +
  ggtitle("PCA on the Breast Cancer Dataset")

