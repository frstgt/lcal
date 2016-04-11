
#ifndef UTIL_H
#define UTIL_H

#include "list.h"

#ifdef UTIL_C
#define extern /**/
#endif


extern list *assemble_list(int sw, double real);
extern list *copy_list(list *org);
extern void print_list(list *L);
extern list *count_list(list *L);

#undef extern

#endif /* UTIL_H */

