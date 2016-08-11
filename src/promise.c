#include <R.h>
#include <Rdefines.h>

SEXP unbound() {
  return R_UnboundValue;
}
