rescale = function(head,size,ratio){
  c = ncol(head)
  r = nrow(head)
  if(min(dim(head))>size && c/r >= ratio && r/c >= ratio){
    img = head %>%
      resize(w=100, h=100)%>%
      imageData()
    img = (img - mean(img))
    return(img)
  }
}