### Functions to interrogate the databases of matches
library(data.table)

ParallelReader <- function(){
  
  years  <- (1968:2021)

  atp <- "https://raw.githubusercontent.com/Tennismylife/TML-Database/master/"
  
  files <- paste0(atp, years, ".csv")
  
  files <- append(files, "https://raw.githubusercontent.com/Tennismylife/TML-Database/master/ongoing_tourneys.csv")
  
  print(files)
  
  #create f, which is a list of data frames
  f <- lapply(files, function(m) df <- fread(m, na="", quote=F, fill = TRUE))
  
  #stick them all together with do.call-rbind
  f_combine <- do.call("rbind", f)
}
