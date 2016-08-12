#include <R.h>
#include <Rversion.h>
#include <Rdefines.h>
#include <setjmp.h>
#include <Rinternals.h>

typedef struct RPRSTACK {
    SEXP promise;
    struct RPRSTACK *next;
} RPRSTACK;

#define JMP_BUF sigjmp_buf

typedef struct RCNTXT {
    struct RCNTXT *nextcontext; /* The next context up the chain */
    int callflag;               /* The context "type" */
    JMP_BUF cjmpbuf;            /* C stack and register information */
    int cstacktop;              /* Top of the pointer protection stack */
    int evaldepth;              /* evaluation depth at inception */
    SEXP promargs;              /* Promises supplied to closure */
    SEXP callfun;               /* The closure called */
    SEXP sysparent;             /* environment the closure was called from */
    SEXP call;                  /* The call that effected this context*/
    SEXP cloenv;                /* The environment */
    SEXP conexit;               /* Interpreted "on.exit" code */
    void (*cend)(void *);       /* C "on.exit" thunk */
    void *cenddata;             /* data for C "on.exit" thunk */
    void *vmax;                 /* top of R_alloc stack */
    int intsusp;                /* interrupts are suspended */
    int gcenabled;              /* R_GCenabled value */
    SEXP handlerstack;          /* condition handler stack */
    SEXP restartstack;          /* stack of available restarts */
    struct RPRSTACK *prstack;   /* stack of pending promises */
    SEXP *nodestack;
    #ifdef BC_INT_STACK
        IStackval *intstack;
    #endif
    SEXP srcref;                  /* The source line in effect */
    int browserfinish;          /* should browser finish this context without stopping */
} RCNTXT ;
extern RCNTXT* R_GlobalContext;

SEXP unbound() {
  /*return R_MissingValue;*/
  /*return R_UnboundValue;*/
  RCNTXT* ctx = R_GlobalContext;
  //std::cout << PRCODE(ctx->prstack->promise) << '\n';
 /*PRCODE(ctx->prstack->promise);*/
  return ctx;
}

