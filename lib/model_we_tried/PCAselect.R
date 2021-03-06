#PCA on lbp features
data<-read.csv("feature_lbp.csv",head=FALSE)

PCA<-function(feature_dat){
pca<-prcomp(feature_dat,scale=TRUE)

#find cumulative var over 90%
sum_pca<-summary(pca)
k<-which(sum_pca$importance[3,]>0.9)[1]

sub_feature<-pca$x[,1:k]

#save(sub_feature, file="./spr2017-proj3-group6/output/pca_lbp.RData")

return(sub_feature)
}