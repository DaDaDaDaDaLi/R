
m1=rep(0,12)
data<-read.table("D:\\data_xijiang\\F_F_1982\\rout\\1982_real_runoff.txt")
n1 = nrow(data)
n2 = 1
ave_data <- 0
for(i in 1:n1){
  ave_data <- ave_data + data[i,1]
}
ave_data <- ave_data / 365
ave_data_2 <- 0
data_2 <- read.table("D:\\data_xijiang\\F_F_1988\\rout\\result_GY\\GY   .day")[,4]
class(data_2)
for(i in 1:n1){
  ave_data_2 <- ave_data_2 + data_2[i]
}
ave_data_2 <- ave_data_2 / 366
Er <- (ave_data_2 - ave_data) / ave_data
#1
for(i in 1:n1){
  if(i >= 1 && i <= 31){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 31){
      m1[n2] = m1[n2] / 31
      n2 = n2 + 1
    }
  }
  #2
  else if(i >= 32 && i <= 60){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 60){
      m1[n2] = m1[n2] / 29
      n2 = n2 + 1
    }
  }
  #3
  else if(i >= 61 && i <= 91){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 91){
      m1[n2] = m1[n2] / 31
      n2 = n2 + 1
    }
  }
  #4
  else if(i >= 92 && i <= 121){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 121){
      m1[n2] = m1[n2] / 30
      n2 = n2 + 1
    }
  }
  #5
  else if(i >= 122 && i <= 152){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 152){
      m1[n2] = m1[n2] / 31
      n2 = n2 + 1
    }
  }
  #6
  else if(i >= 153 && i <= 182){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 182){
      m1[n2] = m1[n2] / 30
      n2 = n2 + 1
    }
  }
  #7
  else if(i >= 183 && i <= 213){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 213){
      m1[n2] = m1[n2] / 31
      n2 = n2 + 1
    }
  }
  
#8
  else if(i >= 214 && i <= 244){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 244){
      m1[n2] = m1[n2] / 31
      n2 = n2 + 1
    }
  }
  #9
  else if(i >= 245 && i <= 274){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 274){
      m1[n2] = m1[n2] / 30
      n2 = n2 + 1
    }
  }
  #10
  else if(i >= 275 && i <= 305){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 305){
      m1[n2] = m1[n2] / 31
      n2 = n2 + 1
    }
  }
  #11
  else if(i >= 306 && i <= 335){
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 335){
      m1[n2] = m1[n2] / 30
      n2 = n2 + 1
    }
  }
  #12
  else{
    m1[n2] = m1[n2] + data[i,1]
    if(i >= 366){
      m1[n2] = m1[n2] / 31
      n2 = n2 + 1
    }
  }
}

#下面是求月Ef
b = 0
c = 0
data_2_M <- read.table("D:\\data_xijiang\\F_F_1988\\rout\\result_GY\\GY   .month")[,3]
for(i in 1:12){
  b = b + (data_2_M[i] - m1[i]) ^ 2
  c = c + (m1[i] - ave_data) ^ 2
}
Ef_M <- 1 - b/c
#得最终值
if(F){
  data_S_1 <- read.table("D:\\data_xijiang\\F_F_1988\\rout\\1988real_runoff.txt")
  data_S_2 <- data_2 <- read.table("D:\\data_xijiang\\F_F_1988\\rout\\result_GY\\GY   .day")[,4]
}

plot(c(0:12),c(0:12),type = "n",xlab = "月份",ylab = "径流量(m^3/s)",xlim = c(1,12),ylim = c(0,20000),lab = c(12,4,10))
month_R <- c(1:12)
lines(month_R,m1,lty =1 , lwd = 3)
data_Month_M <- read.table("D:\\data_xijiang\\F_F_1988\\rout\\result_GY\\GY   .month")[,3]
lines(month_R,data_Month_M,lty=2,lwd = 3)
legend(1,15000,legend = c("实测径流","模拟径流"),col = c("black","black"),lty = c(1,2),lwd = 3)
