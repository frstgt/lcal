/**/
/**/

%{

#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "tools/lex_str.h"
#include "list.h"
#include "yacc.tab.h"

static double Add(double a, double b){ return a+b; }
static double Sub(double a, double b){ return a-b; }
static double Mul(double a, double b){ return a*b; }
static double Div(double a, double b){ return a/b; }

%}

Name ([A-Z]+)

Real ([-+]?[0-9]+(\.[0-9]+)?([eE][-+]?[0-9]+)?)

%%

[\n\t ]  ;

"sum"  return Sum;
"pi"   return Pi;
"neg"  return Neg;
"inv"  return Inv;
"num"  return Num;

"abs"   yylval.op1 = fabs;  return OP1;
"exp"   yylval.op1 = exp;  return OP1;
"log"   yylval.op1 = log;  return OP1;
"sqrt"  yylval.op1 = sqrt; return OP1;
"sin"   yylval.op1 = sin;  return OP1;
"cos"   yylval.op1 = cos;  return OP1;
"tan"   yylval.op1 = tan;  return OP1;
"atan"  yylval.op1 = atan; return OP1;

"+"  yylval.op2 = Add; return OP2;
"-"  yylval.op2 = Sub; return OP2;
"*"  yylval.op2 = Mul; return OP2;
"/"  yylval.op2 = Div; return OP2;

"="     return Set;

"quit"  return Quit;

{Real}  yylval.real = atof(yytext);  return Real;
{Name}  yylval.name = strdup(yytext);  return Name;

.  return yytext[0];

%%

int yyerror(char *str){ fprintf(stderr, "%s\n", str); return 0; }
int yywrap(void){ return 1; }

/**/
/**/
