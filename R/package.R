`?` <- function(e1, e2) {
  if (interactive() && sys.nframe() <= 1L) {
    call <- get("?", pos = 3L)
    return(eval(as.call(list(call, substitute(e1), substitute(e2)))))
  }
  if (missing(e2)) {
    stop(
      structure(class = c("error", "condition"),
        list(call = sys.call(-1),
             message = "argument is missing, with no default")))
  } else {
    e1
  }
}

remove_types <- function (x) {
    recurse <- function(y) {
        lapply(y, remove_types)
    }
    if (is.atomic(x) || is.name(x)) {
      x
    }
    else if (is.call(x)) {
      if (identical(x[[1]], as.symbol("?"))) {
        if (length(x) == 3) {
          as.call(recurse(x[[2]]))
        } else {
          # ?(x) call, This should only occur for arguments with no default
          quote(expr = )
        }
      } else {
        as.call(recurse(x))
      }
    }
    else if (is.function(x)) {
        formals(x) <- Recall(formals(x))
        body(x) <- Recall(body(x))
        x
    }
    else if (is.pairlist(x)) {
        as.pairlist(recurse(x))
    }
    else if (is.expression(x)) {
        as.expression(recurse(x))
    }
    else if (is.list(x)) {
        recurse(x)
    }
    else {
        stop("Unknown language class: ", paste(class(x), collapse = "/"),
            call. = FALSE)
    }
}
