## memoization solution courtesy of Pat Burns
mfibR = local({
  memo = c(1, 1, rep(NA, 1000))
  f = function(x) {
    if (x == 0) return(0)
    if (x < 0) return(NA)
    if (x > length(memo))
      stop("x too big for implementation")
    if (!is.na(memo[x])) return(memo[x])
    ans = f(x - 2) + f(x - 1)
    memo[x] <<- ans
    ans
  }
})