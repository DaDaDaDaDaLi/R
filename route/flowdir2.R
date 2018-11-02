setwd("C:\\Users\\Administrator\\Desktop\\vic")
flowacc<-read.table("F_grid_flowacc.txt")
flowacc<-as.matrix(flowacc)

grid_dir<-matrix(,ncol = 28,nrow = 19)
n1=nrow(flowacc)
n2=ncol(flowacc)
DIR<-c(1:8)
if(F){
  for(i in 1:n1){
    for(j in 1:n2){
      if(flowacc[i,j]==-9999)
        flowacc[i,j]=0
    }
  }
  write.table(flowacc,"lhh_flowacc.txt",col.names = F,row.names = F,quote = F)
  #这里是将-9999转化为0用的，arcgi是默认输出-9999
  V1 = flowacc[i-1,j] - flowacc[i,j]
  V2 = flowacc[i-1,j+1] - flowacc[i,j]
  V3 = flowacc[i,j+1] - flowacc[i,j]
  V4 = flowacc[i+1,j+1] - flowacc[i,j]
  V5 = flowacc[i+1,j] - flowacc[i,j]
  v6 = flowacc[i+1,j-1] - flowacc[i,j]
  V7 = flowacc[i,j-1] - flowacc[i,j]
  V8 = flowacc[i-1,j-1] - flowacc[i,j]
}



for(i in 1:n1){
  for(j in 1:n2){
    V1=0
    V2=0
    V3=0
    V4=0
    V5=0
    V6=0
    V7=0
    V8=0
    if(flowacc[i,j]==0){
      grid_dir[i,j]=0
    }
    else{
      #下面的所有if，else if语句都是列出流向的特殊情况，分别是最上面一行，最下面一行，最左最右两列
      if(i==1){
        V3=flowacc[i,j+1]-flowacc[i,j]
        V4=flowacc[i+1,j+1]-flowacc[i,j]
        V5=flowacc[i+1,j]-flowacc[i,j]
        v6=flowacc[i+1,j-1]-flowacc[i,j]
        V7=flowacc[i,j-1]-flowacc[i,j]
        VN=c(V3,V4,V5,V6,V7)
        t1=0
        t2=0
        for(k in 1:5){
          if(t1<VN[k]){
            t1=VN[k]
            t2=k
          }
            
        }
        if(t1==0){
          grid_dir[i,j]=-99
        }
        else{
          grid_dir[i,j]=t2+2
        }
      }
      else if(j==1){
        V1 = flowacc[i-1,j] - flowacc[i,j]
        V2 = flowacc[i-1,j+1] - flowacc[i,j]
        V3 = flowacc[i,j+1] - flowacc[i,j]
        V4 = flowacc[i+1,j+1] - flowacc[i,j]
        V5 = flowacc[i+1,j] - flowacc[i,j]
        VN=c(V1,V2,V3,V4,V5)
        t1=0
        t2=0
        for(k in 1:5){
          if(t1<VN[k]){
            t1=VN[k]
            t2=k
          }
        }
        if(t1==0){
          grid_dir[i,j]=-99
        }
        else{
          grid_dir[i,j]=t2
        }
      }
      else if(i==19){
        V1 = flowacc[i-1,j] - flowacc[i,j]
        V2 = flowacc[i-1,j+1] - flowacc[i,j]
        V3 = flowacc[i,j+1] - flowacc[i,j]
        V7 = flowacc[i,j-1] - flowacc[i,j]
        V8 = flowacc[i-1,j-1] - flowacc[i,j]
        VN=c(V1,V2,V3,V7,V8)
        t1=0
        t2=0
        for(k in 1:5){
          if(t1<VN[k]){
            t1=VN[k]
            t2=k
          }
            
        }
        if(t1==0){
          grid_dir[i,j]=-99
        }
        else{
          if(t2<4){
            grid_dir[i,j]=t2
          }
          else{
            grid_dir[i,j]=t2+3
          }
          
        }
      }
      else if(j==28){
        V1 = flowacc[i-1,j] - flowacc[i,j]
        V5 = flowacc[i+1,j] - flowacc[i,j]
        v6 = flowacc[i+1,j-1] - flowacc[i,j]
        V7 = flowacc[i,j-1] - flowacc[i,j]
        V8 = flowacc[i-1,j-1] - flowacc[i,j]
        VN=c(V1,V5,V6,V7,V8)
        t1=0
        t2=0
        for(k in 1:5){
          if(t1<VN[k]){
            t1=VN[k]
            t2=k
          }
        }
        if(t1==0){
          grid_dir[i,j]=-99
        }
        else{
          if(t2==1){
            grid_dir[i,j]=t2
          }
          else{
            grid_dir[i,j]=t2+3
          }
        }
      }
      else{
        V1 = flowacc[i-1,j] - flowacc[i,j]
        V2 = flowacc[i-1,j+1] - flowacc[i,j]
        V3 = flowacc[i,j+1] - flowacc[i,j]
        V4 = flowacc[i+1,j+1] - flowacc[i,j]
        V5 = flowacc[i+1,j] - flowacc[i,j]
        v6 = flowacc[i+1,j-1] - flowacc[i,j]
        V7 = flowacc[i,j-1] - flowacc[i,j]
        V8 = flowacc[i-1,j-1] - flowacc[i,j]
        VN=c(V1,V2,V3,V4,V5,V6,V7,V8)
        t1=0
        t2=0
        for(k in 1:8){
          if(t1<VN[k]){
            t1=VN[k]
            t2=k
          }
        }
        if(t1==0){
          grid_dir[i,j]=-99
        }
        else{
          grid_dir[i,j]=t2
        }
        
      }
    }
      
  }
}
grid_dir<-as.array(grid_dir)
write.table(grid_dir,"lhh_F_dir1.txt",col.names = F,row.names = F,quote = F)
#这段代码可以自动监测死循环，但检查出来后还需要自己手动排除
#这段代码的作用是根据flowdir1的结果，附流向对应代码
