# preprocessing for song data
# source of raw data: https://www.kaggle.com/mousehead/songlyrics, version 1
# last edited by Erik-Jan van Kesteren on 20181106

# load tidyverse for data wrangling
library(tidyverse)

# read in the data
songs_raw <- read_csv("data/songdata_raw.csv")

# define common words of interest
# taken very roughly from a random website 
# https://www.sporcle.com/games/rockgolf/99_but_no_luftballons/results
common_words <- c(
  "i", "love", "you", "me", "we", "to", "be", "do", "go", "no", "baby", "heart", 
  "life", "down","world", "over", "eyes", "bad", "away", "together", "tonight",
  "everything", "live", "make", "back", "hey"
)

# Create a list with regular expressions out of these for searching
common_words_regex <- lapply(common_words, function(word) {
  regex(paste0("\\b", word, "\\b"), ignore_case = TRUE)
})

# Find and count all occurrences of each word and return a matrix
cols <- sapply(common_words_regex, str_count, string = songs_raw$text)
colnames(cols) <- common_words

# create a data frame out of this, with the artist included
songs <- bind_cols(artist = songs_raw$artist, as_tibble(cols))

# calculate the average occurrence of these words per artist
songs_ca <- 
  songs %>% 
  group_by(artist) %>% 
  summarise_all(function(i) sum(i)/length(i)) %>% 
  as.data.frame()

# move artist column to rownames for the ca() function
rownames(songs_ca) <- songs_ca$artist
songs_ca <- songs_ca[, -1]

# select a random subsample of the artists for analysis
set.seed(456)
sel <- sample(1:nrow(songs_ca), 12)
songs_ca <- songs_ca[sel, ]

# save the data to an R object file
save(songs_ca, file = "data/songs_ca.RData")