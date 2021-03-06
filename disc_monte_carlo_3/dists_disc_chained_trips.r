

# random points in circle, drawn from 2D uniform distribution

# A: generate N points in 1 x 1 box
# keep M points within circle radius 1

# B: generate N points in 1 x 1 box
# keep M points within circle radius 1

# create trips between A and B
# calculate distances

# make histogram
# plot lin-lin
# plot log-log

# make cdf
# plot lin-lin
# plot log-log


rm(list = ls())


pointsInDiscUniform <- function(N) {

  x <- c()
  y <- c()
  
  while(length(y) < N) {

    x.rand <- runif(1, -1, 1)
    y.rand <- runif(1, -1, 1)
    
    if (sqrt(x.rand^2 + y.rand^2) <= 1) {
      x <- append(x, x.rand)
      y <- append(y, y.rand)
    }
  }

  return(rbind(x,y))
}

pointsInDiscGaussian <- function(N) {

  x <- c()
  y <- c()
  
  while(length(y) < N) {

    x.rand <- rnorm(1, 0, .2)
    y.rand <- rnorm(1, 0, .2)
    
#   if (sqrt(x.rand^2 + y.rand^2) <= 1) {
    x <- append(x, x.rand)
    y <- append(y, y.rand)
#    }
  }

  return(rbind(x,y))
}


distPoints <- function(A, B) {

  distances <- c()
  
  for (i in 1:(dim(A)[2])) {

      x.diff <- A[1,i] - B[1,i]
      y.diff <- A[2,i] - B[2,i]
      
      euclid.dist <-  sqrt(x.diff^2 + y.diff^2)
  
      distances <- append(distances, euclid.dist)
    }
  
  return(distances)
}

plot.histogram <- function(distances) {
  
  x.values <- seq(0,max(distances)+0.01,.01)
#  x.values <- seq(0,2,.01)
  myhist <- hist(distances, breaks = x.values, main="lin-lin hist")

  logx <- log10(x.values[-1])
  logcounts <- log10(myhist$counts)
  plot(logx, logcounts, main="log-log hist")
}

plot.pdf <- function(distances) {
  
  x.values <- seq(0,max(distances)+0.01,.01)
#  x.values <- seq(0,2,.01)
  myhist <- hist(distances, breaks = x.values, plot=F)

  plot(x.values[-1], myhist$density, main="lin-lin PDF")
  
  logx <- log10(x.values[-1])
  logfreq <- log10(myhist$density)
  plot(logx, logfreq, main="log-log PDF")
}

plot.ccdf <- function(distances) {
  
  sorted.x <- sort(distances)

  cdf <- c()
  ccdf <- c()

  len <- length(distances)

  for (i in 1:len) {
    cdf <- append(cdf, i/len)
    ccdf <- append(ccdf, 1 - cdf[i])
  }

  plot(sorted.x, ccdf, main="lin-lin CCDF")
  
  plot(log10(sorted.x), log10(ccdf), main="log-log CCDF")
}


# for each individual, generate a set of trips such that the total distance <= MAX.DIST
individual.trips.chained <- function(N, MAX.DIST) {
  
  trip.distances <- c()

    # the A points
    plot(0,0, col="green", xlim = c(-2,2), ylim = c(-2,2))

  for (i in 1:N) {

    # home point
    home.point <- pointsInDiscGaussian(1)

    


    old.point <- home.point

    total.dist <- 0

    
    # note, stops AFTER reaching max 
    while(total.dist < MAX.DIST) {

      new.point <- pointsInDiscGaussian(1)
      
      points(new.point[1,], new.point[2,], col="green")
   
      this.distance <- distPoints(old.point, new.point)

      # store the distance
      trip.distances <- append(trip.distances, this.distance)
      
      total.dist <- total.dist + this.distance

      old.point <- new.point
    }

    # trip to return home
    this.distance <- distPoints(old.point, home.point)

    # store the distance
    trip.distances <- append(trip.distances, this.distance)
      
    total.dist <- total.dist + this.distance
    
  }

  return(trip.distances)
}

# number of individuals
N = 100

# total distance per individual
MAX.DIST = 50

distances <- individual.trips.chained(N, MAX.DIST)

plot.pdf(distances)

plot.ccdf(distances)
