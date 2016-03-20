readInHead = function(name, picDir){
  pic = paste(picDir,name,sep = "/")
  img = pic %>%
    readImage() %>%
    imageData()
  print(dim(img))
  return(img)
}