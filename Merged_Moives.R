# Read existing CSV files
movie1 <- read.csv("/cloud/project/Activity3/Movie_1-Activity 3.csv")
movie2 <- read.csv("/cloud/project/Activity3/Movie_2-Activity 3.csv")
movie3 <- read.csv("/cloud/project/Activity3/Movie_3-Activity 3.csv")
movie4 <- read.csv("/cloud/project/Activity3/Movie_4-Activity 3.csv")
movie5 <- read.csv("/cloud/project/Activity3/Movie_5-Activity 3.csv")
movie6 <- read.csv("/cloud/project/Activity3/Movie_6-Activity 3.csv")
movie7 <- read.csv("/cloud/project/Activity3/Movie_7-Activity 3.csv")
movie8 <- read.csv("/cloud/project/Activity3/Movie_8-Activity 3.csv")
movie9 <- read.csv("/cloud/project/Activity3/Movie_9-Activity 3.csv")
movie10 <- read.csv("/cloud/project/Activity3/Movie_10-Activity 3.csv")

merged_movies <- rbind(movie1,movie2,movie3,movie4,movie5,movie6,movie7,movie8,movie9,movie10)

write.csv(merged_movies, "MergedMovies.csv", row.names = FALSE)
