cropBoundary = function(imageData,step,thresholdSize,thresholdC) {
  Out = imageData[1:step,]
  Out = apply(Out,2,mean)
  Ind = 1+step
  In = imageData[Ind:(Ind+step-1),]
  In = apply(In, 2, mean)
  C = lm(Out~In)$coefficients[2]
  while(Ind < thresholdSize && C > thresholdC){
    #print("p")
    Ind = Ind + step
    Out = In
    In = imageData[Ind:(Ind+step-1),]
    In = apply(In, 2, mean)
    C = lm(Out~In)$coefficients[2]
  }
  print(C)
  print(Ind)
  return(imageData[-(1:Ind),])
}