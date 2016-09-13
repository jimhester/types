library(types)
add <- function(x = ? numeric, y = 1) {
  x + y
} ? numeric

add2 <- function(x = 1, y = ? numeric) {
  sum(x, y) ? numeric
}

label <- function(x) paste(as.call(list(x[[1]], quote(...))), collapse = "\n")

expect_error <- function(x, regexp) {
  error <- tryCatch({
    x
    NULL
  }, error = function(e) e)

  if (is.null(error)) {
    stop(label(x), " did not throw an error.")
  }
  if (!grepl(regexp, error$message)) {
    stop(error$message, " did not match ", regexp)
  }
  invisible(TRUE)
}

expect_error(add(), "argument is missing, with no default")
expect_error(add2(), "argument is missing, with no default")

stopifnot(add(1, 2) == 3)
stopifnot(add2(1, 2) == 3)

add_untyped <- remove_types(add)
stopifnot(identical(formals(add_untyped), as.pairlist(alist(x=, y = 1))))
stopifnot(all.equal(body(add_untyped), quote({ x + y })))

add2_untyped <- remove_types(add2)
stopifnot(identical(formals(add2_untyped), as.pairlist(alist(x = 1, y = ))))
stopifnot(all.equal(body(add2_untyped), quote({ sum(x, y) })))

stopifnot(identical(remove_types(quote(a ? b)), quote(a)))
stopifnot(identical(remove_types(quote(a + 1 ? b)), quote(a + 1)))

stopifnot(identical(remove_types(expression(a ? b, a + 1 ? b)), expression(a, a + 1)))

stopifnot(identical(remove_types(list(quote(a ? b), quote(a + 1 ? b))), list(quote(a), quote(a + 1))))
