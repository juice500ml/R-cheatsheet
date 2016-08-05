# Hello dplyr!

# Load dplyr & gapminder
library(dplyr)
library(gapminder)

# Hello dplyr!
# Namespace inside dplyr::filter changes (Inside filter, same effect when library(gapminder))
filter(gapminder, continent == "Asia")
# Same thing! dplyr can PIPE data through
gapminder %>% filter(continent == "Asia")

# Pipe operator can be very useful; Great readability
gapminder %>%
  filter(continent == "Asia") %>%
  arrange(year, country)

# Mutate values
gapminder %>%
  mutate(totalGdp = pop * gdpPercap,
         lifeExp_gdp_ratio = lifeExp / gdpPercap )

# Select values
gapminder %>%
  select(country, gdpPercap, lifeExp)

# Mutate & Select only those two
gapminder %>%
  transmute(country,
            totalGdp = pop * gdpPercap,
            lifeExp_gdp_ratio = lifeExp / gdpPercap )

# Summarize values
gapminder %>%
  summarize(n_obs = n(),
            max_gdp = max(gdpPercap))

# Grouping values: VERY POWERFUL
gapminder %>%
  group_by(country) %>%
  summarize(n_obs = n(),
            max_gdp = max(gdpPercap))