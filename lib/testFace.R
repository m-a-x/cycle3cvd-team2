testFace = function(grid,patchScoreList){
  score = 0
  grid = grid %>%
    resize(w=100, h=100)%>%
    imageData()
  for(i in 1:length(patchScoreList)){
    p = patchScoreList[[i]]
    sScore = scorePatch(grid,p)
    if(sScore>p[[3]]){
      score = score+1
    }
    if(score>1){
      return(FALSE)
    }
  }
  return(TRUE)
}