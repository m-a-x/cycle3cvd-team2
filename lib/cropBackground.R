cropBackground = function(imageData,step,thresholdSize,thresholdPValue) {
  listOut = list(imageData[1:step,],imageData[(nrow(imageData)-step+1):nrow(imageData),],imageData[,1:step],imageData[,(ncol(imageData)-step+1):ncol(imageData)])
  listOut = lapply(listOut,as.vector)
  Ind = c(1+step, nrow(imageData)-step, 1+step, ncol(imageData)-step)
  listIn = list(imageData[Ind[1]:(Ind[1]+step-1),],imageData[(Ind[2]-step+1):Ind[2],],imageData[,Ind[3]:(Ind[3]+step-1)],imageData[,(Ind[4]-step+1):Ind[4]])
  listIn = lapply(listIn,as.vector)
  test = mapply(t.test, listOut, listIn,paired = TRUE)
  PValue = do.call(c,test['p.value',])
  while(Ind[2]-Ind[1] > thresholdSize && Ind[4]-Ind[3] > thresholdSize && max(na.omit(PValue)) > thresholdPValue){
    print("p")
    update = which.max(PValue)
    Ind[update] = Ind[update]-(-1)^update*step
    if(update == 1){
      listOut[[1]] = listIn[[1]]
      listIn[[1]] = imageData[Ind[1]:(Ind[1]+step-1),]
    }else(update == 2){
      listOut[[2]] = listIn[[2]]
      listIn[[2]] = imageData[(Ind[2]-step+1):Ind[2],]
    }else(update == 3){
      listOut[[3]] = listIn[[3]]
      listIn[[3]] = imageData[,Ind[3]:(Ind[3]+step-1)]
    }else(update == 4){
      listOut[[4]] = listIn[[4]]
      listIn[[4]] = imageData[,(Ind[4]-step+1):Ind[4]]
    }
    test = t.test(lisOut[[update]],listIn[[update]],paired = TRUE)
    PValue[update] = test.PValue
    print(test)
    print(PValue)
  }
  return(imageData[Ind[1]:Ind[2],Ind[3]:Ind[4]])
}