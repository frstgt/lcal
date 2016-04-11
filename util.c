/**/
/**/

#define UTIL_C
#include "util.h"

/**/

#include <stdio.h>
#include <stdlib.h>

list *assemble_list(int sw, double real)
{
  static list *top=NULL, *last;
  list *tmp;

  if(sw) last = NULL;
  tmp = allocate_list();
  if(!tmp){
    free_list(top);
    return NULL;
  }
  tmp->real = real;
  if(last){
    last->next = tmp;
    last = tmp;
  }else{
    top = last = tmp;
  }

  return top;
}

list *copy_list(list *org)
{
  list *top, *last, *tmp;

  last = NULL;
  while(org){
    tmp = allocate_list();
    if(!tmp){
      free_list(top);
      return NULL;
    }
    tmp->real = org->real;
    if(last){
      last->next = tmp;
      last = tmp;
    }else{
      top = last = tmp;
    }
    org=org->next;
  }

  return top;
}

void print_list(list *L)
{
  if(!L) return;

  while(L){
    printf("%g  ", L->real);
    L = L->next;
  }
}

list *count_list(list *L)
{
  list *tmp;
  tmp = allocate_list();
  if(tmp) for(tmp->real=.0; L; L=L->next) tmp->real += 1.0;

  return tmp;
}

#if 0
list *assem(int sw, double t);
void pr(list *t);

list *calc1(double (*op)(double), list *t);
list *calc2(double (*op)(double, double), list *s, list *t);
list *sum(list *t);
list *pi(list *t);
list *neg(list *t);
list *inv(list *t);
list *num(list *t);

list *head(list *t);
list *tail(list *t);
list *cat(list *s, list *t);

int set(char *id, list *t);
list *call(char *id);
#endif

/**/
/**/

