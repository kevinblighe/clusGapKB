# clusGapKB
<h1>Parallelised Gap statistic (Tibshirani et al., 2001) calculation and clustering</h1>
<br>
<ol type="i">
<li>Install package 'parallel'</li>
<li>Set cores for parallel related functions:
<br>
<code>cpucores <- 12; require(parallel); options("mc.cores"=cpucores)</code>
<br>
<li>Set cores for doParallel related functions:
<br>
<code>require(doParallel); registerDoParallel(cpucores)</code>
<br>
  <i>Note: you can automatically detect the number of CPU cores with <code>cpucores <- makeCluster(detectCores(), type='PSOCK'</code></i>
  <br>:
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

<h1>Credits</h1>
<ul>
  <li>Kevin Blighe (Brigham & Women's Hospital / Harvard Medical School)</li>
</ul>
