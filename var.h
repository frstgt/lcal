
#ifndef VAR_H
#define VAR_H

#include "list.h"

#ifdef VAR_C
#define extern /**/
#endif

extern list *search_var(char *name);
extern void entry_var(char *name, list *value);

#undef extern

#endif /* VAR_H */


