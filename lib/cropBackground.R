cropBackground = function(imageData,step,thresholdSize,thresholdPValue) {
  listOut = list(imageData[1:step,],imageData[,(ncol(imageData)-step+1):ncol(imageData)],imageData[(nrow(imageData)-step+1):nrow(imageData),],imageData[,1:step])
  listOut = lapply(listOut,as.vector)
  R = c(6,nrow(imageData)-5)
  C = c(6,ncol(imageData)-5)
  while(min(range(Row),range(Column)) > thresholdSize && max(PValue) > thresholdPValue){
    listIn = list(imageData[R[1]:(R[1]+step-1),],imageData[,(C[2]-step+1):C[2]],imageData[(R[2]-step+1):R[2],],imageData[,C[1]:(C[1]+step-1)])
    listIn = lapply(listIn,as.vector)
    test = mapply(t.test, listOut, listIn)
    PValue = test['p.value',]
  }
}