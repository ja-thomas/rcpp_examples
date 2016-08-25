library(inline)
## memoization using C++
mincltxt = "
#include <algorithm>
#include <vector>
#include <stdexcept>
#include <cmath>
#include <iostream>

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
throw std::range_error(\"x too large fo implementation\");
if (! isnan(memo[x]))
return(memo[x]); //if exist, reuse values
// build precomputed value via recursion
memo[x] = fibonacci(x - 2) + fibonacci(x - 1);
return( memo[x] ); // return
}
private:
std::vector< double > memo; // internal memory for precomputation
};
"


## now use the snippet above as well as one argument conversion
## in as well as out to provide Fibonacci numbers via C++
mfibRcpp = cxxfunction(signature(xs = "int"),
  plugin = "Rcpp",
  includes = mincltxt,
  body = "
int x = Rcpp::as<int>(xs);
Fib f;
return Rcpp::wrap( f.fibonacci(x-1) );
")