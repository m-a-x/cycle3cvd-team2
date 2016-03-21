scorePatchList = function(pic,patchList){
  return(sapply(patchList, scorePatch, pic = pic))
}