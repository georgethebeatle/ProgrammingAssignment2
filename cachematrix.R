## Functions for memoized calculation of matrix inverse

## 
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
cacheSolve <- function(x, ...) {
    m <- x$getInverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$getMatrix()
    m <- solve(data, ...)
    x$setInverse(m)
    m
}
