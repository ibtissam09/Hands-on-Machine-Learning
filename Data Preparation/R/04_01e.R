# Load necessary library
library(dplyr)

# Step 1: Load the data
# Read the CSV file into a DataFrame
df <- read.csv("../data/students.csv")
head(df)

# Step 2: Identify missing values
# Create a logical mask of where the missing values are
missing_mask <- is.na(df)
print(missing_mask)

# Step 3: Identify rows with missing data
# Filter rows that have any missing values
rows_with_missing <- df[apply(missing_mask, 1, any), ]
print(rows_with_missing)

# Step 4: Drop rows with missing data
# Drop any rows with missing values
df_dropped_rows <- na.omit(df)
print(df_dropped_rows)

# Step 5: Drop rows with missing data in specific columns
# Drop rows with missing values only in the 'Math_Score' and 'Science_Score' columns
df_dropped_specific <- df %>%
  filter(!is.na(Math_Score) & !is.na(Science_Score))
print(df_dropped_specific)

# Step 6: Drop columns with any missing data
# Drop columns with any missing values
df_dropped_columns <- df[, colSums(is.na(df)) == 0]
print(df_dropped_columns)

# Step 7: Drop column with the highest number of missing values
# Identify the column with the most missing values and drop it
missing_counts <- colSums(is.na(df))
column_to_drop <- names(missing_counts)[which.max(missing_counts)]
df_dropped_highest_missing <- df %>% select(-one_of(column_to_drop))
print(df_dropped_highest_missing)

# Step 8: Impute missing values
# Make a copy of the DataFrame for imputation
df_imputed <- df

# Impute 'Name' with the most common name
most_common_name <- names(sort(table(df_imputed$Name), decreasing = TRUE))[1]
df_imputed$Name[is.na(df_imputed$Name)] <- most_common_name
print(table(df_imputed$Name))

# Impute 'Age' with the mean age
mean_age <- mean(df_imputed$Age, na.rm = TRUE)
df_imputed$Age[is.na(df_imputed$Age)] <- mean_age
print(summary(df_imputed$Age))

# Impute 'Zip_Code' based on 'Address'
address_zip_mapping <- list(
  '123 Elm St' = 12345,
  '456 Oak St' = 23456,
  '789 Pine St' = 34567,
  '135 Maple St' = 45678,
  '246 Cedar St' = 56789,
  '975 Walnut St' = 67890
)

df_imputed$Zip_Code <- sapply(1:nrow(df_imputed), function(i) {
  if (is.na(df_imputed$Zip_Code[i])) {
    address_zip_mapping[[df_imputed$Address[i]]]
  } else {
    df_imputed$Zip_Code[i]
  }
})
print(unique(df_imputed[, c("Address", "Zip_Code")]))

# Step 9: K-Nearest Neighbors (KNN) Imputation
# Load the necessary library
library(DMwR)

# Select columns to apply KNN imputation
columns_to_impute <- c("Age", "Math_Score", "Science_Score", "English_Score", "Zip_Code")

# Apply KNN imputation
df_imputed_knn <- knnImputation(df_imputed[, columns_to_impute], k = 5)
df_imputed_knn <- cbind(df_imputed[setdiff(names(df_imputed), columns_to_impute)], df_imputed_knn)

print(head(df_imputed_knn))

# Display the imputed columns
print(head(df_imputed_knn[, columns_to_impute], 10))
