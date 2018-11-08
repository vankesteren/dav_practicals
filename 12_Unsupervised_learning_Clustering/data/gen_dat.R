# Data generation script for the cluster data
library(tidyverse)
library(mvtnorm)

# Create covariance matrix and correlated data
set.seed(123)
sigma <- matrix(c(1, .5, .5, 1), 2, 2)
sim_data <- rmvnorm(n = 100, mean = c(5, 5), sigma = sigma)
colnames(sim_data) <- c("x1", "x2")

# Adjust the centers based on the random classes
clus_df <-
  sim_data %>% 
  as_tibble() %>% 
  mutate(class = sample(c("A", "B", "C"), size = 100, replace = TRUE)) %>% 
  mutate(x2 = case_when(class == "A" ~ x2 + 1.5,
                        class == "B" ~ x2 - 1.5,
                        class == "C" ~ x2 + 1.5),
         x1 = case_when(class == "A" ~ x1 - 1.5,
                        class == "B" ~ x1 - 0,
                        class == "C" ~ x1 + 1.5))

# Save to files
clus_df %>% select(-class) %>% write_csv("data/clusterdata.csv")
clus_df %>% select(class)  %>% write_csv("data/clusterlabels.csv")
