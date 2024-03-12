#install.packages("dplyr")
#install.packages("stringr")
#install.packages("httr")
#install.packages("rvest")

library(dplyr)
library(stringr)
library(httr)
library(rvest)

url <- 'https://arxiv.org/search/?query=shoes&searchtype=all&source=header'

parse_url(url)

start <- proc.time()
title <- NULL
author <- NULL
subject <- NULL
abstract <- NULL
meta <- NULL

# Initialize the total number of papers
total_papers <- 0

# Set the maximum number of papers you want (150 in this case)
max_papers <- 150

# Initialize the page variable
i <- 0

# Initialize a vector to store unique identifiers (paper URLs)
unique_identifiers <- c()

while (total_papers < max_papers) {
  i <- i + 2  # Increment by 2 to go to the next page
  tmp_url <- modify_url(url, query = list(start = i))
  tmp_list <- read_html(tmp_url) %>%
    html_nodes('p.list-title.is-inline-block') %>%
    html_nodes('a[href^="https://arxiv.org/abs"]') %>%
    html_attr('href')
  
  if (length(tmp_list) == 0) {
    # Break the loop if there are no more papers to scrape
    break
  }
  
  for (j in 1:length(tmp_list)) {
    tmp_paragraph <- read_html(tmp_list[j])
    
    # Extract the unique identifier (e.g., paper URL)
    unique_id <- tmp_list[j]
    
    # Check if the paper has already been scraped
    if (!(unique_id %in% unique_identifiers)) {
      # Your existing scraping code...
      
      # title
      tmp_title <- tmp_paragraph %>% html_nodes('h1.title.mathjax') %>% html_text(T)
      tmp_title <- gsub('Title:', '', tmp_title)
      title <- c(title, tmp_title)
      
      # author
      tmp_author <- tmp_paragraph %>% html_nodes('div.authors') %>% html_text
      tmp_author <- gsub('\\s+',' ',tmp_author)
      tmp_author <- gsub('Authors:','',tmp_author) %>% str_trim
      author <- c(author, tmp_author)  
      
      # subject
      tmp_subject <- tmp_paragraph %>% html_nodes('span.primary-subject') %>% html_text(T)
      subject <- c(subject, tmp_subject)
      
      # abstract
      tmp_abstract <- tmp_paragraph %>% html_nodes('blockquote.abstract.mathjax') %>% html_text(T)
      tmp_abstract <- gsub('\\s+',' ',tmp_abstract)
      tmp_abstract <- sub('Abstract:','',tmp_abstract) %>% str_trim
      abstract <- c(abstract, tmp_abstract)
      
      # meta
      tmp_meta <- tmp_paragraph %>% html_nodes('div.submission-history') %>% html_text
      tmp_meta <- lapply(strsplit(gsub('\\s+', ' ',tmp_meta), '[v1]', fixed = T),'[',2) %>% unlist %>% str_trim
      meta <- c(meta, tmp_meta)
      cat(j, "paper\n")
      Sys.sleep(1)
      
      # Add the unique identifier to the vector
      unique_identifiers <- c(unique_identifiers, unique_id)
      
      total_papers <- total_papers + 1
      cat(total_papers, "papers scraped\n")
    }
  }
}

# Combine all papers from different pages into one data frame
papers <- data.frame(title, author, subject, abstract, meta)

# Save the result
save(papers, file = "Arxiv_shoes.RData")
write.csv(papers, file = "Arxiv_shoes.csv")

end <- proc.time()
end - start # Total Elapsed Time

