## Put comments here that give an overall description of what your
## functions do

## This function effectively does what the makeVector () function example does where it . I tried to do a line by line explanation 
## to help me understand what this function actually does because I think I got this to work, but it is still confusing. Anyways,
## this function will convert a matrix that you input into it (which I used TEST) into the format where it can be solved by the 
## Cache solve function 

TEST <- matrix(1:4, nrow = 2, ncol = 2)

makeCacheMatrix <- function(x = numeric()) {
  
  #Sets the cached matrix to NULL to start
  m <- NULL
  
  #Creates the function set () which can then be called later on (when we run it inside the CacheSolve function)
  set <- function(y) {
    x <<- y 
    m <<- NULL
  }
  get <- function() x #Creates the function get() which just returns x
  setsolve <- function(solve) m <<- solve #inputs data into it to solve for the inverted matrix
  getsolve <- function() m
  list(set = set, get = get, #List of 4 functions which can and will be called later in the CacheSolve function()
       setsolve = setsolve,
       getsolve = getsolve)

}


## This function will take the input form the makeCacheMatrix and check to see the inverse matrix has already been solved.
## If it has already been solved, then it just exports and returns the inverse matrix. If not, it pulls the data from get 
## (which is just the original inputed matrix that has been saved) and solves it and then returns that answer


cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  
  m <- x$getsolve() #Checks to see if the inverse of x has already been calculated and then returns m if it was already calculated
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get() #If the answer has not been cached and saved, it is recalculated by pulling the data and solving it and making it equal to m 
  m <- solve(data, ...)
  x$setsolve(m)
  m #m is returned after the setsolve() whihc is equal to the solution of the matrix is returned
}












#Example old functions that I used as the basis for this function


makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}

cachemean <- function(x, ...) {
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}