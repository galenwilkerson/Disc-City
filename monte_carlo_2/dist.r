
############################## UNIFORMLY DISTRIBUTED RADIUS ########################


# plot expected distances of p1 and p2

rm(list = ls())

num.trials <- 10000

# UNIFORMLY distributed radius
r1 <- runif(num.trials)
theta1 <- runif(num.trials) * 2 * pi

r2 <- runif(num.trials)
theta2 <- runif(num.trials) * 2 * pi

x1 <- r1 * cos(theta1)
y1 <- r1 * sin(theta1)

x2 <- r2 * cos(theta2)
y2 <- r2 * sin(theta2)

hist(r1, breaks = 100)
hist(theta1, breaks = 100)

hist(r2, breaks = 100)
hist(theta2, breaks = 100)

hist(x1, breaks = 100)
hist(x2, breaks = 100)
hist(y1, breaks = 100)
hist(y2, breaks = 100)

distance <- sqrt((x1 - x2)^2 + (y1 - y2)^2)

# IS THIS CORRECT, just take distance, not probabilities?

#data <- (r1 * theta1)/pi * (r2 * theta2)/pi * distance
data <- distance

plot(x1,y1, col="green", main="uniformly distributed radius")
points(x2,y2, col="red")


xbreaks <- seq(min(data), max(data), by =  (max(data) - min(data))/1000)
x <- xbreaks[-1]

h <- hist(data, breaks = xbreaks)
length(h$counts)

logh <- log10(h$counts)
logx <- log10(x)

plot(logx, logh)

mycdf <- ecdf(data)
cdf <- mycdf(x)
ccdf <- 1 - cdf

logcdf <- log10(cdf)
logccdf <- log10(ccdf)

plot(logx, logcdf, type = "s")
plot(logx, logccdf, type = "s")


############################## NORMALLY DISTRIBUTED RADIUS ########################


# plot expected distances of p1 and p2


# Normally distributed radius
r1 <- abs(rnorm(num.trials))
theta1 <- runif(num.trials) * 2 * pi

# Normally distributed radius
r2 <- abs(rnorm(num.trials))
theta2 <- runif(num.trials) * 2 * pi

x1 <- r1 * cos(theta1)
y1 <- r1 * sin(theta1)

x2 <- r2 * cos(theta2)
y2 <- r2 * sin(theta2)

hist(r1, breaks = 100)
hist(theta1, breaks = 100)

hist(r2, breaks = 100)
hist(theta2, breaks = 100)

hist(x1, breaks = 100)
hist(x2, breaks = 100)
hist(y1, breaks = 100)
hist(y2, breaks = 100)

distance <- sqrt((x1 - x2)^2 + (y1 - y2)^2)

# IS THIS CORRECT, just take distance, not probabilities?

data <- distance
#data <- (r1 * theta1)/pi * (r2 * theta2)/pi * distance

plot(x1,y1, col="green", main="normally distributed radius")
points(x2,y2, col="red")


xbreaks <- seq(min(data), max(data), by =  (max(data) - min(data))/1000)
x <- xbreaks[-1]

h <- hist(data, breaks = xbreaks)
length(h$counts)

logh <- log10(h$counts)
logx <- log10(x)

plot(logx, logh)

mycdf <- ecdf(data)
cdf <- mycdf(x)
ccdf <- 1 - cdf

logcdf <- log10(cdf)
logccdf <- log10(ccdf)

plot(logx, logcdf, type = "s")
plot(logx, logccdf, type = "s")
