## Functions for memoized calculation of matrix inverse

## Creates a vector of functions that can operate 
## on a matrix stored as variable x
makeCacheMatrix <- function(x = matrix()) {
    inverse <- NULL
    setMatrix <- function(y) {
        x <<- y
        inverse <<- NULL
    }
    getMatrix <- function() x
    setInverse <- function(inv) inverse <<- inv
    getInverse <- function() inverse
    list(setMatrix = setMatrix, getMatrix = getMatrix,
         setInverse = setInverse,
         getInverse = getInverse)
}


## Finds the inverse of a matrix. Returns cached value if
## already calculated
cacheSolve <- function(x, display=message, ...) {
    m <- x$getInverse()
    if(!is.null(m)) {
        display("getting cached data")
        return(m)
    }
    data <- x$getMatrix()
    m <- solve(data, ...)
    x$setInverse(m)
    m
}
