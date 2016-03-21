scorePatch = function(pic,patch){
  mat = patch$mat
  pat = patch$pat
  xmin = mat[1,1]
  ymin = mat[2,1]
  xmax = mat[1,2]
  ymax = mat[2,2]
  score = sum(pic[xmin:xmax,ymin:ymax]*pat)
  return(score)
}