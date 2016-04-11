
CC = gcc
SCANER = flex -I
PARSER = bison -d

TARGET = lcal
OBJ_0 = lex.o yacc.o lexyacc_str.o
OBJ_1 = list.o util.o
OBJ_2 =
OBJ_3 = vlist.o var.o
LIB = -lreadline -lm # -ltermcap
CFLAGS = -I/usr/include/readline
#CFLAGS = -Itools -Ltools/readline

# all

$(TARGET): $(OBJ_0) $(OBJ_1) $(OBJ_2) $(OBJ_3)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ_0) $(OBJ_1) $(OBJ_2) $(OBJ_3) $(LIB)

# lex, yacc

lex.o: lex.yy.c     yacc.tab.h
	$(CC) -c $(CFLAGS) -o lex.o lex.yy.c

lex.yy.c: lex.l     tools/lex_str.h
	$(SCANER) lex.l

yacc.o: yacc.tab.c
	$(CC) -c $(CFLAGS) -o yacc.o yacc.tab.c

yacc.tab.h yacc.tab.c: yacc.y      tools/yacc_str.h
	$(PARSER) yacc.y

lexyacc_str.o: tools/lexyacc_str.c
	$(CC) -c $(CFLAGS) -o lexyacc_str.o tools/lexyacc_str.c

# list

list.o: list.h list.c
	$(CC) -c $(CFLAGS) -o list.o list.c

util.o: util.h util.c
	$(CC) -c $(CFLAGS) -o util.o util.c

# variable

vlist.o: vlist.h vlist.c
	$(CC) -c $(CFLAGS) -o vlist.o vlist.c

var.o: var.h var.c
	$(CC) -c $(CFLAGS) -o var.o var.c

##

clean:
	rm -f $(TARGET) a.out *~ *.o lex.yy.c yacc.tab.c yacc.tab.h

##
##

