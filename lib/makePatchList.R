makePatchList = function(Patchs,scores,patchUsed){
  l = vector("list",length(patchUsed))
  for (i in 1:length(patchUsed)){
    k = patchUsed[i]
    patch = Patchs[[k]]
    limit = quantile(scores[101:200,k],0.1)
    l[[i]] = list(patch[[1]],patch[[2]],limit)
  }
return(l)   
}