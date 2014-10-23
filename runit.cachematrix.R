library("RUnit")
source("cachematrix.R")

soluble <- matrix(5)
cache <- makeCacheMatrix(soluble)
checkEquals(cacheSolve(cache), matrix(0.2))
checkEquals(cacheSolve(cache) %*% soluble, diag(1))

soluble <- matrix(1:4, 2, 2)
cache <- makeCacheMatrix(soluble)
checkEquals(cacheSolve(cache), matrix(c(-2, 1, 1.5, -0.5), 2, 2))
checkEquals(cacheSolve(cache) %*% cache$getMatrix(), diag(2))

insoluble <- matrix(1:16, 4, 4)
cache$setMatrix(insoluble)
checkException(cacheSolve(cache))