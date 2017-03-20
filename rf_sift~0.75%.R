setwd('C:/Users/YSHAN/Documents/ads/pj3')
library(snowfall)
library(readr)
index=sample(1:2000,1500)
data=t(read_csv('sift_features.csv'))
label=read.csv('labels.csv')
all=cbind(data,label)
do_random_forrest=function()
{
rf=randomForest::randomForest(y=factor(label[index,1]),mtry=80,ntrees=375,x=data[index,])
test=data[-index,]
pdtest=predict(rf,test,type='prob')
return(pdtest)
}
Sys.time()
Sys.time()
clus <- makeCluster(8)
clusterExport(clus,"do_random_forrest")
clusterExport(clus,"index")
clusterExport(clus,"label")
clusterExport(clus,"data")
result=clusterCall(clus, do_random_forrest)
stopCluster(clus)
sum(round(Reduce('+',result)/8)[,2]!=label[-index,1])
Sys.time()

train_rfs=function(data)
{
  modellist=function()
  {
    rf=randomForest::randomForest(y=factor(label[,1]),mtry=80,ntrees=375,x=data)
    return(rf)
  } 
  clus <- makeCluster(8)
  clusterExport(clus,"modellist")
  clusterExport(clus,"index")
  clusterExport(clus,"label")
  clusterExport(clus,"data")
  result=clusterCall(clus, modellist)
  stopCluster(clus)
  t=do.call(predict,c(result,data,type='prob'))
  
  
}
#5min


