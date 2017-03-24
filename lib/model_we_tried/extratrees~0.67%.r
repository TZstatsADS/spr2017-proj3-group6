setwd('C:/Users/YSHAN/Documents/ads/pj3')
library(snowfall)
library(readr)
index=sample(1:2000,1500)
data=t(read_csv('sift_features.csv'))
label=read.csv('labels.csv')
all=cbind(data,label)
do_et=function()
{
  et=extraTrees::extraTrees(y=factor(label[index,1]),mtry=50,ntree=800,x=data[index,])
  test=data[-index,]
  pdtest=predict(et,test,, probability=T)
  return(pdtest)
}
res=do_et()
sum((as.numeric(res)-1)!=label[-index,1])
