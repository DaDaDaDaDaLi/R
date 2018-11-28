setwd("D:\\data_xijiang\\data_result\\rout")
flowacc1<-read.table("shixianshuju.txt")
#这个数据是dem分辨率的数字序号数据arcgis输出文件用来进行对比赋值的
flowacc1<-as.matrix(flowacc1)
n1<-nrow(flowacc1)
n2<-ncol(flowacc1)
#计算行和列
c1=c()
#序号数据
#用来接受非-9999数据
v1=1
for(i in 1:n1){
  for(j in 1:n2){
    if(flowacc1[i,j]!=-9999){
      c1[v1] = flowacc1[i,j]
      v1=v1+1
    }
  }
}

flowacc2<-read.table("shixianshuju3_S.txt")
#这个数据是除以100以后arcgis输出的流量数据
flowacc2<-as.matrix(flowacc2)
n3<-nrow(flowacc2)
n4<-ncol(flowacc2)
c2=c()
#流量数据
#用来接受非-9999数据
v2=1
for(i in 1:n3){
  for(j in 1:n4){
    if(flowacc2[i,j]!=-9999){
      c2[v2]=flowacc2[i,j]
      v2=v2+1
    }
  }
}
if(F){
  #如果Rstdio因为数据量太大而无法计算的话，将下面的代码运行，然后到R-gui中区运行
  write.table(c1,"c1.txt",col.names = F,row.names = F,quote = F)
  write.table(c2,"c2.txt",col.names = F,row.names = F,quote = F)
  #输出c1，c2，因为数据量太大，R无法进行排序
  data_df<-data.frame(c1,c2)
  write.table(data_df,"data_df.txt",col.names = F,row.names = F,quote = F)
  #输出该数据框
}


data_df<-data_df[order(data_df$c1),]
n5<-nrow(data_df)
grid_flowacc=c()
n=1
t=0
for(i in 1:n5){
  C_id<-data_df$c1[i]
  C_flowacc<-data_df$c2[i]
  if(t<C_flowacc){
    t=C_flowacc
  }
  if(i==n5||C_id!=data_df$c1[i+1]){
    grid_flowacc[n]=t
    n=n+1
    t=0
  }
}
n
write.table(grid_flowacc,"grid_flowacc.txt",col.names = F,row.names = F,quote = F)
#这段代码的作用是输出4661个格网的汇流量的最大值，并将其赋给相应网格
if(F){
  #这下面的代码就是R-gui中要运行的代码
  setwd("D:\\data_xijiang\\data_result\\rout")
  data_df<-read.table("data_df.txt")
  class(data_df)
  data_df<-data_df[order(data_df$V1),]
  n5<-nrow(data_df)
  grid_flowacc=c()
  n=1
  t=0
  for(i in 1:n5){
    C_id<-data_df$V1[i]
    C_flowacc<-data_df$V2[i]
    if(t<C_flowacc){
      t=C_flowacc
    }
    if(i==n5||C_id!=data_df$V1[i+1]){
      grid_flowacc[n]=t
      n=n+1
      t=0
    }
  }
  n
  write.table(grid_flowacc,"grid_flowacc.txt",col.names = F,row.names = F,quote = F)
  #这段代码的作用是输出4661个格网的汇流量的最大值，并将其赋给相应网格
}
