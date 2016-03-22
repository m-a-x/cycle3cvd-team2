# install library
library("dplyr")
library("EBImage")
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

# get the label
dir_names <- list.files(dir_images)
breed_name <- rep(NA, length(dir_names))
for(i in 1:length(dir_names)){
        tt <- unlist(strsplit(dir_names[i], "_"))
        tt <- tt[-length(tt)]
        breed_name[i] = paste(tt, collapse="_", sep="")
}
cat_breed <- c("Abyssinian", "Bengal", "Birman", "Bombay", "British_Shorthair", "Egyptian_Mau",
               "Maine_Coon", "Persian", "Ragdoll", "Russian_Blue", "Siamese", "Sphynx")

iscat <- breed_name %in% cat_breed
y_cat <- as.numeric(iscat)

# create a training set and test set 
set.seed(666)
index = sample(7390,1390)
label_train = y_cat[-index]
label_test = y_cat[index]

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
train_feature = feature(image_test_lib,test_index,"test")
