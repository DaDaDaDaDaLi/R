setwd("C:\\Users\\Administrator\\Desktop\\vic\\result\\route")
data<-read.table("intersect_R_T_A.txt",header = T,sep = ",")[,9]
n1<-length(data)
div<-c()
n=1
for(i in 1:n1){
  div[n]=data[i]/0.006944444
  n=n+1
}
div<-round(div,2)
write.table(div,"C:\\Users\\Administrator\\Desktop\\vic\\div.txt",col.names = F,row.names = F,quote = F)
