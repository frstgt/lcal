
#ifndef LIST_H
#define LIST_H

typedef struct _list{
  double real;
  struct _list *next;
} list;

#ifdef LIST_C
#define extern /**/
#endif

extern list *allocate_list(void);
extern void free_list(list *top);

#undef extern

#endif /* LIST_H */

#if 0
typedef struct _cell{
  enum{ SYSTEM, SCALAR, VECTOR } type;
  union{
    double scalar;
    struct _vector{
      size_t length;
      double *vector;
    } vector;
    struct _cell *next;
  } value;
} CELL;
#endif
