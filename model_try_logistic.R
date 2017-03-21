install.packages("sgd")
library(sgd)
library(readr)
index=sample(1:2000,1600)
data=t(read_csv('../data/training_data/sift_features/sift_features.csv'))
label=read.csv('../data/training_data/labels.csv')
#data=cbind(data,label)
data_train=as.matrix(data)
train_data=data_train[index,]
test_data=data_train[-index,]
train_label=matrix(label[index,])
test_label=matrix(label[-index,])

sgd_fit<- sgd(train_data, train_label,model='glm',model.control=binomial(link="logit"))
pred <- predict(sgd_fit, test_data,type = 'response')  
pred <- ifelse(pred >= 0.5, 1, 0)
cv.error <- mean(pred != test_label)
cv.error

sgd.train <- function(dat_train, label_train){
        
        ### load libraries
        library("sgd")
        sgd_fit<- sgd(dat_train,label_train,model='glm',model.control=binomial(link="logit"))
        
        return(sgd_fit)
}

