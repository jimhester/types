`?` <- function(e1, e2) {
  if (missing(e2)) {
    .Call(unbound)
  } else {
    e1
  }
}
