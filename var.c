
#define VAR_C
#include "var.h"

/**/

#include <stdio.h>
#include <string.h>

#include "vlist.h"

static vlist *vars = NULL;

/**/

list *search_var(char *name)
{
  vlist *srch;

  if(!name) return NULL;

  srch = vars;
  while(srch && strcmp(name, srch->name)) srch = srch->next;
  if(!srch) return NULL;
  if(srch!=vars){
    if(srch->prev) srch->prev->next = srch->next; /* always true */
    if(srch->next) srch->next->prev = srch->prev;
    srch->prev = NULL;
    srch->next = vars;
    vars->prev = srch;
    vars = srch;
  }

  return srch->value;
}

void entry_var(char *name, list *value)
{
  vlist *new;

  if(!name) return;

  if(search_var(name)){
    free_list(vars->value);
    vars->value = value;
    return;
  }

  new = allocate_vlist();
  if(!new) return;
  new->name = name;
  new->value = value;
  new->next = vars;
  if(vars) vars->prev = new;
  vars = new;
}


