scorePatch = function(pic,patch){
  mat = patch[[2]]
  pat = patch[[1]]
  #print(mat)
  #print(dim(pic))
  xmin = mat[1,1]
  ymin = mat[2,1]
  xmax = mat[1,2]
  ymax = mat[2,2]
#   pat = patch
#   xmin = 0
#   ymin = 0
#   xmax = 30
#   ymax = 30
  score = sum(pic[xmin:xmax,ymin:ymax]*pat)
  return(score)
}