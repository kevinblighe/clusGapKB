# ParallelisedR
R functions which I have edited to enable parallel processing

# Instructions
# clusGapKB - pallelised Gap statistic calculation and clustering
 - Install package 'parallel'
 - Set number of CPU cores with:
   cpucores <- 12; options("mc.cores"=cpucores)
 - For PAM, create custom function:
   CustomPAM <- function(x,k) list(cluster=pam(x, k, diss=FALSE, metric="euclidean", medoids=NULL, stand=FALSE, cluster.only=TRUE, do.swap=TRUE, keep.diss=FALSE, keep.data=FALSE, pamonce=TRUE, trace.lev=0))
 - Execute function with:
   gap <- clusGapKB(df, FUNcluster=CustomPAM, K.max=20, B=5)
NB - clusGapKB only tested in Microsoft R Open (https://mran.microsoft.com/open/)

# corKB - parallelised correlation calculation for large matrices
 - Install package 'doParallel'
 - Set number of CPU cores with
   cpucores <- 4; setMKLthreads(cpucores)
 - Set CPU core parameters that mclapply uses
   cores <- makeCluster(detectCores(), type='PSOCK')
   registerDoParallel(cores)
   Sys.setenv("MC_CORES"=cpucores)
 - Create random data matrices:
   x <- matrix(rexp(2000, rate=0.1), ncol=20); y <- matrix(rexp(4000, rate=0.1), ncol=40)
 - Call function:
   cormatrix1 <- corKB(x, x)
   cormatrix2 <- corKB(x, y)
NB - corKB should function in both Microsoft R Open (https://mran.microsoft.com/open/) and base R
