
train <- function(feature, label, par, feature.use){
  if (feature.use == 'sift'){
    set.depth = ifelse(is.na(par$depth), 6, par$depth)
    param.base=list(
          colsample_bytree=1/30,
          objective='binary:logistic',
          max.depth=set.depth,
          eval_metric='error'
    )
    dtrain.base=xgb.DMatrix(data=data.matrix(feature),label=label)
    model=xgb.train(data=dtrain.base,params = param.base,nfold=5,nrounds=500)
  }
  else if(feature.use == 'lbp'){
    param.adv=list(
      colsample_bytree=1/600,
      objective='binary:logistic',
      max.depth=6,
      sub_sample=0.9,
      eval_metric='error',
      eta=0.1
    )
    dtrain.adv=xgb.DMatrix(data=data.matrix(feature),label=label)
    model=xgb.train(data=dtrain.adv,params = param.adv,nfold=5,nrounds=3000)
  }
  return (model)
}
