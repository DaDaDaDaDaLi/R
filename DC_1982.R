setwd("D:\\data_xijiang\\F_F_1982\\rout\\result_GY")
m_runoff<-read.table("GY   .day")[4]
m_runoff <- m_runoff
max(m_runoff)

R_m <- c()
n1 = 1
for(i in 1:365){
  R_m[n1] <- m_runoff[i,1]
  n1 = n1+1
}
T<-c(1:365)
length(R_m)
plot(c(0:12),c(0:12),type = "n",xlab = "天数（day）",ylab = "径流量(m^3/s)",xlim = c(1,366),ylim = c(0,30000),lab = c(20,4,10))
lines(T,R_m,lty=2,lwd = 3)
s_runoff<-read.table("D:\\data_xijiang\\F_F_1982\\rout\\1982_real_runoff.txt")[1]
max(s_runoff)
nrow(s_runoff)
length(R_s)
R_s <- c()
n2 = 1
for(i in 1:365){
  R_s[n2] <- s_runoff[i,1]
  n2 = n2+1
}
lines(T,R_s,lty=1,lwd = 3)
legend(260,24000,legend = c("实测径流","模拟径流"),col = c("black","black"),lty = c(1,2),lwd = 3)


