titanic <- read.csv('C:/Users/User/Desktop/R_Practice/Exercise_2_Titanic/titanic_original.csv', header = TRUE)


sum(grepl("^\\s*$",titanic$embarked))
titanic <- titanic %>%
  mutate(embarked = gsub("^\\s*$","S", embarked)) 
sum(grepl("^\\s*$",titanic$embarked))

sum(is.na(titanic$age))
mean_age <- mean(titanic$age, na.rm=TRUE) 
titanic <- titanic %>%
  mutate(age = if_else(is.na(age), mean_age, age))
sum(is.na(titanic$age))
         
sum(grepl("^\\s*$",titanic$boat))
titanic <- titanic %>%
  mutate(boat = gsub("^\\s*$","None", boat))
sum(grepl("^\\s*$",titanic$boat))

titanic <- titanic %>%
  mutate(has_cabin_number = ifelse(grepl("^\\s*$",cabin), 0, 1))
head(titanic)

write.csv(titanic, file='C:/Users/User/Desktop/R_Practice/Exercise_2_Titanic/titanic_clean.csv')
         
  
