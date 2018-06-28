CC = gcc

all: lex.yy.c y.tab.c jefa

jefa:
	$(CC) -o salida lex.yy.c y.tab.c


y.tab.c: jefa.y
	yacc -d jefa.y

lex.yy.c: jefa.l 
	flex jefa.l


clean:
	rm -rf *~ lex.yy.o y.tab.o jefa lex.yy.c y.output y.tab.c y.tab.h