meanFace = function(faceList,n){
  faceS = sample(faceList,n) 
  faceS = Reduce('+',faceS)/n
  print(max(faceS),min(faceS),range(faceS))
  #faceS = faceS - min(faceS)
  return(faceS)
}