Path <- "D:\\data_xijiang\\F_F_1982\\forcing_1982\\2_prec"
FileNames <- dir(Path)
FilePath <- paste(Path,FileNames,sep = "\\")
n1 <- length(FilePath)
n3 = 1
Sum = rep(0,365)
for(i in 1:n1){
  prec <- read.table(FilePath[i])[,7]
  n2 = length(prec)
  
  
  for(j in 1:n2){
    Sum[n3] <- Sum[n3] + prec[j]
  }
  n3 <- n3 + 1 
}
ave_prec <- Sum/365
ave_prec <- round(ave_prec,2)
write.table(ave_prec,"D:\\data_xijiang\\F_F_1982\\rout\\DailyPrec.txt",col.names = F,row.names = F,quote = F)
