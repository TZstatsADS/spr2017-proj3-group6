library(readr)
setwd('C:/Users/YSHAN/Documents/ads/pj3')
data=read_csv('sift_features.csv')
library(xgboost)
label=read.csv('labels.csv')
param=list(
  colsample_bytree=1/5000,
  objective='binary:logistic',
  max.depth=1,
  eval_metric='error'
)
dtrain=xgb.DMatrix(data=data.matrix(t(data)),label=label[,1])
a=xgb.cv(data=dtrain,params = param,nfold=5,nrounds=round(5000/0.632))
#D:\Program Files\Java\jdk1.8.0_121\
model=xgb.train(data=dtrain,params = param,nfold=5,nrounds=round(5000/0.632))


