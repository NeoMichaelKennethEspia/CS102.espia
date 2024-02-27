install.packages("rvest")

library(rvest)
library(polite)

url <- "https://www.amazon.com/s?k=earrings&crid=1IH4GNB6Y6RT7&sprefix=earrin%2Caps%2C439&ref=nb_sb_ss_ts-doa-p_1_6"

session <- bow(url, user_agent = "Educational")
session

session_page <- scrape(session)

div_elements <- html_nodes(session_page, 'div.sg-col-4-of-24.sg-col-4-of-12.s-result-item.s-asin.sg-col-4-of-16.sg-col.s-widget-spacing-small.sg-col-4-of-20')

brand_descriptions <- character()
prices <- character()
review_counts <- character()
ratings <- character()

product_count <- 0

for (div_element in div_elements) {
  
  brand_element <- html_node(div_element, 'a-size-base-plus a-color-base a-text-normal')
  brand <- ifelse(!is.na(brand_element), html_text(brand_element), '')
  
  description_element <- html_node(div_element, 'div.a-section.a-spacing-small')
  description <- ifelse(!is.na(description_element), html_text(description_element), '')
  
  price_element <- html_node(div_element, 'span.a-price-whole')
  price <- ifelse(!is.na(price_element), html_text(price_element), '')
  
  review_count_element <- html_node(div_element, 'span.a-size-base')
  review_count <- ifelse(!is.na(review_count_element), html_text(review_count_element), '')
  
  rating_element <- html_node(div_element, 'span.a-icon-alt')
  rating <- ifelse(!is.na(rating_element), html_text(rating_element), '')
  
  brand_description <- paste(brand, description)
  brand_descriptions <- c(brand_descriptions, brand_description)
  prices <- c(prices, price)
  review_counts <- c(review_counts, review_count)
  ratings <- c(ratings, rating)
}

product_df1 <- data.frame(Brand_Description = brand_descriptions,
                          Price = prices,
                          Review_Count = review_counts,
                          Rating = ratings)

write.csv(product_df3, "ThirdCategory.csv")

product_df3$Category <- "Earrings"

View(product_df3)