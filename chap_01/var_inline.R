##Now load 'inline' to compile C++ code on the fly

library(inline)
code = "
  arma::mat coef = Rcpp::as<arma::mat>(a);
  arma::mat errors = Rcpp::as<arma::mat>(u);
  int m = errors.n_rows;
  int n = errors.n_cols;
  arma::mat simdata(m, n);
  simdata.row(0) = arma::zeros<arma::mat>(1,n);
  for (int row=1; row<m; row++) {
    simdata.row(row) = simdata.row(row-1) * trans(coef) + errors.row(row);
  }
  return Rcpp::wrap(simdata);
"


## create the compiled function

rcppSim = cxxfunction(signature(a = "numeric", u = "numeric"), code, plugin = "RcppArmadillo")

set.seed(123)
a = matrix(c(0.5, 0.1, 0.1, 0.5), nrow = 2)
u = matrix(rnorm(10000), ncol = 2)
rcppData = rcppSim(a, u)
