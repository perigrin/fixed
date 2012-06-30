#include "EXTERN.h"
#include "perl.h"
#include "callparser.h"
#include "XSUB.h"


static OP *parse_fixed(pTHX_ GV *namegv, SV *psobj, U32 *flagsp) 
{
    OP *fixed_op;

    PERL_UNUSED_ARG(namegv);
    PERL_UNUSED_ARG(psobj);
    PERL_UNUSED_ARG(flagsp);

    *flagsp |= CALLPARSER_STATEMENT;
    lex_stuff_pv("my ", 0);
    fixed_op = parse_fullexpr(0);
    
    return fixed_op;
}

MODULE = fixed  PACKAGE = fixed

PROTOTYPES: DISABLE

void
fixed (...)
  CODE:
    int i;
    for(i = 0;i < items; i++) {
        SvREADONLY_on(ST(i));
    }

BOOT: 
{
    cv_set_call_parser(get_cv("fixed::fixed", 0), parse_fixed, &PL_sv_undef);
}