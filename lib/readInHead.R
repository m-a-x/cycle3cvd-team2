readInHead = function(name, picDir){
  pic = paste(picDir,name,sep = "/")
  img = readImage(pic)
  return(img)
}