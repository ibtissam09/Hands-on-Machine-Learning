
# Learning objectives of this video
# You will learn how to:
###############################################################ß
# 1. Import data from files including CSV, TSV, and Excel files
# 2. Import data from PostgreSQL
# 3. Import data from MongoDB

# Part 1: Importing Data from Files
# Importing CSV file into R
website_sales_data <- read.csv('website_sales.csv')

# Display the first few rows of the data
head(website_sales_data)

# Importing TSV file into R
marketplace_sales_data <- read.delim('marketplace_sales.tsv')

# Display the first few rows of the data
head(marketplace_sales_data)

# Install and load the readxl package if not already installed
if(!require(readxl)) install.packages("readxl")
library(readxl)

# Importing Excel file into R
website_sales_data <- read_excel('websites_sales.xlsx', sheet = 'SalesData')

# Display the first few rows of the data
head(website_sales_data)

# Part 2: Importing Data from PostgreSQL
# Install and load the RPostgres package if not already installed
if(!require(RPostgres)) install.packages('RPostgres')
library(RPostgres)

# Establishing the connection to PostgreSQL
con <- dbConnect(RPostgres::Postgres(), dbname = "ecommerce", host = "localhost", 
                 port = 5432, user = "postgres", password = "root")

cat("Connected to PostgreSQL successfully")

# Querying data from the customers table
query <- "SELECT * FROM customers"
customers_data <- dbGetQuery(con, query)

# Display the first few rows of the data
head(customers_data)

# Closing the connection
dbDisconnect(con)

# Part 3: Importing Data from MongoDB
# Install and load the mongolite package if not already installed
if(!require(mongolite)) install.packages("mongolite")
library(mongolite)

# Connecting to MongoDB
mongo_con <- mongo(collection = "products", db = "ecommerce", url = "mongodb://localhost:27017")

# Querying data from the products collection
products_data <- mongo_con$find()

# Display the first few rows of the data
head(products_data)

# Closing the MongoDB connection
mongo_con$disconnect()
