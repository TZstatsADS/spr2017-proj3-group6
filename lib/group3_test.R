
test <- function(model,feature){
        base.model <- models$baseline 
        adv.model <- models$adv
        base.prediction <- predict(base.model,feature)
        adv.prediction <- predict(adv.model,feature)
        return(list(baseline=base.prediction,adv=adv.prediction))
}
