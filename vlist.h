
#ifndef VLIST_H
#define VLIST_H

#include "list.h"

typedef struct _vlist{
  char *name;
  list *value;
  struct _vlist *prev, *next;
} vlist;

#ifdef VLIST_C
#define extern /**/
#endif

extern vlist *allocate_vlist(void);
extern void collect_vlist(vlist *top);

#undef extern

#endif /* VLIST_H */

