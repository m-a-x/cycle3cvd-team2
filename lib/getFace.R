getFace = function(name,xmlDir,picDir){
  print(name)
  xml = paste(paste(xmlDir,name,sep = "/"), "xml", sep = ".")
  pic = paste(paste(picDir,name,sep = "/"), "jpg", sep = ".")
  ann <- xmlParse(xml)
  head_box <- xmlToDataFrame(ann, nodes=getNodeSet(ann,"//annotation/object/bndbox"))
  head_box = head_box %>%
    lapply(toNumeric) %>%
    unlist()
  img = pic %>%
    readImage() %>%
    channel(mode = 'gray') %>%
    imageData()
  #print(dim(img))
  #print(head_box)
  head = img[head_box[1]:head_box[3], head_box[2]:head_box[4]]
}

toNumeric = function(f){as.numeric(levels(f))[f]}