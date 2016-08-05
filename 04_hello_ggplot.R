library(ggplot2)
library(dplyr)
library(gapminder)
library(MASS)

# Google ggplot2 Cheat Sheet!
# https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

# Let's look at it first
glimpse(Boston)
# Too much info. Let's check each of them!
pairs(Boston %>% sample_n(100))

# Let's look at it first
gapminder %>% ggplot(aes(lifeExp)) + geom_histogram()
gapminder %>% ggplot(aes(gdpPercap)) + geom_histogram()
# Scale it to beautify!
# Find Bell-curve-ly curve
gapminder %>% ggplot(aes(gdpPercap)) + geom_histogram() + scale_x_log10()
gapminder %>% ggplot(aes(gdpPercap, lifeExp)) + geom_point() + scale_x_log10() + geom_smooth()

# Let's look at it first
diamonds %>% ggplot(aes(carat, price)) + geom_point()
# Too much dots. Let's see the density of it!
diamonds %>% ggplot(aes(carat, price)) + geom_point(alpha=.01)

# Let's look at it first
mpg %>% ggplot(aes(cyl, hwy)) + geom_point()
# Each point can contain multiple points. Let's scatter them to see it!
mpg %>% ggplot(aes(cyl, hwy)) + geom_jitter()

# Let's look at it first
mpg %>% ggplot(aes(class, hwy)) + geom_boxplot()
# Each point can contain multiple points. Let's scatter them to see it!
# Too much dots. Let's see the density of it!
mpg %>% ggplot(aes(class, hwy)) + geom_jitter(col='gray') + geom_boxplot(alpha=.5)
# Reorder it by median!
mpg %>% mutate(class=reorder(class, hwy, median)) %>%
  ggplot(aes(class, hwy)) + geom_jitter(col='gray') +
  geom_boxplot(alpha=.5)
# Custom reordoring!
mpg %>% mutate(class=factor(class, levels=
                        c("2seater", "subcompact", "compact", "midsize",
                          "minivan", "suv", "pickup"))) %>%
  ggplot(aes(class, hwy)) + geom_jitter(col='gray') +
  geom_boxplot(alpha=.5)
# Flip it to see its strings clearly!
mpg %>%
  mutate(class=factor(class, levels=
                        c("2seater", "subcompact", "compact", "midsize",
                          "minivan", "suv", "pickup"))) %>%
  ggplot(aes(class, hwy)) + geom_jitter(col='gray') +
  geom_boxplot(alpha=.5) + coord_flip()

# Four data visualization: is it possible?
gapminder %>% filter(year==2007) %>%
  ggplot(aes(gdpPercap, lifeExp)) +
  geom_point() + scale_x_log10() +
  ggtitle("Gapminder data for 2007")

# Coloring & Size!
gapminder %>% filter(year==2002) %>%
  ggplot(aes(gdpPercap, lifeExp)) +
  geom_point(aes(size=pop, col=continent)) + scale_x_log10() +
  ggtitle("Gapminder data for 2007")

# Use grouping!
# By Color!
gapminder %>%
  ggplot(aes(year, lifeExp, group=country, col=continent)) +
  geom_line(alpha=.7)
# Or simply draw it many times!
gapminder %>%
  ggplot(aes(year, lifeExp, group=country, col=continent)) +
  geom_line(alpha=.7) +
  facet_wrap(~ continent)