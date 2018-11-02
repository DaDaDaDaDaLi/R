setwd("C:\\Users\\Administrator\\Desktop\\vic")
flowacc<-read.table("flowacc.txt",sep = ",")[,3]
flowacc<-flowacc*10
#这里乘以10是因为arcgis属性值的输出不能超过一千万，
#所以我再前面arcgis上制备数据时候将属性值除以10，现在是相当于恢复原值
id<-round(flowacc/10000000)
V_flowacc<-flowacc-id*10000000
max(V_flowacc)

V_flowacc<-round(V_flowacc,1)

df<-data.frame(id,V_flowacc)
df<-df[order(df$id),]
n1<-nrow(df)
grid_flowacc=c()
n=1
t=0
for(i in 1:n1){
  C_id<-df$id[i]
  C_flowacc<-df$V_flowacc[i]
  if(t<C_flowacc){
    t=C_flowacc
  }
  if(i==n1||C_id!=df$id[i+1]){
    grid_flowacc[n]=t
    n=n+1
    t=0
  }
}

write.table(grid_flowacc,"grid_flowacc.txt",col.names = F,row.names = F,quote = F)
#这段代码的作用是输出296个格网的汇流量的最大值，并将其赋给相应网格
