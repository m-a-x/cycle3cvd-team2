standardFace = function(fileNames,picDir,discard){
  faces = fileNames %>%
    lapply(FUN = readInHead, picDir = picDir)
  if(discard){
    faces = lapply(faces, FUN = rescale, size = 60, ratio = 0.85)
  }else{
    faces = lapply(faces, FUN = rescale, size = 0, ratio = 0)
  }
  faces = faces[!(sapply(faces,is.null))]
  return(faces)
}