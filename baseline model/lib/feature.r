feature <- function(img_dir, img_name, data_name=NULL){
        
        ### Construct process features for training/testing images
        ### Sample simple feature: Extract raw pixel values os features
        
        ### Input: a directory that contains images ready for processing
        ### Output: an .RData file contains processed features for the images
        
        ### load libraries
        library("EBImage")
        
        n_files <- length(img_name)
        nR <- 10
        nG <- 8
        nB <- 10
        rBin <- seq(0, 1, length.out=nR)
        gBin <- seq(0, 1, length.out=nG)
        bBin <- seq(0, 1, length.out=nB)
        ### store vectorized pixel values of images
        dat <- array(dim=c(n_files, nR*nG*nB)) 
        for(i in 1:n_files){
                img <- readImage(paste(img_dir, img_name[i],sep=""))
                mat <- imageData(img)
                freq_rgb <- as.data.frame(table(factor(findInterval(mat[,,1], rBin), levels=1:nR), 
                                                factor(findInterval(mat[,,2], gBin), levels=1:nG), 
                                                factor(findInterval(mat[,,3], bBin), levels=1:nB)))
                rgb_feature <- as.numeric(freq_rgb$Freq)/(ncol(mat)*nrow(mat))
                dat[i,] <- as.vector(rgb_feature)
        }
        
        ### output constructed features
        if(!is.null(data_name)){
                save(dat, file=paste0("./output/feature_", data_name, ".RData"))
        }
        return(dat)
}
