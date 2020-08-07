#utf-8
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
#檢定
#每一個命題都有對應的假設→然後運用適合的統計方法進行檢定

#相關係數檢定(用假設檢定 假設相關性成立 超過百分之95%就拒絕)
cor.test(c(1,2,3,4,5), c(1,0,3,4,5), method = "pearson")
#推論檢定 
#透過t.test計算信賴水準為95%的信賴區間 和其平均值 所以可以知道抽取合理性(平均值合理)
x <- rnorm(30) #從平均數為0、變異數為1的常態分布中抽取30個樣本
t.test(x)#平均在區間內 可信賴 基於母體與抽取變異數相等 可推論信賴區間 只要平均數在裡面就代表抽取成功(平均值合理)
x <- rnorm(30, mean=10)#從平均數為10、變異數為1的常態分布中抽取30個樣本
t.test(x, mu=10)
# f 檢定 了解兩資料變異數有沒有一樣(拒絕表示 變異數有顯著差異)
tapply(sleep$extra,sleep$group,mean) #看兩筆數據的某特質
var.test (extra~group, sleep) #extra~group 表示一種group的extra當一種數據
# 程序 先F檢定 發現變異數近似 再做t檢定 就可以理解兩組數據之關聯
#ex: (要因為變異數一樣,才可以使用t檢定)
var.test (extra~group, sleep)
#得到變異數差異不顯著 0.79 要小於 0.05 ,所以進行t test ,var設為相等
t.test(extra~group, data=sleep, paired=FALSE, var.equal=TRUE) #paired 兩組數據獨立?
#p-value 0.079 不夠大 要小於 0.05才可以拒絕 得到兩組數據近似(平均數差異不明顯) 即使平均值差幾倍
#配對樣本檢定 看兩組數據是否相依(成對) 要用with在前面包著 表示成對
#t test檢定
with(sleep,t.test(extra[group == 1],extra[group == 2],paired = TRUE))
#p value < 0.05 表示超過信賴區間 拒絕 --> 完全不相通 --> 平均數差異顯著
#變異數統計(功能像F 檢定 ,要通過變異數相等才可以往下算平均)
with(iris, var.test(Sepal.Width, Sepal.Length))
#p value < 0.05 表示超過信賴區間 拒絕 --> 完全不相通 --> 變異數差異顯著

#回歸分析
data(cars)
head(cars)
#獲得回歸模型
#lm:線性回歸 {依變數~自變數}
m <- lm(dist~speed,data = cars) #m <- lm(dist~speed,cars)也行 
summary(m)#右邊星星越多表示 p value越小 表示越準 
#p value==0.01 就表示只有0.01的可能性會失敗, p value == 0.05 就達到了95%信心標準
#用變異數分析評估模型
anova(m)
#畫圖
plot(m) 
#1.誤差服從平均數為0的常態分布理想狀態：一條斜率為0的直線
#2.查看殘差是否符合常態分布理想狀態：一條斜率為1的直線
#3.x軸為Y值，Y軸為標準化殘差
#4.右上與右下位置查找對迴歸直線形狀影響很大的點
plot(cars$speed,cars$dist)
abline(coef(m))
#coef函數用於提取線性迴歸模型的截距與斜率，abline()函數用於根據給定截距與斜率繪製直線
#多元分析
model <- lm(formula= Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width,data=iris) #(formula = 目標值 ~ 參數1+參數2+參數3+....)
summary(model)# y = 1.85 + 0.65*Sepal.Width + 0.709*Petal.Length - 0.556*Petal.Width
#Residuals 殘差 其下是殘差分布 表示點和線的差異值 越大的區段表示越不准
#R-squared 表示 相關係數的平方 r^2

#殘差基本假設
model$residuals
#常態性假設驗證 --> 隨機分布 p value > 0.05 表示無法拒絕 具有常態性
shapiro.test(resid(model))
#獨立性假設驗證 --> 殘差彼此無關
library(car)
durbinWatsonTest(model)
#變異數同質性假設 --> 殘差屬於常態分布
ncvTest(model) #在此項 < 0.05 表示被拒絕 此模型不具有"變異數同質性"
#試用該公式
new.iris <- data.frame(Sepal.Width=3.456, Petal.Length=1.535, Petal.Width=0.341)
new.iris
predict(model, new.iris)#得到答案 = 5.004048

#變異數分析 #對品種不同的寬度進行變異數分析 
#發現:pValue<0.5-->拒絕-->表示不同品種平均數有大差異 變異數分析的基本假設(各類別平均相等)
a.lm <- lm(Petal.Width~Species,data = iris)
anova(a.lm)


load("C:/titanic.raw.rdata") 
str(titanic.raw)
library(arules)
rule <- apriori(titanic.raw,parameter=list(minlen=3,supp=0.1,conf=0.7),appearance = list(default="lhs",rhs=c("Survived=No","Survived=Yes")))
inspect(rule)
sort.rule <- sort(rule,by="lift")
inspect(sort.rule)
plot(sort.rule,method="graph")
plot(sort.rule,method = "grouped")
