# Small script to check if packages are installed.

pcks__ <- c("ISLR", "tidyverse", "haven", "readxl", "MASS", "glmnet", "splines", 
          "class", "pROC", "rpart", "rpart.plot", "randomForest", "ca", 
          "igraph")

ip__ <- rownames(installed.packages())

if (!all(pcks__ %in% ip__)) {
  to_install__ <- pcks__[!pcks__ %in% ip__]
  message("Package(s) missing. \n",
          "Please install the following packages: ", 
          paste0("\n  - ", to_install__))
} else {
  message("All required packages are installed.")
}

rm(pcks__, ip__, to_install__)
