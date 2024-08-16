# Load necessary libraries
library(tidyverse) # For data manipulation
library(readxl)    # For reading Excel files
library(jsonlite)  # For reading and writing JSON files
library(RSQLite)   # For SQLite database
library(DBI)       # For database interface
library(mongolite) # For MongoDB

# Section 1: Creating data using data frames
# ------------------------------------------
# Create a sample data frame
data <- data.frame(
  Name = c('Alice', 'Bob', 'Charlie', 'David'),
  Age = c(24, 27, 22, 32),
  City = c('New York', 'Los Angeles', 'Chicago', 'Houston')
)

print("Created Data Frame:")
print(data)

# Section 2: Importing data from tabular formats (CSV, TSV, Excel)
# ---------------------------------------------------------------

# Read data from CSV file
data_csv <- read.csv('../data/house_pricing.csv')
print("\nData read from CSV file:")
print(data_csv)

# Save data frame to a CSV file for demonstration
write.csv(data, 'sample_data.csv', row.names = FALSE)


# Read data from TSV file
data_tsv <- read.table('../data/birth_records.tsv', sep = "\t", header = TRUE)
print("\nData read from TSV file:")
print(data_tsv)

# Save data frame to a TSV file for demonstration
write.table(data, 'sample_data.tsv', sep = "\t", row.names = FALSE)


# Read data from Excel file
data_excel <- read_excel('../data/employee_data.xlsx')
print("\nData read from Excel file:")
print(data_excel)

# Save data frame to an Excel file for demonstration
write.xlsx(data, 'sample_data.xlsx')

# Section 3: Importing data from JSON files
# -----------------------------------------


# Read data from JSON file
data_json <- fromJSON('../data/patients.json')
print("\nData read from JSON file:")
print(data_json)

# Save data frame to a JSON file for demonstration
write_json(data, 'sample_data.json')


# Section 4: Importing data from relational databases
# ---------------------------------------------------
# Create a SQLite database and table for demonstration
conn <- dbConnect(SQLite(), dbname = 'sample_data.db')
dbWriteTable(conn, 'people', data, overwrite = TRUE)

# Read data from SQLite database
data_sqlite <- dbReadTable(conn, 'people')
print("\nData read from SQLite database:")
print(data_sqlite)

# Section 5: Inserting data into relational databases
# ---------------------------------------------------
# Insert data into SQLite database
new_data <- data.frame(
  Name = c('Eve', 'Frank'),
  Age = c(29, 33),
  City = c('San Francisco', 'Miami')
)
dbWriteTable(conn, 'people', new_data, append = TRUE)

# Verify insertion
data_updated <- dbReadTable(conn, 'people')
print("\nData after insertion into SQLite database:")
print(data_updated)

# Section 6: Importing data from non-relational databases
# -------------------------------------------------------
# Connecting to a MongoDB database
mongo_conn <- mongo(collection = "people", db = "sample_db", url = "mongodb://localhost")

# Insert data into MongoDB collection
mongo_conn$insert(data)

# Read data from MongoDB collection
data_mongo <- mongo_conn$find()
print("\nData read from MongoDB:")
print(data_mongo)

# Section 7: Inserting data into non-relational databases
# -------------------------------------------------------
# Insert additional data into MongoDB collection
new_data_mongo <- data.frame(
  Name = 'Grace',
  Age = 26,
  City = 'Boston'
)
mongo_conn$insert(new_data_mongo)

# Verify insertion
data_mongo_updated <- mongo_conn$find()
print("\nData after insertion into MongoDB:")
print(data_mongo_updated)

# Close connections
dbDisconnect(conn)
mongo_conn$disconnect()
