
#define VLIST_C
#include "vlist.h"

/**/
/**/

#include <stdio.h>
#include <stdlib.h>

static vlist *pool = NULL;
#define P_INCREMENT 100

/**/

#include <limits.h>
#define SIZE_T_MAX UINT_MAX

static vlist **source = NULL;
static size_t s_max = 0;
static size_t s_point = 0;
#define S_INCREMENT 10

static void clean_pool(void)
{
  size_t i;

  for(i=0; i<s_point; i++) free(source[i]);
  free(source);
  source = NULL;
  s_max = 0;
  s_point = 0;
  pool = NULL;
}

static int sw = 0;

static int increase_pool(void)
{
  vlist **s_tmp, *p_tmp;
  size_t i;

  if(s_point >= s_max){
    if(!sw){ atexit(clean_pool); sw = !0; }

    if(s_max+S_INCREMENT >= SIZE_T_MAX) return -1;
    s_tmp = realloc(source, sizeof(vlist*)*(s_max+S_INCREMENT));
    if(!s_tmp) return -1;
    source = s_tmp;
    s_max += S_INCREMENT;
  }
  p_tmp = malloc(sizeof(vlist)*P_INCREMENT);
  if(!p_tmp) return -1;
  source[s_point++] = p_tmp;
  for(i=0; i<P_INCREMENT-1; i++) p_tmp[i].next = &(p_tmp[i+1]);
  p_tmp[i].next = pool;
  pool = p_tmp;

  return 0;
}

vlist *allocate_vlist(void)
{
  vlist *cell;

  if(!pool){
    if(increase_pool()){
      fprintf(stderr, "Warnning: No memory can I use.\n");
      return NULL;
    }
  }
  cell = pool;
  pool = cell->next;
  cell->prev = cell->next = NULL;

  return cell;
}

void collect_vlist(vlist *top)
{
  vlist *last;

  if(!top) return;

  for(last=top; last->next; last=last->next);
  last->next = pool;
  pool = top;
}

