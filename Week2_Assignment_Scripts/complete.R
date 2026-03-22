




complete <- function(directory = "specdata", id = 1:5) {
  
  new_dir <- paste("../Data/",directory, sep = "")
  
  files <- list.files(new_dir, full.names = TRUE)
  
  data1 <- data.frame()
  
  for (i in id){
    
    file <- files[i]
    
    import <- read.csv(file, sep = ",")
    
    data1 <- rbind(data1, c(i, sum(complete.cases(import))))
    
  }
  
  colnames(data1) = c("id","nobs")
  return(data1)
  }