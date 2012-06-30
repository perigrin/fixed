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
    
    // okay this works but it won't scale, and it is *ass* ugly.
    // I need to find a better way to hack the OP tree
    OP *pad_op;
    switch(fixed_op->op_type) {
        case OP_SASSIGN:
            pad_op = ((BINOP*)fixed_op)->op_last;
            break;
    }
    // And this doesn't work. Or rather it does, just not in a useful way. 
    // It sets the SV to read-only before the expression is evaluated ...
    // instant "Modification of a read-only value attempted" error \o/
    if (pad_op->op_type == OP_PADSV) {    
        SvREADONLY_on(PAD_SV(pad_op->op_targ));
    }

    op_dump(fixed_op);
    return fixed_op;
}

MODULE = fixed  PACKAGE = fixed

PROTOTYPES: DISABLE

void
fixed (...)
  CODE:
    PERL_UNUSED_ARG(items);
    // croak("fixed called as a function");

BOOT: 
{
    cv_set_call_parser(get_cv("fixed::fixed", 0), parse_fixed, &PL_sv_undef);
}