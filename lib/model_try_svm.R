
library(readr)
library(e1071)
index=sample(1:2000,1600)
data=t(read_csv('../data/training_data/sift_features/sift_features.csv'))
label=read.csv('../data/training_data/labels.csv')
#data=cbind(data,label)
data_train=as.matrix(data)
train_data=data_train[index,]
test_data=data_train[-index,]
train_label=matrix(label[index,])
test_label=matrix(label[-index,])
#fit_svm <- svm(train_data, train_label, kernel = "radial",gamma = 0.1, cost = 25, cross = 5)
#predictions <- predict(fit_svm, test_data, type = "response")
#mean(predictions != test_label)




trainSVM <- function(data, label){

pca <- prcomp(data,scale = FALSE)
pca_x = pca$x[,1:8]
tc <- tune.control(cross = 5)
Cs = c(.001,.01,.1,.5,1)
gammas = 10^(-2:2)
degres = c(0,1)
coef = c(0,1)
cv_svmTune <- tune.svm(data, y =label, cost = Cs, gamma = gammas,degree = degres,coef0 = coef,
                       tunecontrol = tc)
p = cv_svmTune$best.parameters
best.svm = svm(data,label,cost = p[,4], gamma = p[,2],degree = p[,1],coef0 = p[,3])
return(best.svm)
}




model = trainSVM(data = train_data, label = train_label)

testSVM <- function(data){
        pca <- prcomp(data, scale = FALSE)
        pca_x = pca$x[,1:8]
        pred_test <- predict(model,data)
        #for (i in 1:length(pred_test)){
         #       pred_test[i] <- ifelse(pred_test[i] > 0.5,1,0)
        #}
        return(pred_test)
}
result <- testSVM(test_data)











pca <- prcomp(train_data,scale = FALSE)
head(pca$x)
plot(pca,type="lines")
pca_x = pca$x[,1:8]
head(pca_x)

tc <- tune.control(cross = 5)
Cs = c(.001,.01,.1,.5,1,10)
gammas = 10^(-3:2)
degres = c(0,1,2)
coef = c(0,1,2)
cv_svmTune <- tune.svm(pca_x, y =train_label, cost = Cs, gamma = gammas,degree = degres,coef0 = coef,
                       tunecontrol = tc)
summary(cv_svmTune)
p = cv_svmTune$best.parameters
best.svm = svm(pca_x,y=train_label,cost = p[,4], gamma = p[,2],degree = p[,1],coef0 = p[,3],type = "C-classification")

pca_test <- prcomp(test_data, scale = FALSE)
pca_x_test = pca_test$x[,1:8]
pred_svm <- predict(best.svm,pca_x_test)
mean(pred_svm != test_label)

# 0.39