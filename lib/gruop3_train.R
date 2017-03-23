
library(readr)
#setwd('C:/Users/YSHAN/Documents/ads/pj3')
data=read_csv('../data/training_data/sift_features/sift_features.csv')
data2=read.csv('../data/training_data/feature.csv', header = F)
library(xgboost)
label=read.csv('../data/training_data/labels.csv')


train <- function(feature, label){

param.base=list(
                colsample_bytree=1/5000,
                objective='binary:logistic',
                max.depth=1,
                eval_metric='error'
        )
        
param.adv=list(
        colsample_bytree=1/600,
        objective='binary:logistic',
        max.depth=6,
        sub_sample=0.9,
        eval_metric='error',
        eta=0.1
)

dtrain.base=xgb.DMatrix(data=data.matrix(t(feature)),label=label[,1])

dtrain.adv=xgb.DMatrix(data=data.matrix(feature),label=label[,1])
#a=xgb.cv(data=dtrain,params = param,nfold=5,nrounds=3000)
#D:\Program Files\Java\jdk1.8.0_121\
model.base=xgb.train(data=dtrain.base,params = param.base,nfold=5,nrounds=3000)
model.adv=xgb.train(data=dtrain.adv,params = param.adv,nfold=5,nrounds=3000)

return(list(baseline=model.base,adv=model.adv))

}