// FIXME: This doesnt work for some reason (always returns 0), hopefully I can figure out later why
#include <Rcpp.h>
#include <algorithm>
#include <vector>
#include <stdexcept>
#include <cmath>
#include <iostream>
using namespace Rcpp;


class Fib {
public:
  Fib(unsigned int n = 1000) {
    memo.resize(n); //reserve n elements
    std:fill( memo.begin(), memo.end(), NAN); //set to NaN
    memo[0] = 0.0; //initialize for n = 0 and n = 1
    memo[1] = 1.0;
  }
  double fibonacci(int x) {
    if (x < 0)
      return( (double) NAN );
    if (x >= (int) memo.size())
      throw std::range_error("x too large fo implementation");
    if (! std::isnan(memo[x]))
      return(memo[x]); //if exist, reuse values
    // build precomputed value via recursion
    memo[x] = fibonacci(x - 2) + fibonacci(x - 1);
    return( memo[x] ); // return
  }
private:
  std::vector< double > memo; // internal memory for precomputation
};

// [[Rcpp::export]]
int fib(const int x) {
  Fib f;
  f.fibonacci(x);
}
