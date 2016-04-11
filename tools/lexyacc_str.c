/* lexyacc_str.c 1996.7.6 */

#include <stdio.h>
#include <string.h>

static char *input_str = (char *)NULL;

int yyinput_str(char *buffer, int buf_size)
{
  int n = 0, str_size;
  if(input_str && *input_str){
    n = (str_size=strlen(input_str) <= buf_size) ? str_size : buf_size;
    memcpy(buffer, input_str, n);
    input_str += n;
  }
  return n;
}

int yylex_str(char *str){ input_str = str; return yylex(); }

int yyparse_str(char *str){ input_str = str; return yyparse(); }

/**/
