getFace = function(name,xmlDir,picDir){
  xml = paste(paste(xmlDir,name,sep = "/"), "xml", sep = ".")
  pic = paste(paste(picDir,name,sep = "/"), "jpg", sep = ".")
  ann = xmlParse(xml)
  head_box = xmlToDataFrame(ann, nodes=getNodeSet(ann,"//annotation/object/bndbox"))
  img = readImage(pic)
  head = img[head_box['xmin']:head_box['xmax'],head_box['ymin'],head_box['ymax']]
}