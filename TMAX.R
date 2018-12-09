library(ncdf4)
setwd("D:\\data_xijiang\\forcing_fang\\forcing_XJ")
temp_1<-nc_open("CN_MaxTemperature_daily_1951-2017_XJ.nc")
#��nc�ļ�

temp_lati<-ncvar_get(temp_1,"Latitude")
temp_long<-ncvar_get(temp_1,"Longitude")
#���δ�����Ҫ��R_GUI������
temp_time<-ncvar_get(temp_1,"time")
temp_TMAX<-ncvar_get(temp_1,"MaxTemperature")
#���϶��Ƕ�ȡ��Ӧ����


TMAX<-array(,c(72,156,24472))

for(i in 1:24472){
    for(j in 1:156){
      for(k in 1:72){

        TMAX[k,j,i]<-temp_TMAX[j,k,i]

      }
    }
} 
dim(TMAX)
#���������ת��
#��������γ�ȴӵ�6�м������65��
#���ȴӵ�4�м������122��
TMAX_T<-array(,c(66,123,24472))
#��ű�׼��ʽ��TMAX����
for(l in 1:24472){
  for(m in 1:72){
	if(m>=6&&m<=71){
    for(n in 1:156){
        if(n>=4&&n<=126){
        TMAX_T[m-5,n-3,l]<-TMAX[m,n,l]
        }
     }
    }
  }
} 
#�������ݸ�ʽ
TMAX_F<-array(,c(66,123,24472))
#�������TMAX����
data_1<-read.table("C:\\Users\\Administrator\\Desktop\\c\\R\\foring_ncdf\\CKGS_lati.txt")
data_1<-as.matrix(data_1)

for(o in 1:24472){
  for(p in 1:66){
    for(q in 1:123){
        TMAX_F[p,q,o]<-data_1[p,q]

    }
  }
} 
#��ʽ��ʼ��ֵ
dim(TMAX_F)
dim(TMAX_T)
for(r in 1:24472){
  for(s in 1:66){
    for(t in 1:123){
      if(TMAX_F[s,t,r]!=-9999){
        TMAX_F[s,t,r]=TMAX_T[s,t,r]
      }
    }
  }
} 
dim(TMAX_F)
#�����������ݸ������,���濪ʼ�����������ÿ��ʮ�����һ�Σ��ֱ���
#1951-1960,1961-1970,1971-1980,1981-1990,1991-2000,2001-2010,2011-2017
#��Ӧ�������ֱ���1-3653,3654-7305��7306-10958,10959-14610,14611-18263��
#18264-21915,21916-24472

x<-c(1951:2017)
n1=0
for(i in 1:66){
  if(x[i]%%4==0&&x[i]%%100!=0||x[i]%%400==0){
    n1=n1+1
  }
}
#��n=17������ֱ���1952,1956,1960,1964,1968��1972,
#1976,1980,1984,1988,1992,1996,2000,2004��2008,2012,2016

data_2<-array(,c(66,123))

for(i in 1:24472){
  for(j in 1:66){
	for(k in 1:123){
     		 data_2[j,k]=TMAX_F[j,k,i]
    } 
  }
	if(i>=1&&i<=3653){
	write.table(data_2,file=paste("D:\\data_xijiang\\forcing_fang\\TMAX\\1951-1960\\CKGS",i,".txt",sep="_"),row.names=F,col.names=F,quote=F)
	}
	else if(i>=3654&&i<=7305){
	write.table(data_2,file=paste("D:\\data_xijiang\\forcing_fang\\TMAX\\1961-1970\\CKGS",i,".txt",sep="_"),row.names=F,col.names=F,quote=F)
	}
	else if(i>=7306&&i<=10958){
	write.table(data_2,file=paste("D:\\data_xijiang\\forcing_fang\\TMAX\\1971-1980\\CKGS",i,".txt",sep="_"),row.names=F,col.names=F,quote=F)
	}
	else if(i>=10959&&i<=14610){
	write.table(data_2,file=paste("D:\\data_xijiang\\forcing_fang\\TMAX\\1981-1990\\CKGS",i,".txt",sep="_"),row.names=F,col.names=F,quote=F)
	}
	else if(i>=14611&&i<=18263){
	write.table(data_2,file=paste("D:\\data_xijiang\\forcing_fang\\TMAX\\1991-2000\\CKGS",i,".txt",sep="_"),row.names=F,col.names=F,quote=F)
	}
	else if(i>=18264&&i<=21915){
	write.table(data_2,file=paste("D:\\data_xijiang\\forcing_fang\\TMAX\\2001-2010\\CKGS",i,".txt",sep="_"),row.names=F,col.names=F,quote=F)
	}
	else {
	write.table(data_2,file=paste("D:\\data_xijiang\\forcing_fang\\TMAX\\2011-2017\\CKGS",i,".txt",sep="_"),row.names=F,col.names=F,quote=F)
	}
}
#���Ͼͽ������о�������������ˣ���Ϊ������̫��
#����������1981-1990ʮ�������Ϊ�����д���
Path<-"D:\\data_xijiang\\forcing_fang\\DAY_TMAX\\1951-1960"

Filenames<-dir(Path)

FilePath<-paste(Path,Filenames,sep="\\")

length(FilePath)

if(F){
  V<-read.table(file = FilePath[1])
  V<-as.matrix(V)
  V[is.na(V)]<-0
  a=0
  for(i in 1:66){
    for(j in 1:123){
      if(V[i,j]!=-9999){
        a=a+1
      }
    }
  }
  print(a)
}


grid_TMAX<-array(,c(4661,3653))
a1=1
for(i in 1:3653){
	  V<-read.table(file = FilePath[i])
  	V<-as.matrix(V)
  	V[is.na(V)]<-0
  	#��NA��Ϊ0����ֹ����
	for(j in 1:66){
		for(k in 1:123){
			if(V[j,k]!=-9999){
				grid_TMAX[a1,i]=V[j,k]
				a1=a1+1
			}
		}
	}
	a1=1
}
#���ϴ����������ȥ��-9999��ֵ���������е����ݷŵ�grid_TMAX�Ķ�ά������

for(i in 1:4661){
  for(j in 1:3653){
      
        write.table(grid_TMAX[i,],file=paste("D:\\data_xijiang\\forcing_fang\\GRID_TMAX\\1951-1960\\grid",i,"txt",sep = "_"),row.names=F,col.names=F,quote=F)
      #��������ļ�·���������һ��
    
  }
}
#�������ݴ�������������������Ҫ��Ҳ��һ���ķ�ʽ���д�����ֻҪ�ĸĲ����ͺ���
