library(readr)
setwd('C:/Users/YSHAN/Documents/ads/pj3')
data=read_csv('sift_features.csv')
library(xgboost)
label=read.csv('labels.csv')
param=list(
  colsample_bytree=1/200,
  objective='binary:logistic',
  max.depth=6,
  sub_sample=0.9,
  eval_metric='error',
  eta=0.1
)

dtrain=xgb.DMatrix(data=data.matrix(t(data)),label=label[,1])
a=xgb.cv(data=dtrain,params = param,nfold=5,nrounds=3000)
#D:\Program Files\Java\jdk1.8.0_121\
model=xgb.train(data=dtrain,params = param,nrounds=3000)



library(h2o)
library(data.table)
library(Metrics)
h2o.init(nthreads=-1)
library(devtools)
install_github("h2oai/h2o-3/h2o-r/ensemble/h2oEnsemble-package")

