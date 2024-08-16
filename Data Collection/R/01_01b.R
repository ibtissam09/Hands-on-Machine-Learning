# Load the necessary libraries
library(rvest)  # For web scraping
library(dplyr)  # For data manipulation
#install.packages(c('rvest','dplyr'))

# Step 1: Fetch the webpage content
url <- 'http://books.toscrape.com'
page <- read_html(url)

# Step 2: Find all book articles on the page
books <- page %>% html_nodes('article.product_pod')

# Initialize lists to hold extracted data
titles <- c()
prices <- c()
availabilities <- c()
ratings <- c()

# Step 3: Loop through each book and extract details
for (book in books){
  # Title
  title <- book %>%
    html_node('h3 a') %>%
    html_attr('title')
  titles <- c(titles, title)
  # Price
  price <-  book %>%
    html_node('p.price_color') %>%
    html_text()
  prices <- c(prices, price)
  
  # Availability
  availability <-  book %>%
    html_node('p.instock.availability') %>%
    html_text(trim=TRUE)
  availabilities <- c(availabilities, availability)
  
  # Rating
  rating <- book %>%
    html_node('p.star-rating') %>%
    html_attr('class')
  rating <- gsub('star-rating','',rating)
  ratings <- c(ratings, rating)
  
}


# Combine data into a data frame
df <- data.frame(
  Title = titles,
  Price = prices,
  Availability = availabilities,
  Rating = ratings
)


# Display the result
print(df)


# Assuming there are 50 pages
for(page_num in 2:50){
  # Construct the url for each page
  url <- paste0('http://books.toscrape.com/catalogue/page-',page_num,'.html')
  page <- read_html(url)
  books <- page %>% html_nodes('article.product_pod')
  for (book in books){
    # Title
    title <- book %>%
      html_node('h3 a') %>%
      html_attr('title')
    titles <- c(titles, title)
    # Price
    price <-  book %>%
      html_node('p.price_color') %>%
      html_text()
    prices <- c(prices, price)
    
    # Availability
    availability <-  book %>%
      html_node('p.instock.availability') %>%
      html_text(trim=TRUE)
    availabilities <- c(availabilities, availability)
    
    # Rating
    rating <- book %>%
      html_node('p.star-rating') %>%
      html_attr('class')
    rating <- gsub('star-rating','',rating)
    ratings <- c(ratings, rating)
    
  }
}

# Combine data into a data frame

df <- data.frame(
  Title = titles,
  Price = prices,
  Availability = availabilities,
  Rating = ratings
)



# Display the combined result
print(df)