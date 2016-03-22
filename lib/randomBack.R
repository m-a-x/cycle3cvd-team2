randomBack = function(name, picDir){
  pic = paste(picDir,name,sep = "/")
  img = pic %>%
    readImage() %>%
    channel(mode = 'gray') %>%
    imageData()
  print("?")
  if(min(dim(img))>=100){
    k = sample(1:(min(dim(img))-100),1)
    print(k)
    return(img[k:(k+100),k:(k+100)])
  }
}