abstractPatch = function(pic,xmin,ymin,xmax,ymax){
  pat = pic[xmin:xmax,ymin:ymax]
  pat = ifelse(play>median(play),-1,1)
  mat = matrix(c(xmin,ymin,xmax,ymax),2,2)
  return(list(pat,mat))
}