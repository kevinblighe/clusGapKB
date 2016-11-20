# ParallelisedR
R functions which I have edited to enable parallel processing

<h1>Instructions</h1>
<h2>clusGapKB - parallelised Gap statistic calculation and clustering</h2>
<ol type="i">
<li>Install package 'parallel'</li>
<li>Set number of CPU cores with:<br>
<code>cpucores <- 12; options("mc.cores"=cpucores)</code>
<i>*for Microsoft R open</i></li>
<li>For PAM, create custom function that just performs the clustering and <i>ONLY</i> retains the medoids for each <i>k</i>:<br>
CustomPAM <- function(x,k) list(cluster=pam(x, k, diss=FALSE, metric="euclidean", medoids=NULL, stand=FALSE, cluster.only=TRUE, do.swap=TRUE, keep.diss=FALSE, keep.data=FALSE, pamonce=TRUE, trace.lev=0))</li>
<li>Execute function with:<br>
gap <- clusGapKB(df, FUNcluster=CustomPAM, K.max=20, B=5)<br>
<i>NB - clusGapKB only tested in Microsoft R Open (https://mran.microsoft.com/open/)</i></li>
</ol>

<h2>corKB - parallelised correlation calculation for large matrices</h2>
<ol type="i">
<li>Install package 'doParallel'</li>
<li>Set number of CPU cores with:<br>
cpucores <- 4; setMKLthreads(cpucores)<br>
<i>*for Microsoft R open</i></li>
<li>Set CPU core parameters that mclapply uses:<br>
cores <- makeCluster(detectCores(), type='PSOCK'); registerDoParallel(cores); Sys.setenv("MC_CORES"=cpucores)</li>
<li>Create random data matrices:<br>
x <- matrix(rexp(2000, rate=0.1), ncol=20); y <- matrix(rexp(4000, rate=0.1), ncol=40)</li>
<li>Call function:<br>
cormatrix1 <- corKB(x, x, use="pairwise.complete.obs", method="pearson"); cormatrix2 <- corKB(x, y)<br>
<i>NB - corKB should function in both Microsoft R Open (https://mran.microsoft.com/open/) and standard R</i></li>
