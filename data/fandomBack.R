randomBack = function(name, picDir){
  pic = paste(picDir,name,sep = "/")
  img = pic %>%
    readImage() %>%
    channel(mode = 'gray') %>%
    imageData()
  if(min(dim(img))>=100){
    return(img[1:100,1:100])
  }
}