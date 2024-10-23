# Load necessary libraries
library(caret)

# Load the Breast Cancer dataset
install.packages("mlbench")
data("BreastCancer", package = "mlbench")
bc_data = BreastCancer[,-1] # Remove the ID Column

# Convert factors to numeric
bc_data[,-10] <- lapply(bc_data[,-10], function(x) as.numeric(as.character(x)))

# Standardize the data
bc_scaled <- scale(bc_data[,-10]) # Exclude the target column
bc_scaled = na.omit(bc_scaled)
# Apply PCA
pca <- prcomp(x=bc_scaled, center = T, scale. = T)

# Create a data frame with the PCA results
pca_df <- data.frame(pca$x[,1:5], Target = na.omit(bc_data)$Class)

# View the first few rows of the transformed dataset
head(pca_df)

# Plot the PCA results
library(ggplot2)
ggplot(pca_df, aes(x=PC1, y= PC2, color = Target))+
  geom_point() +
  ggtitle("PCA on the Breast Cancer Dataset")

