setwd("C:\\Users\\Administrator\\Desktop\\vic")
R_data<-read.table("cksjwzb.txt")
R_data<-as.matrix(R_data)
#这个不能改
C_data<-read.table("div.txt")
C_data<-as.matrix(C_data)
#这个可以改
T_data<-array(,c(19,28))
n=1
for(i in 1:19){
  for(j in 1:28){
    if(R_data[i,j]==0){
      T_data[i,j]=0
    }
    else{
      T_data[i,j]=C_data[n]
      n=n+1
    }
  }
}
write.table(T_data,"F_div.txt",col.names = F,row.names = F,quote = F)
#这段代码的作用就是省的手动区赋值，因为之前输出的数据都是竖向的，这段代码的作用就是按照标准格式进行赋值