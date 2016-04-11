/**/

%{

#include <stdio.h>
#include <stdlib.h>

#include <readline/readline.h>
#include <readline/history.h>
#include "tools/yacc_str.h"

#include "list.h"
#include "util.h"
#include "var.h"

list *asm_ls = NULL;

%}

%union{
  double real;
  char *name;
  double (*op1)(double);
  double (*op2)(double, double);
  list *value;
};

%token <real> Real
%token <name> Name
%token <op1> OP1
%token <op2> OP2
%token Sum Pi Neg Inv Num
%token Set Quit

%type <value> List expr

%right  Set
%right  OP2
%right  OP1
%right  Sum Pi Neg Inv Num

%%

stat
: expr {
  list *t = $1;
  while(t){
    printf(" %g ", t->real);
    t = t->next;
  } 
  printf("\n");
  free_list($1);
}
| error '\n' {
  yyclearin;
  yyerrok;
}
;

expr
: Quit{ exit(0); }
| List
| Name {
  $$ = copy_list(search_var($1));
  free($1);
}
| Name Set expr {
  $$ = copy_list($3);
  entry_var($1, $3);
}
| '(' expr ')' {
  $$ = $2;
}
| OP1 expr {
  list *t = $2;
  while(t){
    t->real = $1(t->real);
    t = t->next;
  }
  $$ = $2;
}
| expr OP2 expr {
  list *s = $1, *t = $3;
  if(s && !s->next){
    while(t){
      t->real = $2(s->real, t->real);
      t = t->next;
    }
    $$ = $3;
    free_list($1);
  }else if(t && !t->next){
    while(s){
      s->real = $2(s->real, t->real);
      s = s->next;
    }
    $$ = $1;
    free_list($3);
  }else{
    while(s && t){
      s->real = $2(s->real, t->real);
      s = s->next;
      t = t->next;
    }
    if(s || t){
      free_list($1);
      free_list($3);
      $$ = NULL;
    }else{
      $$ = $1;
      free_list($3);
    }
  }
}
| Sum expr {
  list *s = $2;
  double t = 0.0;
  while(s){
    t += s->real;
    s = s->next;
  }
  if($2){
    free_list($2->next);
    $2->real = t;
    $2->next = NULL;
  }
  $$ = $2;
}
| Pi expr {
  list *s = $2;
  double t = 1.0;
  while(s){
    t *= s->real;
    s = s->next;
  }
  if($2){
    free_list($2->next);
    $2->real = t; 
    $2->next = NULL;
  }
  $$ = $2;
}
| Neg expr {
  list *t = $2;
  while(t){
    t->real = -t->real;
    t = t->next;
  }
  $$ = $2;
}
| Inv expr {
  list *t = $2;
  while(t){
    t->real = 1.0/t->real;
    t = t->next;
  }
  $$ = $2;
}
| Num expr {
  list *s = $2;
  double t = 0.0;
  while(s){
    t += 1.0;
    s = s->next;
  }
  if($2){
    free_list($2->next);
    $2->real = t; 
    $2->next = NULL;
  }
  $$ = $2;
}
;

List
: List Real {
  asm_ls->next = allocate_list();
  if(asm_ls->next){
    asm_ls = asm_ls->next;
    asm_ls->real = $2;
    $$ = $1;
  }else{
    $$ = NULL;
    free_list($1);
  }
}
| Real {
  asm_ls = allocate_list();
  if(asm_ls){
    asm_ls->real = $1;
  }
  $$ = asm_ls;
}
;

%%

main()
{
  char *line;

  for(;;){
    line = readline("lcal> ");
    if(line && *line){
      add_history(line);
      yyparse_str(line);
      free(line);
    }
  }
}

/**/
