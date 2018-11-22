Path="D:\\data_xijiang\\data_result\\forcing\\XJ_day_forcing_data\\prec"
Filenames<-dir(Path)
FilePath<-paste(Path,Filenames,sep = "\\")
n1=length(FilePath)
#n1���ļ���
grid_point_lati<-read.table("D:\\data_xijiang\\data_long_lati.txt",header = F,sep = ",")[,5]
grid_point_lati<-round(grid_point_lati,2)
grid_point_long<-read.table("D:\\data_xijiang\\data_long_lati.txt",header = F,sep = ",")[,4]
grid_point_long<-round(grid_point_long,2)
grid_point<-data.frame(grid_point_lati,grid_point_long)
n2<-nrow(grid_point)
#n2������������4661
grid_point<-as.matrix(grid_point)#����������ľ�γ������



sample_point<-read.table("D:\\data_xijiang\\data_result\\forcing\\XJ_day_forcing_data\\prec\\day_prec_2010_1_1_.txt")[,c(2,3,7)]
sample_point<-as.matrix(sample_point)
n3<-nrow(sample_point)
#n3����ѡ�������ˮ��վ�������104
dis<-array(data=NA,c(4661,104))
for(j in 1:n2){
  for(k in 1:n3){
    dis[j,k]<-sqrt((grid_point[j,1]-sample_point[k,1])^2+(grid_point[j,2]-sample_point[k,2])^2)
  }
}
dis<-round(dis,2)
#��������������ʹ���ֵ����˵�����ǵ���Ծ����ǲ����,���ֻ�Ǵ���ֵ���ֵ

for(i in 1:n1){
  V_S_code<-read.table(file=FilePath[i])[,1]
  lati<-read.table(file=FilePath[i])[,2]
  long<-read.table(file=FilePath[i])[,3]
  year<-read.table(file=FilePath[i])[,4]
  month<-read.table(file=FilePath[i])[,5]
  day<-read.table(file=FilePath[i])[,6]
  if(month<10){
    month<-as.character(month)
    month<-paste("00",month,sep = "")
  }
  else if(month>=10){
    month<-as.character(month)
    month<-paste("0",month,sep = "")
  }
  if(day<10){
    day<-as.character(day)
    day<-paste("00",day,sep = "")
  }
  else if(day>=10){
    day<-as.character(day)
    day<-paste("0",day,sep = "")
  }
  prec<-read.table(file=FilePath[i])[,7]
  df<-data.frame(V_S_code,lati,long,year,prec)
  
  m_df<-as.matrix(df)
  V_grid=rep(0,4661)
  for(l in 1:n2){
    FM=0
    #��ĸ
    W=c()
    #Ȩ��
    t1=c()
    n4=1
    for(m in 1:n3){
      t1[n4]<-dis[l,m]
      n4=n4+1
    }
    t1<-sort(t)
    t2=c()
    n5=1
    for(n in 1:10){
      t2[n5]<-t1[n]
      n5=n5+1
    }
    for(m in 1:10){
      FM=FM+(1/dis[l,m])^2
    }
    
    
    for(m in 1:10){
      W[m]=(1/dis[l,m])^2/FM
    }
    #�����൱�ڰѵ�l���Ĵ���ֵ���Ӧ�ĸ���������Ȩ�ؼ��������
    for(m in 1:10){
      V_grid[l]=V_grid[l]+W[m]*m_df[m,5]
    }
    #�ѵ�l������ֵ���ֵ�������
  }
  V_grid=round(V_grid,2)#�������������һ�����ݿ�Ȼ������cbind()�����Ѿ�γ�ȼ��ϣ���Ӧ��ľ�γ��һֱ����
  
  write.table(V_grid,file=paste("D:\\data_xijiang\\data_result\\forcing\\improve_XJ_IDW_prec\\grid_prec",year[1],month[1],day[1],".txt",sep = "_"),col.names = F,row.names=F,quote = F)
}
#�����ֵ�������ֵʱ��ðѶ�Ӧ����γ��Ҳ���ϣ������Ǽ��ˣ��������������յ���������ʱ���ļ�����Ҫ���϶�Ӧ����γ��


if(F){
  t1=c()
  n4=1
  for(m in 1:n3){
    t1[n4]<-dis[1,m]
    n4=n4+1
  }
  t1<-sort(t)
  t2=c()
  n5=1
  for(n in 1:10){
    t2[n5]<-t1[n]
    n5=n5+1
  }
}