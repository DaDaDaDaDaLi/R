#接下来写数据如何合并，以其中十年的数据为例
Path<-"C:\Users\\Administrator\\Desktop\\c\R\\foring_ncdf\\TMAX\\1951-1960"
Filenames <- dir(Path)
FilePath <- paste(Path,Filenames,sep = "\\")
n1<-length(FilePath)

grid_TMAX<-matrix(,ncol = 4661,nrow = 3653,byrow = T)
for(i in 1:n1){
  V<-read.table(file = FilePath[i])
  V<-as.matrix(V)
  grid_TMAX[,i]<-V
}
#以上是1951-1960的TMAX数据
Path<-"C:\Users\\Administrator\\Desktop\\c\R\\foring_ncdf\\TMIN\\1951-1960"
Filenames <- dir(Path)
FilePath <- paste(Path,Filenames,sep = "\\")
n1<-length(FilePath)

grid_TMIN<-matrix(,ncol = 4661,nrow = 3653,byrow = T)
for(i in 1:n1){
  V<-read.table(file = FilePath[i])
  V<-as.matrix(V)
  grid_TMIN[,i]<-V
}
#以上是1951-1960的TMIN数据
Path<-"C:\Users\\Administrator\\Desktop\\c\R\\foring_ncdf\\PREC\\1951-1960"
Filenames <- dir(Path)
FilePath <- paste(Path,Filenames,sep = "\\")
n1<-length(FilePath)

grid_PREC<-matrix(,ncol = 4661,nrow = 3653,byrow = T)
for(i in 1:n1){
  V<-read.table(file = FilePath[i])
  V<-as.matrix(V)
  grid_PREC[,i]<-V
}
#以上是1951-1960的PREC数据
Path<-"C:\Users\\Administrator\\Desktop\\c\R\\foring_ncdf\\WIND\\1951-1960"
Filenames <- dir(Path)
FilePath <- paste(Path,Filenames,sep = "\\")
n1<-length(FilePath)

grid_WIND<-matrix(,ncol = 4661,nrow = 3653,byrow = T)
for(i in 1:n1){
  V<-read.table(file = FilePath[i])
  V<-as.matrix(V)
  grid_WIND[,i]<-V
}
#以上是1951-1960的WIND数据
grid_point_lati<-read.table("D:\\data_xijiang\\data_long_lati.txt",sep = ",")[,5]
grid_point_lati<-round(grid_point_lati,4)
n1<-length(grid_point_lati)
c1<-c()
for(i in 1:n1){
  c1[i]<-as.character(grid_point_lati[i])
}
for(i in 1:n1){
  if(nchar(c1[i])!=7){
    if(nchar(c1[i])==6){
      c1[i]<-paste(c1[i],"0",sep = "")
    }
    else if(nchar(c1[i])==5){
      c1[i]<-paste(c1[i],"00",sep = "")
    }
    else if(nchar(c1[i])==4){
      c1[i]<-paste(c1[i],"000",sep = "")
    }
    else{
      c1[i]<-paste(c1[i],"0000",sep = "")
    }
  }
}
#写这里的代码的作用就是r语言输出是若输出名是32.200他会自动省去00变成32.2，这样vic模型就识别不出来了，这里的解决办法是
#将数字转化为字符，这样就不会出现这样情况

grid_point_long<-read.table("D:\\data_xijiang\\data_long_lati.txt",sep = ",")[,4]
grid_point_long<-round(grid_point_long,4)
grid_point_long<-as.character(grid_point_long)
c2<-c()
for(i in 1:n1){
  c2[i]<-as.character(grid_point_long[i])
}
for(i in 1:n1){
  if(nchar(c2[i])!=8){
    if(nchar(c2[i])==7){
      c2[i]<-paste(c2[i],"0",sep = "")
    }
    else if(nchar(c2[i])==6){
      c2[i]<-paste(c2[i],"00",sep = "")
    }
    else if(nchar(c1[i])==5){
      c2[i]<-paste(c2[i],"000",sep = "")
    }
    else{
      c2[i]<-paste(c2[i],"0000",sep = "")
    }
  }
}
#理由同上
grid_point<-data.frame(c1,c2)

C_data<-array(data=NA,c(3653,4,4661))
for(k in 1:4661){
  C_data[,1,k]<-grid_PREC[,k]
  C_data[,2,k]<-grid_TMAX[,k]
  C_data[,3,k]<-grid_TMIN[,k]
  C_data[,4,k]<-grid_WIND[,k]
}
C_data<-C_data/10
#这里的数据要着重看一看，看看要不要除以10
for(k in 1:4661){
  write.table(C_data[,,k],file = paste("我也不知道应该放在哪儿\\data",grid_point$c1[k],grid_point$c2[k],sep = "_"),col.names = F,row.names = F,quote = F)
}
#最终数


