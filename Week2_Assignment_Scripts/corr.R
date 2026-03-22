
#Passes all my internal checks for the demo


corr <- function(directory = "specdata", threshold = 0) {
  
  source("complete.R")
  
  complete_cases_check <- complete(directory = directory, 
                                   id = 1:332)
  
  #Its kinda an clunkier way to do this, but I have to get the get a logical vector before I filter out the data
  
  CHECK <- complete_cases_check$nobs > threshold
  
  complete_cases_check <- complete_cases_check[CHECK,]
  
  new_dir <- paste("../Data/", directory, sep = "")
  
  files <- list.files(new_dir, full.names = TRUE)
  
  corr_vector <- c()
  
  for (i in complete_cases_check$id){
    
    file <- files[i]
    
    import <- read.csv(file, sep = ",")
    
    corr_1 <-cor(x = import$sulfate,
                 y = import$nitrate,
                 use = "complete",
                 method = "pearson")
    
    corr_vector <- c(corr_vector, corr_1)
  }
  
 return(corr_vector)
  
}
