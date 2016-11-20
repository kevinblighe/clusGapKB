
corKB <- function(x, y, use="pairwise.complete.obs", method="pearson")
{
	require(doParallel)

	mylist <- list(x, y)

	cormatrix <- mclapply(mylist, function(x) cor(x, y, use=use, method=method))

	return(cormatrix)[[1]]
}
