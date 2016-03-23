cropBoundary = function(imageData,step,thresholdSize,thresholdC) {
  Out = imageData[1:step,]
  Out = apply(Out,2,mean)
  Ind = 1+step
  In = imageData[Ind:(Ind+step-1),]
  In = apply(In, 2, mean)
  C = lm(Out~In)$coefficients[2]
  while(Ind < thresholdSize && (C > thresholdC || is.na(C))){
    Ind = Ind + step
    Out = In
    In = imageData[Ind:(Ind+step-1),]
    In = apply(In, 2, mean)
#     v = quantile((Out - In),c(0.1, 0.9))
#     C = abs(v[2]-v[1])/sd(Out - In)
    C = lm(Out~In)$coefficients[2]
#     print(lm(Out~In))
#     print(C)
  }
  C = 1
  if(Ind < 5){
    while(Ind < thresholdSize && C < 2.5){
      Ind = Ind + step
      Out = In
      In = imageData[Ind:(Ind+step-1),]
      In = apply(In, 2, mean)
      v = quantile((Out - In),c(0.1, 0.9))
      C = abs(v[2]-v[1])/sd(Out - In)
    }
  }
  return(Ind)
}