clusGapKB <- function (
      x,
      FUNcluster,
      K.max,
      B=100,
      d.power=1,
      verbose=interactive(),
      ...)
    {
      stopifnot(is.function(FUNcluster), length(dim(x))==2, K.max>=2, (n<-nrow(x))>=1, ncol(x)>=1)
        
      if (B != (B. <- as.integer(B)) || (B <- B.) <= 0) {
        stop("'B' has to be a positive integer")
      }
        
      if (is.data.frame(x)) {
        x <- as.matrix(x)
      }
        
      ii <- seq_len(n)
        
      # KB
      ############
      # create a function that will accept a parallel job
      if (Sys.info()['sysname'] == 'Windows') {
        funParallel <- parallel::parLapply
      } else {
        funParallel <- parallel::mclapply
      }
      ############
    
      W.k <- function(X, kk) {
        clus <- if (kk > 1) {
        FUNcluster(X, kk, ...)$cluster
      } else {
        rep.int(1L, nrow(X))
      }
    
      0.5 * sum(vapply(split(ii, clus), function(I) {
        xs <- X[I, , drop = FALSE]
        sum(dist(xs)^d.power/nrow(xs))}, 0))
      }
    
      logW <- E.logW <- SE.sim <- numeric(K.max)
        
      if (verbose) {
        cat("Clustering k = 1,2,..., K.max (= ", K.max, "): .. ", sep = "")
      }
    
      # KB
      ############
      # original code:
      #for (k in 1:K.max) logW[k] <- log(W.k(x, k))
      # modified code:
      if (Sys.info()['sysname'] == 'Windows') {
        logW <- unlist(funParallel(cl, 1:K.max, function(k) log(W.k(x, k))))
      } else {
        logW <- unlist(funParallel(1:K.max, function(k) log(W.k(x, k))))
      }
      ############
        
      if (verbose) {
        cat("done\n")
      }
    
      xs <- scale(x, center = TRUE, scale = FALSE)
      m.x <- rep(attr(xs, "scaled:center"), each = n)
      V.sx <- svd(xs, nu = 0)$v
      rng.x1 <- apply(xs %*% V.sx, 2, range)
      logWks <- matrix(0, B, K.max)
    
      if (verbose) {
        cat("Bootstrapping, b = 1,2,..., B (= ", B, ")  [one \".\" per sample]:\n", sep = "")
      }
    
      for (b in 1:B) {
        z1 <- apply(rng.x1, 2, function(M, nn) runif(nn, min=M[1], max=M[2]), nn=n)
    
        z <- tcrossprod(z1, V.sx) + m.x
    
        # KB
        ############
        # original code:
        #for (k in 1:K.max) {
        #	logWks[b, k] <- log(W.k(z, k))
        #}
        # modified code:
        if (Sys.info()['sysname'] == 'Windows') {
          tmplogWks <- unlist(funParallel(cl, 1:K.max, function(k) log(W.k(z, k))))
        } else {
          tmplogWks <- unlist(funParallel(1:K.max, function(k) log(W.k(z, k))))
        }
        logWks[b,1:K.max] <- tmplogWks
        ############

        if (verbose) {
          cat(".", if (b%%50 == 0) paste(b, "\n"))
        }
      }
    
      if (verbose && (B%%50 != 0)) {
        cat("", B, "\n")
      }
    
      E.logW <- colMeans(logWks)
      SE.sim <- sqrt((1 + 1/B) * apply(logWks, 2, var))
    
      structure(
        class="clusGap",
        list(
          Tab=cbind(logW, E.logW, gap=E.logW-logW, SE.sim),
        n=n,
        B=B,
        FUNcluster=FUNcluster))
    }
