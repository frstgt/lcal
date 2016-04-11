/**/

#ifndef LEX_STR_H
#define LEX_STR_H

#undef YY_INPUT
#define YY_INPUT(buffer, result, buf_size) (result = yyinput_str(buffer, buf_size))

extern int yyinput_str(char *buffer, int buf_size);
extern int yylex_str(char *str);

#endif /* LEX_STR_H */

/**/
