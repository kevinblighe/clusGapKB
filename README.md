# clusGapKB
<h1>Parallelised Gap statistic (Tibshirani et al., 2001) calculation and clustering</h1>
<i>NB - clusGapKB only tested in Microsoft R Open (https://mran.microsoft.com/open/)</i>
<ol type="i">
<li>Install package 'parallel'</li>
<li>Set number of CPU cores with:
<br>
<code>cpucores <- 12; options("mc.cores"=cpucores)</code>
<br>
<i>*for Microsoft R open</i></li>
<li>For PAM, create custom function that just performs the clustering and <i>ONLY</i> retains the medoids for each <i>k</i>:
<br>
<code>CustomPAM <- function(x,k) list(cluster=pam(x, k, diss=FALSE, metric="euclidean", medoids=NULL, stand=FALSE, cluster.only=TRUE, do.swap=TRUE, keep.diss=FALSE, keep.data=FALSE, pamonce=TRUE, trace.lev=0))</code></li>
<li>Execute function with:<br>
<code>gap <- clusGapKB(df, FUNcluster=CustomPAM, K.max=20, B=5)</code>
<br>
</li>
</ol>
<h2>References:</h2>
Tibshirani R, Walther G, Hastie T (2001), Estimating the number of data clusters via the Gap statistic, Journal of the Royal Statistical Society B. 63: 411–423.

<hr>

<h1>corKB - parallelised correlation calculation for large matrices</h1>
<i>NB - corKB should function in both Microsoft R Open (https://mran.microsoft.com/open/) and standard R</i>
<ol type="i">
<li>Install package 'doParallel'</li>
<li>Set number of CPU cores with:
<br>
<code>cpucores <- 4; setMKLthreads(cpucores)</code>
<br>
<i>*for Microsoft R open</i></li>
<li>Set CPU core parameters that mclapply uses:
<br>
<code>cores <- makeCluster(detectCores(), type='PSOCK'); registerDoParallel(cores); Sys.setenv("MC_CORES"=cpucores)</code>
<br>
<i>*for standard R in Windows</i></li>
<li>Create random data matrices:
<br>
<code>x <- matrix(rexp(2000, rate=0.1), ncol=20); y <- matrix(rexp(4000, rate=0.1), ncol=40)</code></li>
<li>Call function:
<br>
<code>cormatrix1 <- corKB(x, x, use="pairwise.complete.obs", method="pearson"); cormatrix2 <- corKB(x, y)</code></li>
</ol>
