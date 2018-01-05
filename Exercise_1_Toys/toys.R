library(readr)
toys <- read_csv("C:/Users/User/Desktop/R_Practice/Exercise_1_Toys/refine_original.csv")
toys

library(dplyr)
toys <- tbl_df(toys)
toys

library(stringr)
pat_rep <- c("(.*)ps$" = "philips", "^ak(.*)" = "akzo",
             "(.*)ver$" = "unilever", "(.*)ten$" = "van houten")
toys_new <- toys %>%
  mutate(company = str_replace_all(tolower(company), pat_rep)) %>%
  rename("Product_Code_Name" = "Product code / number")

library(tidyr)

toys_new <- separate(toys_new,Product_Code_Name, c("product_code", "product_number"), sep="-")

View(toys_new)

pat_rep <- c("p" = "Smartphone", "v" = "TV",
             "x" = "Laptop", "q" = "Tablet")
toys_new %<>% 
  mutate(product_category = product_code) %>%
  mutate(product_category = str_replace_all(tolower(product_category), pat_rep))

toys_new <- unite(toys_new, "full_address", address, city, country, sep = ',')

View(toys_new)

library(dummies)
library(purrr)

toys <- toys_new %>%
  as.data.frame() %>%
  dummy.data.frame(names = c("company", "product_category"), sep = '_') %>%
  as_tibble() %>%
  set_names(function(x) gsub(' ', '_', x)) %>%
  set_names(tolower)
 
View(toys)

write.csv(toys, file="C:/Users/User/Desktop/R_Practice/Exercise_1_Toys/refine_clean.csv")
