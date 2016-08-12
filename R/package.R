`?` <- function(e1, e2) {
  if (missing(e2)) {
    stop(
      structure(class = "condition",
        list(call = sys.call(-1),
             message = "argument is missing, with no default")))
  } else {
    e1
  }
}
