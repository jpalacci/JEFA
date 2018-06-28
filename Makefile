CC = gcc

all: y.tab.c lex.yy.c compiler 


y.tab.c: jefa.y
	@yacc -d jefa.y 2> /dev/null

lex.yy.c: jefa.l 
	@flex jefa.l 2> /dev/null

compiler: 
	@$(CC) -o jefa lex.yy.c y.tab.c treenode.c 2> /dev/null
	@make clean

clean:
	@rm -rf *~ lex.yy.o y.tab.o lex.yy.c y.output y.tab.c y.tab.h treenode.o