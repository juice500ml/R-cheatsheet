# Hello R!

# Load data from URL
dat = read.table('https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data')
names(dat) <- c('crim', 'zn', 'indus', 'chas', 'nox', 'rm', 'age', 'dis', 'rad', 'tax', 'ptratio', 'black', 'lstat', 'medv')

# Load dplyr
library(dplyr)

# Check data
glimpse(dat)