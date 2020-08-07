#基本使用
#看類別
b <- TRUE
class(2^2) 
class(2L)
class(TRUE)
class("Learning R the easy way")
class(Sys.Date())
class(Sys.time())
str(b)
is.integer(b)
#常用操作
string <- "Leon Lin"
Cstring <- c("a","bbb","ccccc")
m <- c(2,3,4) #設定向量
n = c(2,3,4) # = vs <-  =只能用於命令的最外層，而<-則可以用在任何地方。因此，若想在調用函數的同時為變數值分配，只能使用<-運算子。
#用 <- 為主
m*n
m+n
sqrt(100) #開根號
#類別變數 看有幾類
gender <- c("a","b","b","c","c","c")
gender <- factor(gender)
gender
#matrix
matr <- matrix(c(1:6),nrow = 3,ncol = 2)
#dataframe 
#引入外部CSV 右上角 環境區 import Dataset
#自建
tmp <- data.frame(id=c(1:5),name=c(6:10),score=c(11:15))
#dataframe操作
tmp[1,2] #列,欄
tmp[1, ] # 第一列
tmp[, 3] # 第三欄
tmp$name #查看某欄
tmp[tmp$name == "7", ] #remember ','
#常見統計
mean(iris$Sepal.Length) #「花萼長度」的平均值
var(iris$Sepal.Length) #「花萼長度」的變異數
sd(iris$Sepal.Length) #「花萼長度」的標準差
median(iris$Sepal.Length) #「花萼長度」的中位數
max(iris$Sepal.Length) #「花萼長度」中的最大值
min(iris$Sepal.Length) #「花萼長度」中的最小值
sum(iris$Sepal.Length) #「花萼長度」加總
range(iris$Sepal.Length) #「花萼長度」最小值和最大值(全距)
quantile(iris$Sepal.Length, probs=0.25) # 第一四分位數
quantile(iris$Sepal.Length, probs=0.75) # 第一四分位數
#生成函數
rnorm(100,0,10) #標準分布
plot(density(rnorm(100,0,10)))
#二項分布
plot(0:100,dbinom(0:100,size = 100,prob = 0.5),type = "l",ylab = "probability")
#樣本抽取
sample (1: 10, 5) #取後不放回
sample (1: 10, 5, replace=TRUE) #取後放回
sample (1: 10, 5, replace=TRUE, prob=1:10) #取後放回加權重 1有1 2有2 3有3
#查看資料集設定
?cars
?iris
library(ggplot2)
#ggplot的邏輯是用疊的
ggplot(cars, aes(x=speed, y=dist)) #引入資料與畫表格底
ggplot(cars, aes(x=speed, y=dist)) +geom_point() #表現形式為點點圖
#盒鬚圖 後方參數皆為輸入資料集中的資料
ggplot(data=CO2) + geom_boxplot(data=CO2, aes(x=conc, y=uptake, colour=Plant))
ggplot(CO2, aes(x=conc, y=uptake, colour=Plant)) +geom_boxplot()
# 以上兩種作法皆可 ggplot(資料來源,aes(x = 一種數值資料,y = 一種數值資料,colour=類別資料))
#用boxplot 畫盒鬚圖 差異是 這是以x軸分類 所以少一個參數
boxplot(cars$speed ~ cars$dist)

#相關分析
#𝑐𝑜𝑣(𝑋, 𝑌)=𝐸[(𝑋−𝐸(𝑋))(𝑌−𝐸(𝑌))] 相關係數
#𝑉𝑎𝑟(𝑋)=[(〖𝑋−𝐸(𝑋))〗^2] 變異數
cov (1:5, 2:6)
cor(iris$Sepal.Width, iris$Sepal.Length)
cor(iris[, 1:4])
#相關性視覺畫
install.packages("corrgram")
library(corrgram)
corrgram(iris, upper.panel=panel.conf) #參數為右上角是甚麼
#分析範例
x<-1:10
y<-x^3
cor(x, y)
#相關係數檢定(用假設檢定 超過百分之95%就拒絕)
cor.test(c(1,2,3,4,5), c(1,0,3,4,5), method = "pearson")
#推論檢定 
#透過t.test計算信賴水準為95%的信賴區間 和其平均值 所以可以知道抽取合理性
x <- rnorm(30) #從平均數為0、變異數為1的常態分布中抽取30個樣本
t.test(x)#平均在區間內 可信賴 基於母體與抽取變異數相等 可推論信賴區間 只要平均數在裡面就代表抽取成功
x <- rnorm(30, mean=10)#從平均數為10、變異數為1的常態分布中抽取30個樣本
t.test(x, mu=10)
# f 檢定 了解兩資料變異數有沒有一樣
tapply(sleep$extra,sleep$group,mean) #看兩筆數據的某特質
var.test (extra~group, sleep) #extra~group 表示一種group的extra當一種數據
# 程序 先F檢定 發現變異數近似 再做t檢定 就可以理解兩組數據之關聯
#ex: (要因為變異數一樣,才可以使用t檢定)
var.test (extra~group, sleep)
#得到變異數差異不顯著 0.79 要小於 0.05 ,所以進行t test var設為相等
t.test(extra~group, data=sleep, paired=FALSE, var.equal=TRUE) #paired 兩組數據獨立?
#p-value 0.079 不夠大 要小於 0.05才可以拒絕 得到兩組數據近似 即使平均值差幾倍