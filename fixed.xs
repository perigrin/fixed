#include "EXTERN.h"
#include "perl.h"
#include "callchecker0.h"
#include "callparser.h"
#include "XSUB.h"


static OP *parse_fixed(pTHX_ GV *namegv, SV *psobj, U32 *flagsp) 
{
    OP *fixed_op;
    
    *flagsp |= CALLPARSER_STATEMENT;
    lex_stuff_pv("my ", 0);
    fixed_op = parse_barestmt(0);
    /* now we just gotta crawl stmnt and set SvREADONLY_on() on the SVs we just assigned. */
    return fixed_op;
}

MODULE = fixed  PACKAGE = fixed

PROTOTYPES: DISABLE

BOOT: 
{
    cv_set_call_parser(get_cv("fixed::fixed", 0), parse_fixed, &PL_sv_undef);
}