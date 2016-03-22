findFace = function(picL,patchScoreList,saveDir){
  size = c(60,80,100,120,140,180,220,260)
  pic = picL[[1]]
  name = picL[[2]]
  r = nrow(pic)
  c = ncol(pic)
  size = size[size<=min(dim(pic))]
  for(i in 1:length(size)){
    n = size[i]
    print(n)
    for(j in 1:floor((r-n)/5)){
      for(k in 1:floor((c-n)/5)){
        grid = pic[(j*5-4):(j*5+n-4),(k*5-4):(k*5+n-4)]
        luck = testFace(grid,patchScoreList)
        if(luck){
          writeImage(grid, "../../luck.jpg")
          return
        }
      }
    }
  }
}