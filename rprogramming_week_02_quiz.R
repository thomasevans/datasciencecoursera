# Week 2 assignment

id <- 1:5
directory <- "specdata"
pollutant <- "nitrate"

# Part 1 ---------------  
# pollutantmean function
pollutantmean <- function(directory, pollutant, id = 1:332){
  
  list.places <- list()
  
  for(i in seq_along(id)){
    list.places[[i]] <- read.csv(paste(directory, "/", formatC(id[i], width = 3, format = "d", flag = "0"), ".csv", sep = ""))
    }
  
  x <- NULL
  for(i in seq_along(id)){
    x <- c(x, unlist(list.places[[i]][pollutant]))
  }
  x <- x[!is.na(x)]
  x <- sum(x)/length(x)
  return(x)
}

# Test examples
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)



# Part 2 -----------

complete <- function(directory, id = 1:332){
  
  df <- data.frame(id = as.numeric(rep(NA,length(id))),
                   nobs = as.numeric(rep(NA,length(id))))
  temp <- NULL
  
  for(i in seq_along(id)){
    temp <- read.csv(paste(directory, "/", formatC(
      id[i], width = 3, format = "d", flag = "0"), ".csv", sep = ""))
    
    df$id[i] <- id[i]
    df$nobs[i] <- nrow(na.omit(temp))
    temp <- NULL
  }
  
  return(df)
  
}

complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)


# Part 3 ------------

corr <- function(directory, threshold = 0){
  
  # Get df of cases
  df.cases <- complete("specdata")
  
  # Retain those meeting threshold
  df.cases.complete <- df.cases[df.cases$nobs > threshold,]
  
  corrs <- rep(NA, nrow(df.cases.complete))
  
  for(i in seq_along(df.cases.complete$id)){
    temp <- read.csv(paste(directory, "/", formatC(
      df.cases.complete$id[i], width = 3, format = "d", flag = "0"), ".csv", sep = ""))
    
    temp.compl <- na.omit(temp)
    
    corrs[i] <- cor(temp.compl$sulfate, temp.compl$nitrate)
    # ?cor
    temp <- temp.compl <- NULL
  }
  return(corrs)
  
}

cr <- corr("specdata")
summary(cr)
length(cr)


# Quizz ------------
# 1
pollutantmean("specdata", "sulfate", 1:10)

# 2 
pollutantmean("specdata", "nitrate", 70:72)

# 3 
pollutantmean("specdata", "sulfate", 34)

# 4 
pollutantmean("specdata", "nitrate")

#5
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

#6
cc <- complete("specdata", 54)
print(cc$nobs)

#7
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])


#8
cr <- corr("specdata")                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)


#9
cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

#10
cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))