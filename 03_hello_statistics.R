library(dplyr)
library(ggplot2)

# Student's Sleep Data
?sleep

# Data for 'extra' value of 'group' 1
# Same code: y <- sleep$extra[sleep$group == 1]
y <- with(sleep, extra[group == 1])

# Descriptive Statistics

# Minimum, 25%, 50%, 75%, Maximum
summary(y)

# Histogram
hist(y)

# Box Plot: 25%~75%: Box, Min~Max: Line
boxplot(y)

# If every dots are on line, it perfectly follows bell curve
qqnorm(y)

# T-test
t.test(y)

# T-test: We want to know whether sleep time has increased!
t.test(y, alternative = "greater")
# p-value: Probability of effect-less medicine returns this result

# Null hypothesis: Medicine has no effect! (ex) Not Guilty! - Cannot be proven)
# Alternative hypothesis: Medicine has an effect! (ex) Guilty! - This can be proven + has to be proven)
# If more and more evidence stack up, Alt. gains power.

# sample's sd is similar to original's sd
# rnorm(Number of samples, mean, sd)
# If medicine has no effect
y_star <- rnorm(10, 0, sd(y))
t_star <- (mean(y_star) - 0) / (sd(y_star)/sqrt(length(y_star)))

# Let's test that for 10000 worlds
set.seed(1606)
worlds <- 1e4
n <- 10
xbars_star <- rep(NA, worlds)
sds_star <- rep(NA, worlds)
ts_star <- rep(NA, worlds)
for(b in 1:worlds){
  y_star <- rnorm(n, 0, 1.789)
  m <- mean(y_star)
  s <- sd(y_star)
  xbars_star[b] <- m
  sds_star[b] <- s
  ts_star[b] <- m / (s/sqrt(n))
}
opar <- par(mfrow=c(2,2))

hist(xbars_star, nclass=100)
abline(v = 0.75, col='red')

hist(sds_star, nclass=100)
abline(v = 1.789, col='red')

hist(ts_star, nclass=100)
abline(v = 1.3257, col='red')

qqnorm(ts_star); qqline(ts_star)
par(opar)

# So, p-value is probability under the assumption no-effect medicine, of obtaining a result more extreme than this experiment
# We will never know the real value.
# Check if confidence interval contains real value at 100 worlds
set.seed(1606)
worlds = 1e2
conf_intervals <-
  data.frame(b=rep(NA, worlds),
             lower=rep(NA, worlds),
             xbar=rep(NA, worlds),
             upper=rep(NA, worlds))
true_mu <- 1.0
for(b in 1:worlds){
  y_star <- rnorm(10, true_mu, 1.8)
  conf_intervals[b, ] = c(b=b,
                          lower=t.test(y_star)$conf.int[1],
                          xbar=mean(y_star),
                          upper=t.test(y_star)$conf.int[2])
}
conf_intervals <- conf_intervals %>%
  mutate(lucky = (lower <= true_mu & true_mu <= upper))
glimpse(conf_intervals)
conf_intervals %>% ggplot(aes(b, xbar, col=lucky)) +
  geom_point() +
  geom_errorbar(aes(ymin=lower, ymax=upper)) +
  geom_hline(yintercept=true_mu, col='red')