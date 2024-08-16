# Load the necessary libraries
library(rvest)  # For web scraping
library(dplyr)  # For data manipulation

# Step 1: Fetch the webpage content
url <- 'https://books.example.com'
webpage <- read_html(url)

# Step 2: Find all book articles on the page
books <- webpage %>% html_nodes("article.product_pod")

# Initialize lists to hold extracted data
titles <- c()
prices <- c()
availabilities <- c()

# Step 3: Loop through each book and extract details
for (book in books) {
  # Title
  title <- book %>% html_node("h3 a") %>% html_attr("title")
  titles <- c(titles, title)
  
  # Price
  price <- book %>% html_node("p.price_color") %>% html_text()
  prices <- c(prices, price)
  
  # Availability
  availability <- book %>% html_node("p.instock.availability") %>% html_text(trim = TRUE)
  availabilities <- c(availabilities, availability)
  # Rating
  rating <- book %>% html_node("p.star-rating") %>% html_attr("class")
  # Extract the rating from the class name (assuming format is "star-rating Three")
  rating <- gsub("star-rating ", "", rating)
  ratings <- c(ratings, rating)
}

# Combine data into a data frame
books_data <- data.frame(
  Title = titles,
  Price = prices,
  Availability = availabilities,
  Ratings = ratings
)

# Display the result
print(books_data)


# Assuming there are 50 pages
for (page_num in 1:50) {
  # Construct the URL for the current page
  url <- paste0('https://books.example.com/page-', page_num)
  webpage <- read_html(url)
  
  # Find all book articles on the page
  books <- webpage %>% html_nodes("article.product_pod")
  
  # Loop through each book and extract details
  for (book in books) {
    # Title
    title <- book %>% html_node("h3 a") %>% html_attr("title")
    titles <- c(titles, title)
    
    # Price
    price <- book %>% html_node("p.price_color") %>% html_text()
    prices <- c(prices, price)
    
    # Availability
    availability <- book %>% html_node("p.instock.availability") %>% html_text(trim = TRUE)
    availabilities <- c(availabilities, availability)
    
    # Rating
    rating <- book %>% html_node("p.star-rating") %>% html_attr("class")
    rating <- gsub("star-rating ", "", rating)
    ratings <- c(ratings, rating)
  }
}

# Combine data into a data frame
books_data <- data.frame(
  Title = titles,
  Price = prices,
  Availability = availabilities,
  Rating = ratings
)

# Display the combined result
print(books_data)