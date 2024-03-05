# 1.
numeric_columns <- sapply(warpbreaks, function(x) is.numeric(x) || is.integer(x))
print(numeric_columns)

# 2.
warpbreaks[, numeric_columns] <- sapply(warpbreaks[, numeric_columns], as.integer)
print(warpbreaks)
# 3.
# ()

# 1.
file_path <- "/cloud/project/Lab_Exercise#1/exampleFile.txt"
lines <- readLines(file_path, warn = FALSE)
print(lines)

# 2.
comments <- lines[grepl("^#", lines)]
print(comments)
data_lines <- lines[!grepl("^#", lines)]
print(data_lines)

# 3. 
date_line <- comments[1]
print(date_line)
date <- gsub("# Date: ", "", date_line)
print(date)

# 4.
# a.
split_data <- strsplit(data_lines, ";")
print(split_data)

# b.
max_fields <- max(sapply(split_data, length))
print(max_fields)
split_data <- lapply(split_data, function(x) {
  if (length(x) < max_fields) {
    c(x, rep(NA, max_fields - length(x)))
  } else {
    x
  }
})
print(split_data)

# c.
data_matrix <- matrix(unlist(split_data), nrow = length(split_data), byrow = TRUE)
print(data_matrix)

# d. 
field_names <- gsub("# ", "", comments[2:4])
print(field_names)
dim(data_matrix)

field_names <- strsplit(field_names, ": ")[[1]]
print(field_names)
length_field_names <- length(field_names)
print(length_field_names)

if (ncol(data_matrix) == length_field_names) {
  colnames(data_matrix) <- field_names
} else {
  # Handle the mismatch (adjust your code accordingly)
  print("Number of columns and length of column names do not match.")
}

