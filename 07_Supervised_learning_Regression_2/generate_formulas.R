# R function to generate all formulas up to size n
# Erik-Jan van Kesteren
# October 2018
# 
# Input : 
#  p      : number of variables 
#  x_vars : character vector of x vars
#  y_var  : character of y var
#
# Output: character vector of formulas
generate_formulas <- function(p, x_vars, y_var) {
  # Input checking
  if (p %% 1 != 0)           stop("Input an integer n")
  if (p > length(x_vars))    stop("p should be smaller than number of vars")
  if (!is.character(x_vars)) stop("x_vars should be a character vector")
  if (!is.character(y_var))  stop("y_vars should be character type")
  
  # combn generates all combinations, apply turns them into formula strings
  apply(combn(x_vars, p), 2, function(vars) {
    paste0(y_var, " ~ ", paste(vars, collapse = " + "))
  })
}
