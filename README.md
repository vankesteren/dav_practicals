# Data Analysis and Visualisation practicals
This repository contains the prerequisite information and the files for the practicals of the elective master's course _Data Analysis and Visualisation_ at Utrecht University (course code `201600038` in Osiris).

## Prerequisites
__Install `R` and RStudio Desktop (open source) by following the instructions [here](https://www.rstudio.com/products/rstudio/download/#download)__

If you have no experience with `R` or another programming language, you are going to need to catch up before starting the course. Some good sources are:
- The first two chapters of [introduction to R on datacamp](https://www.datacamp.com/courses/free-introduction-to-r)
- Install `R`, play around, and [read the workflow basics chapter in Hadley Wickham's R for Data Science](http://r4ds.had.co.nz/workflow-basics.html#workflow-basics)
- Interactive R course: install `R` as in the previous point and in the console type the following lines one by one
```r
install.packages("swirl")
swirl()
```
and follow the guide to run the `R Programming: The basics of programming in R` interactive course.

__The following is the minimum of what you should know about `R` before starting with the first practical__
- What is `R` (a fancy calculator) and what is an `.R` file (a recipe for calculations)
- How to run `R` code in `RStudio`
- What is a variable `x <- 10`
- What is a function `y <- fun(x = 10)`
- Understand what the following statements do (tip: you may run it in `R` line by line)
```r
y <- "Let him go!"
x <- "Bismillah!"
z <- paste(x, "No, we will not let you go.", y)
rep(z, 3)
1:10
sample(1:20, 4)
sample(1:20, 40, replace = TRUE)
z <- c(1, 2, 3, 4, 5, 4, 3, 2, 1)
z^2
z == 2
z > 2
install.packages("dplyr")
```
- Be able to read the help file of any function, (e.g., type `?plot` in the console)

## Outline of the practicals
Anything written in _italic font_ is optional/extra material.

### Week 1

  - __R basics for DAV__
    - `R` and `RStudio`
    - Project organisation
    - Help files using `?`, CRAN, and internet search
    - `R` files, `notebooks`, and `R Markdown`
    - The `ISLR` package (datasets from James ISLR)
    - The `tidyverse` as a dialect of the `R` language (Wickham R4DS)
    - The [google style guide](https://google.github.io/styleguide/Rguide.xml) (ISLR does not follow it)
    - _R packages on GitHub_

  - __Data manipulation & exploratory data analysis__
    - Data types: `character`, `numeric`, `factor`
    - Lists
    - Loading datasets from `.csv` or `.xlsx` (or other formats with `haven`)
    - `data.frame()` and `tibble()`
    - `View()`, `head()`, `tail()`
    - `summary()`
    - `filter()`, `select()`, and `mutate()` from `dplyr`
    - `bind_rows()`, `bind_cols()`
    - missing values (`na.omit`)
    - `group_by()` and `summarise()` from `dplyr`
    - the pipe operator `%>%`
    - `table()`
    - _dplyr cheatsheet_
    - _wide to long format: `gather` and `spread`_


### Week 2

  - __Data Visualisation using ggplot2__
    - Preparing data for a `ggplot()` call
    - What is a `ggplot` object and how to construct it
    - Aesthetics: `x`, `y`, `size`, `colour`, `fill`
    - `geom_point()`, `geom_line()`, `geom_bar()`
    - Labels, limits
    - `geom_boxplot()`, `geom_density()`
    - _themes (`ggthemes`?)_


### Week 3

  - __HANDIN: Pass / Fail assignment__
    - _Find a dataset and create an Exploratory Data Analysis_
    - Tip: The new [Google dataset search](https://toolbox.google.com/datasetsearch).
    - Format: stand-alone `RStudio` project folder with:
      - the dataset (`csv`, `xlsx`, `sav`, `dat`, `json`, or any other common format)
      - one `.Rmd` notebook file
      - a compiled `.pdf` or `.html`
    - Requirements:
      - explain the dataset in 1 or 2 paragraphs
      - use `tidyverse`
      - clean, legible `R` code (preferably following the google style guide)
      - table(s) with relevant summary statistics
      - descriptive plots
      - explain what you did and why (max 3 paragraphs total)

  - __Supervised learning: Regression 1__
    - `lm()`, the `formula` object, the `lm` object and its methods (`print()`, `summary()`, `coef()`, `plot()`)
    - Regression lines in `ggplot` with uncertainty
    - Linear regression with multiple variables, interaction effects
    - Model assessment:
      - Train/test split
      - Mean square error calculation (`predict()`)
      - AIC, BIC
    - Bias/variance tradeoff


### Week 4

  - __Supervised learning: Regression 2__
    - Feature selection
    - Regularization using the `glmnet` package
    - Optimising lambda


### Week 5

  - __Supervised learning: Regression 3__
    - Polynomial regression
    - Nonlinear regression using the `splines` package
    - Visualising nonlinear regression


### Week 6

  - __Supervised learning: Classification 1__
    - (titanic data? default data?)
    - KNN
    - Logistic regression (see also 4.2)
    - LDA


### Week 7

  - __Supervised learning: assessing classification methods__
    - Confusion matrix, errors, AUC, ROC curve
    - Cross validation on classification problems
    - Classification trees


### Week 8

  - __HANDIN: Pass / Fail assignment__
    - _Find a dataset and create and assess a prediction model_
    - Tip: The new [Google dataset search](https://toolbox.google.com/datasetsearch).
    - Format: stand-alone `RStudio` project folder with:
      - the dataset (`csv`, `xlsx`, `sav`, `dat`, `json`, or any other common format)
      - one `.Rmd` notebook file
      - a compiled `.pdf` or `.html`
      - a `.Rproj` file
    - Requirements:
      - explain the dataset in 1 or 2 paragraphs
      - use `tidyverse`
      - clean, legible `R` code (preferably following the google style guide)
      - explain which method you use
      - assess your predictions
      - make conclusions about your predictions
      - use plots where useful (they are almost always useful)
  - __Unsupervised learning: PCA & Correspondence Analysis__
    - PCA using `princomp`
    - Visualising PCA
    - SVD
    - Correspondence Analysis & Biplots


### Week 9

  - __Unsupervised learning: Clustering__
    - K-means clustering with `kmeans()`
    - Hierarchical clustering with `hclust()`
    - Visualising clusters in `ggplot`
    - [Modularity clustering](https://arxiv.org/pdf/physics/0602124.pdf) with [igraph](http://igraph.org/r/doc/cluster_leading_eigen.html)
