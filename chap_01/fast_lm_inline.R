library(inline)
src = '
  Rcpp::NumericVector yr(ys);
  Rcpp::NumericMatrix Xr(Xs);
  int n = Xr.nrow(), k = Xr.ncol();

  arma::mat X(Xr.begin(), n, k, false);
  arma::colvec y(yr.begin(), yr.size(), false);
  
  arma::colvec coef = arma::solve(X, y); // fit y ~ X
  arma::colvec res = y - X*coef; // residuals

  double s2 = std::inner_product(res.begin(), res.end(), res.begin(), double()) / (n - k);
  arma::colvec se = arma::sqrt(s2 * arma::diagvec(arma::inv(arma::trans(X)*X)));
  
  return Rcpp::List::create(Rcpp::Named("coef") = coef,
                            Rcpp::Named("se") = se,
                            Rcpp::Named("df") = n-k);
'

fun = cxxfunction(signature(ys = "numeric", Xs = "numeric"), src, plugin = "RcppArmadillo")

x = matrix(rnorm(10), ncol = 2)
y = rnorm(5)
fun(y, x)
