setwd("C:\\Users\\Administrator\\Desktop\\vic")
flowacc<-read.table("flowacc.txt",sep = ",")[,3]
flowacc<-flowacc*10
#�������10����Ϊarcgis����ֵ��������ܳ���һǧ��
#��������ǰ��arcgis���Ʊ�����ʱ������ֵ����10���������൱�ڻָ�ԭֵ
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
#��δ�������������296�������Ļ����������ֵ�������丳����Ӧ����