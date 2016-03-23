
feature2 <- function(img_dir, img_name, data_name=NULL){
        
        library("EBImage")
        n_files = length(img_name)
        N <- 3 # number of bins in x-axis
        M <- 5 # number of bins in y-axis
        p_x <- p_y <- 250
        
        nR <- 10
        nG <- 8
        nB <- 10
        xbin <- floor(seq(0, p_x, length.out= N+1))
        ybin <- seq(0, p_y, length.out=M+1)
        rBin <- seq(0, 1, length.out=nR)
        gBin <- seq(0, 1, length.out=nG)
        bBin <- seq(0, 1, length.out=nB)
        dat <- array(dim=c(n_files, nR*nG*nB*M*N))

        construct_rgb_feature <- function(X){
                freq_rgb <- as.data.frame(table(factor(findInterval(X[,,1], rBin), levels=1:nR), 
                factor(findInterval(X[,,2], gBin), levels=1:nG), 
                factor(findInterval(X[,,3], bBin), levels=1:nB)))
                rgb_feature <- as.numeric(freq_rgb$Freq)/(ncol(X)*nrow(X))
                return(rgb_feature)
                }

        for (i in 1:n_files){
                ff <- rep(NA, N*M*nR*nG*nB)
                img = readImage(paste(img_dir, img_name[i],sep=""))
                img_s <- resize(img, p_x, p_y)
                for(i in 1:N){
                        for(j in 1:M){
                        tmp <- img_s[(xbin[i]+1):xbin[i+1], (ybin[j]+1):ybin[j+1], ]
                        ff[((M*(i-1)+j-1)*nR*nG*nB+1):((M*(i-1)+j)*nR*nG*nB)] <- construct_rgb_feature(tmp) 
                        }
                }
                dat[i,] <- as.vector(ff)
        }
        
        ### output constructed features
        # if(!is.null(data_name)){
        #         save(dat, file=paste0("./output/feature2_", data_name, ".RData"))
        # }
        return(dat)
}
