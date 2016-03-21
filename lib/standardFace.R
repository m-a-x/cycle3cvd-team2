standardFace = function(fileNames,picDir){
  faces = fileNames %>%
    lapply(FUN = readInHead, picDir = picDir)%>%
    lapply(FUN = rescale, size = 60, ratio = 0.9)
  faces = faces[!(sapply(faces,is.null))]
  return(faces)
}