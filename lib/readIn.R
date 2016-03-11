readIn = function(name, picDir) {
  pic = paste(paste(picDir,name,sep = "/"), "jpg", sep = ".")
  img = pic %>%
    readImage() %>%
    channel(mode = 'gray') %>%
    imageData()
  return(list(img,name))
}