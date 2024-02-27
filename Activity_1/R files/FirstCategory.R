# Install and load the rvest package
#if (!requireNamespace("rvest", quietly = TRUE)) {
install.packages("rvest")
#}
library(rvest)
library(polite)

# Read the HTML file
url <- "https://www.amazon.com/s?k=skateboard&crid=1EV3LOJTU8PMR&sprefix=skate%2Caps%2C392&ref=nb_sb_ss_ts-doa-p_1_5"

session <- bow(url, user_agent = "Student's Demo Educational")
session

session_page <- scrape(session)

# Find all div elements with the specified class
div_elements <- html_nodes(session_page, 'div.sg-col-4-of-24.sg-col-4-of-12.s-result-item.s-asin.sg-col-4-of-16.sg-col.s-widget-spacing-small.sg-col-4-of-20')

# Create empty vectors to store data
brand_descriptions <- character()
prices <- character()
review_counts <- character()
ratings <- character()

# Counter to track the number of products scraped
product_count <- 0

for (div_element in div_elements) {
  # Find the span element with class="a-size-base-plus a-color-secondary a-text-normal" and get the brand
  brand_element <- html_node(div_element, 'span.a-size-base-plus.a-color-secondary.a-text-normal')
  brand <- ifelse(!is.na(brand_element), html_text(brand_element), '')
  
  # Find the div element with class="a-section a-spacing-small" and get the description
  description_element <- html_node(div_element, 'div.a-section.a-spacing-small')
  description <- ifelse(!is.na(description_element), html_text(description_element), '')
  
  # Find the span element with class="a-price-whole" and get the price
  price_element <- html_node(div_element, 'span.a-price-whole')
  price <- ifelse(!is.na(price_element), html_text(price_element), '')
  
  # Find the span element with class="a-size-base" and get the review count
  review_count_element <- html_node(div_element, 'span.a-size-base')
  review_count <- ifelse(!is.na(review_count_element), html_text(review_count_element), '')
  
  # Find the span element with class="a-icon-alt" and get the ratings
  rating_element <- html_node(div_element, 'span.a-icon-alt')
  rating <- ifelse(!is.na(rating_element), html_text(rating_element), '')
  
  # Append data to vectors, excluding brand name and renaming description
  brand_description <- paste(brand, description)
  brand_descriptions <- c(brand_descriptions, brand_description)
  prices <- c(prices, price)
  review_counts <- c(review_counts, review_count)
  ratings <- c(ratings, rating)
  
  
}

# Create a data frame
product_df1 <- data.frame(Brand_Description = brand_descriptions,
                          Price = prices,
                          Review_Count = review_counts,
                          Rating = ratings)

write.csv(product_df1, "product1.csv")

# Add "Category" column and set the value to "Monitors"
product_df1$Category <- "Skateboard"

# Reorder columns with "Category" as the leftmost column
product_df1 <- product_df1[, c("Category", names(product_df1)[-which(names(product_df1) == "Category")])]

# Write the updated data frame to a CSV file
write.csv(product_df1, "product1_updated.csv", row.names = FALSE)

