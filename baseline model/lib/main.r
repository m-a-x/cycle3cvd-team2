# install library
library("dplyr")
library("EBImage")
library("e1071")
# specify library 
setwd("~/Desktop/ADS_Projetct3")

# extract class label
dir_images <- "./data/images"
dir_names <- list.files(dir_images)

## delete all the data like .mat
for(i in 1:length(dir_names)){
        tt <- unlist(strsplit(dir_names[i], "_"))
        if (unlist(strsplit(tt[length(tt)],"[.]"))[2] == "mat"){
                
                file.remove(paste("./data/images","/",dir_names[i],sep = ""))
                #tt <- tt[-length(tt)]
                #breed_name[i] = paste(tt, collapse="_", sep="")
        }
}



# create a training set and test set 
set.seed(666)
index = sample(7377,1377)

current_folder = "/Users/Arsenal4ever/Desktop/ADS_Projetct3/data/images"
train.folder = "/Users/Arsenal4ever/Desktop/ADS_Projetct3/data/data_train"
test.folder = "/Users/Arsenal4ever/Desktop/ADS_Projetct3/data/data_test"

train_index = dir_names[-index]
test_index = dir_names[index]

# create training folder
for (i in 1:length(train_index)){
        train_list = paste(current_folder,"/",train_index[i],sep = "")
        file.copy(from=train_list, to=train.folder)
}
# create test folder
for (i in 1:length(test_index)){
        test_list = paste(current_folder,"/",test_index[i],sep = "")
        file.copy(from=test_list, to=test.folder)
}

# create lib for training and testing 
image_train_lib = "./data/data_train/"
image_test_lib = "./data/data_test/"
          
# construct feature 
source("./lib/feature.r")
train_feature = feature(image_train_lib,train_index,"train")
test_feature = feature(image_test_lib,test_index,"test")

# get the label
# train label
breed_name_train <- rep(NA, length(train_index))
for(i in 1:length(train_index)){
        tt <- unlist(strsplit(train_index[i], "_"))
        tt <- tt[-length(tt)]
        breed_name_train[i] = paste(tt, collapse="_", sep="")
}
cat_breed <- c("Abyssinian", "Bengal", "Birman", "Bombay", "British_Shorthair", "Egyptian_Mau",
               "Maine_Coon", "Persian", "Ragdoll", "Russian_Blue", "Siamese", "Sphynx")

iscat <- breed_name_train %in% cat_breed
label_train <- as.numeric(iscat)
save(label_train, file=paste0("./output/", "label_train", ".RData"))

# test label
breed_name_test <- rep(NA, length(test_index))
for(i in 1:length(test_index)){
        tt <- unlist(strsplit(test_index[i], "_"))
        tt <- tt[-length(tt)]
        breed_name_test[i] = paste(tt, collapse="_", sep="")
}

iscat <- breed_name_test %in% cat_breed
label_test <- as.numeric(iscat)
save(label_test, file=paste0("./output/", "label_test", ".RData"))

# result
svm_RBF = svm(train_feature,label_train,type = "C-classification",kernel = "radial",cost = 0.27,gamma = 0.001)
predict = predict(svm_RBF,test_feature)
error = sum(predict != label_test)/1377