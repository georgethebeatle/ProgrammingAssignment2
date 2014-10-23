library("RUnit")
source("cachematrix.R")

# 1 dimensional matrix
soluble <- matrix(5)
cache <- makeCacheMatrix(soluble)
checkEquals(cacheSolve(cache), matrix(0.2))
checkEquals(cacheSolve(cache) %*% soluble, diag(1))

# 2 dimensional matrix
soluble <- matrix(1:4, 2, 2)
cache <- makeCacheMatrix(soluble)
checkEquals(cacheSolve(cache), matrix(c(-2, 1, 1.5, -0.5), 2, 2))
checkEquals(cacheSolve(cache) %*% cache$getMatrix(), diag(2))

# matrix that cannot be reversed
insoluble <- matrix(1:16, 4, 4)
cache$setMatrix(insoluble)
checkException(cacheSolve(cache))

# function that captures caching message
makeMessageCaptor <- function() {
  msg <- NULL
  setMessage <- function(message) { msg <<- message }
  getMessage <- function() { msg }
  list(setMessage = setMessage, getMessage = getMessage)
}

# ensure that once the matrix is solved, cached value is returned
# by capturing the caching message insted of sending it to stdoout
messageCaptor <- makeMessageCaptor()
soluble <- matrix(1)
cache <- makeCacheMatrix(soluble)

# 1st time - expect no message to have been logged
cacheSolve(cache, display=messageCaptor$setMessage)
checkEquals(messageCaptor$getMessage(), NULL)

# 2nd time - expect caching message to have been logged
cacheSolve(cache, display=messageCaptor$setMessage)
checkEquals(messageCaptor$getMessage(), "getting cached data")
