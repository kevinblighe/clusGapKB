# ParallelisedR
R functions which I have edited to enable parallel processing

# Instructions
# clusGapKB - pallelised Gap statistic calculation and clustering
<ol type="1">
<li>Install package 'parallel'</li>
<li>Set number of CPU cores with:</li>
<br>cpucores <- 12; options("mc.cores"=cpucores)<br>
<i>*for Microsoft R open</i>
<li>For PAM, create custom function that just performs the clustering and <i>ONLY</i> retains the medoids for each <i>k</i>:<br>
CustomPAM <- function(x,k) list(cluster=pam(x, k, diss=FALSE, metric="euclidean", medoids=NULL, stand=FALSE, cluster.only=TRUE, do.swap=TRUE, keep.diss=FALSE, keep.data=FALSE, pamonce=TRUE, trace.lev=0))</li>
<li>Execute function with:<br>gap <- clusGapKB(df, FUNcluster=CustomPAM, K.max=20, B=5)<br>
<i>NB - clusGapKB only tested in Microsoft R Open (https://mran.microsoft.com/open/)</i></li>

# corKB - parallelised correlation calculation for large matrices
1, Install package 'doParallel'
2, Set number of CPU cores with:
<br>cpucores <- 4; setMKLthreads(cpucores)<br>
<i>*for Microsoft R open</i>
3, Set CPU core parameters that mclapply uses:
<br>cores <- makeCluster(detectCores(), type='PSOCK'); registerDoParallel(cores); Sys.setenv("MC_CORES"=cpucores)
4, Create random data matrices:
<br>x <- matrix(rexp(2000, rate=0.1), ncol=20); y <- matrix(rexp(4000, rate=0.1), ncol=40)
5, Call function:
<br>cormatrix1 <- corKB(x, x, use="pairwise.complete.obs", method="pearson"); cormatrix2 <- corKB(x, y)<br>
<i>NB - corKB should function in both Microsoft R Open (https://mran.microsoft.com/open/) and standard R</i>
