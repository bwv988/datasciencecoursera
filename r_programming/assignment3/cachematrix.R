# cachematrix.R
#
# This code implements caching the inverse of a matrix in an 
# object and implements a cache-aware variant of R's solve().
#
#   makeCacheMatrix - Creates a new object (list) with 
#                     getter and setter functions for caching
#                     the inverse of a matrix.
#   cacheSolve      - A cached variant of solve() utilizing 
#                     the above.
#
# Example Use:
#
#   cmat <- makeCacheMatrix(matrix(c(2, 3, 2, 2), 2, 2, byrow=TRUE))
#   cacheSolve(cmat)


## makeCacheMatrix()
##
## Object of type list to store an matrix and cache its inverse.
##
## Functions:
##    set() - Set the value of the matrix.
##    get() - Return the original matrix.
##    getinverse() - Return the cached inverse of the matrix.
##    setinverse() - Set the value of the cached inverse.
##
makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL
  set <- function(y) {
    x <<- y
    inverse <<- NULL
  }
  get <- function() x
  setinverse <- function(val) inverse <<- val
  getinverse <- function() inverse
  # Create a new object of type list to wrap the above functions
  # so they can be accessed via "$".
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
  
}

## cacheSolve()
##
## This is a cached version of R's solve().
## 
## The function first checks if the inverse has already been cached, 
## if so, it returns the stored value, otherwise it calculates the
## inverse and stores it in the cache.
cacheSolve <- function(x, ...) {
  i <- x$getinverse()
  if(!is.null(i)) {
    message("Getting cached data...")
    return(i)
  }
  mat <- x$get()
  i <- solve(mat, ...)
  x$setinverse(i)
  i
}
