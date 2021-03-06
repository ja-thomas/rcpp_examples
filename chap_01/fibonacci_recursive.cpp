#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
int fibonacci(const int x) {
  if (x == 0) 
    return(0);
  if (x == 1)
    return(1);
  return (fibonacci(x - 1) + fibonacci(x - 2));
}


// can be sourced via sourceCPP() from package Rcpp