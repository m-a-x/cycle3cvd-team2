readIn = function(name, picDir) {
  pic = paste(picDir,name,sep = "/")
  img = pic %>%
    readImage() %>%
    channel(mode = 'gray') 
  return(list(img,name))
}