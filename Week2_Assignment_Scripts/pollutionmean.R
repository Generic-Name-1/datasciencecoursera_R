#Part 1


#Just testing and importing a single file so i can see what it will look like before I input it into a function
pollution_data_1 <- read.csv("001.csv")


#This works for when I want to import just a small amount of files, but not now
data1 <- data.frame()

files <- dir()

for (i in 1:5){
  
  file <- files[i]
  
  import <- read.csv(file, sep = ",")
  
  data1 <- rbind(data1,import) }



pollutant_mean <- function(directory = "specdata", id = 1:5, pollutant = "sulfate") {
   
  new_dir <- paste("../Data/",directory, sep = "")
  
  files <- list.files(new_dir, full.names = TRUE)
  
  data1 <- data.frame()
  
  for (i in id){
    
    file <- files[i]
    
    import <- read.csv(file, sep = ",")
    
    data1 <- rbind(data1,import)
    
  }
  
  final_set <- data1[,pollutant]
  
  mean <- mean(final_set, na.rm = TRUE)
  
  return(mean)
  }
  