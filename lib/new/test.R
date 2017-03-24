
test <- function(model, feature){
  pred <- predict(model, feature, type='response')
  pred <- as.numeric(pred > 0.5)
  return(pred)
}
