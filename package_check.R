# Small script to check if packages are installed.

pcks__ <- c("ISLR", "tidyverse", "haven", "readxl", "MASS", "glmnet", "splines", 
          "class", "pROC", "rpart", "rpart.plot", "randomForest", "ca", 
          "igraph", "ggdendro", "dendextend")

ip__ <- rownames(installed.packages())

if (!all(pcks__ %in% ip__)) {
  message("Package(s) missing. \n",
          "Please install the following packages: ", 
          paste0("\n  - ", pcks__[!pcks__ %in% ip__]))
} else {
  message("All required packages are installed.")
}

rm(pcks__, ip__)
