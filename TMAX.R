library(ncdf4)
setwd("D:\\data_xijiang\\forcing_fang\\forcing_XJ")
temp_1<-nc_open("CN_MaxTemperature_daily_1951-2017_XJ.nc")
#打开nc文件

temp_lati<-ncvar_get(temp_1,"Latitude")
temp_long<-ncvar_get(temp_1,"Longitude")
#本段代码需要在R_GUI上运行
temp_time<-ncvar_get(temp_1,"time")
temp_TMAX<-ncvar_get(temp_1,"MaxTemperature")
#以上都是读取相应数据


TMAX<-array(,c(72,156,24472))

for(i in 1:24472){
    for(j in 1:156){
      for(k in 1:72){

        TMAX[k,j,i]<-temp_TMAX[j,k,i]

      }
    }
} 
dim(TMAX)
#将数组进行转置
#经过计算纬度从第6行及后面的65行
#经度从第4列及后面的122列
TMAX_T<-array(,c(66,123,24472))
#存放标准格式的TMAX数据
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
#复制数据格式
TMAX_F<-array(,c(66,123,24472))
#存放最终TMAX数据
data_1<-read.table("C:\\Users\\Administrator\\Desktop\\c\\R\\foring_ncdf\\CKGS_lati.txt")
data_1<-as.matrix(data_1)

for(o in 1:24472){
  for(p in 1:66){
    for(q in 1:123){
        TMAX_F[p,q,o]<-data_1[p,q]

    }
  }
} 
#正式开始赋值
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
#至此整个数据复制完毕,下面开始制作输出数据每隔十年输出一次，分别是
#1951-1960,1961-1970,1971-1980,1981-1990,1991-2000,2001-2010,2011-2017
#对应的天数分别是1-3653,3654-7305，7306-10958,10959-14610,14611-18263，
#18264-21915,21916-24472

x<-c(1951:2017)
n1=0
for(i in 1:66){
  if(x[i]%%4==0&&x[i]%%100!=0||x[i]%%400==0){
    n1=n1+1
  }
}
#共n=17个闰年分别是1952,1956,1960,1964,1968，1972,
#1976,1980,1984,1988,1992,1996,2000,2004，2008,2012,2016

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
#以上就将矩形研究区的数据输出了，因为数据量太大，
#这里数据以1981-1990十年的数据为例进行处理
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
  	#将NA置为0，防止报错
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
#以上代码的作用是去除-9999的值，并将所有的数据放到grid_TMAX的二维数组中

for(i in 1:4661){
  for(j in 1:3653){
      
        write.table(grid_TMAX[i,],file=paste("D:\\data_xijiang\\forcing_fang\\GRID_TMAX\\1951-1960\\grid",i,"txt",sep = "_"),row.names=F,col.names=F,quote=F)
      #输入输出文件路径尽量搞短一点
    
  }
}
#以上数据处理过程其他三个气象要素也是一样的方式进行处理，只要改改参数就好了

