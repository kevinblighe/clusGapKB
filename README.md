# ParallelisedR
Existing R functions which I have edited to enable parallel processing

# Instructons
clusGapKB:
 - Install package 'parallel'
 - Set number of CPU cores with:  cpucores <- 12; options("mc.cores"=cpucores)
 - For PAM, create custom function:  CustomPAM <- function(x,k) list(cluster=pam(x, k, diss=FALSE, metric="euclidean", medoids=NULL, stand=FALSE, cluster.only=TRUE, do.swap=TRUE, keep.diss=FALSE, keep.data=FALSE, pamonce=TRUE, trace.lev=0))
 - Execute as normal with:  gap <- clusGapKB(df, FUNcluster=CustomPAM, K.max=20, B=5)
 
NB - clusGapKB only tested in Microsoft R Open (https://mran.microsoft.com/open/)
