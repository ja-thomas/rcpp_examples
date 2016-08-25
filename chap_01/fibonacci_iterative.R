## linear / iterative solution
fibRiter = function(n) {
  first = 0
  second = 1
  third = 0
  for (i in seq_len(n)) {
    third = first + second
    first = second
    second = third
  }
  return(first)
}