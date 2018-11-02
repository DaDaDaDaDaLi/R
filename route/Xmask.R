setwd("C:\\Users\\Administrator\\Desktop\\vic")
data<-read.table("lhh_F_dir1.txt")
n1<-nrow(data)
n2<-ncol(data)
for(i in 1:n1){
  for(j in 1:n2){
    if(data[i,j] != 0){
      if(data[i,j] %in% c(1,3,5,7)){
        data[i,j]=6895
      }
      if(data[i,j] %in% c(4,8)){
        data[i,j]=11539
      }
      if(data[i,j] %in% c(2,6)){
        data[i,j]=10888
      }
    }
  }
}
write.table(data,"C:\\Users\\Administrator\\Desktop\\vic\\result\\route\\xmask1.txt",col.names = F,row.names = F,quote = F)
#这个代码就是计算流程的，我把他简单化了。先用arcgis测出横向，竖向，和斜方向的距离，根据数字，附上相应距离