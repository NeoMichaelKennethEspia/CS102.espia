# Read existing CSV files
product1 <- read.csv("/cloud/project/Activity_1/csv files/FirstCategory.csv")
product2 <- read.csv("/cloud/project/Activity_1/csv files/SecondCategory.csv")
product3 <- read.csv("/cloud/project/Activity_1/csv files/ThirdCategory.csv")

ncol(product1) # 5
ncol(product2) # 6
ncol(product3) # 6

# Adding a new column with default values (e.g., NA)
product1$new_column <- NA

# Assuming col_to_remove is the extra column in product2 and product3
product2 <- product2[, -col_to_remove]
product3 <- product3[, -col_to_remove]

common_columns <- intersect(names(product1), intersect(names(product2), names(product3)))
product1 <- product1[, common_columns]
product2 <- product2[, common_columns]
product3 <- product3[, common_columns]

merged_product <- rbind(product1,product2,product3)

write.csv(merged_product, "MergedProduct.csv", row.names = FALSE)
