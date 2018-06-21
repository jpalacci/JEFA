// Declarations
%{

#include <stdio.h>
#include <stdlib.h>
#include "treenode.h"

extern int yylex();

static Node * root;


%}

%union{
		int i; 
		char *s; 
		struct Node_t * node;
}
 
%token<node> WHILE LPAREN RPAREN LCURLY RCURLY IF ELSE
    REPEAT SEMICOL PAUSE OUTSTRING OUTINT LCLICK
    RCLICK LRELEASE RRELEASE UP DOWN LEFT RIGHT
    PRESSKEY RELEASEKEY EQASS OR AND EQCOMP NE LT
    LE GT GE ADD SUB MUL DIV MOD OPP ININT MOUSEPOSX 
    MOUSEPOSY INSTRING STRING_T INT_T AUTO REGEXP

    %token<i> INT


%token<s> ID STRING

%type<node> file statement expression

	    
%start file
    

%%

file : statement
	{
		root = $1;
		print_tree(root);	
	}
     ;

statement : statement statement {

	}
	| WHILE LPAREN expression RPAREN LCURLY statement RCURLY {
		$$ = new_tree();

		add_terminal_node($$, "while");
		add_terminal_node($$, "(");
		add_node($$, $3);
		add_terminal_node($$, ")");
		add_terminal_node($$, "{");
		add_node($$, $6);
		add_terminal_node($$, "}");


	}
	| SEMICOL {
		$$ = new_tree();
		add_terminal_node($$, ";");

	}
	| INT statement {

	}
	;

expression : INT {
	$$ = new_tree();
	char * buffer = malloc(33);
	sprintf(buffer, "%d", $1);
	add_terminal_node($$, buffer);

}

;


%%

main() {
	yyparse();
	return 0;
}

yyerror(char * s) {
	fprintf(stderr, "%s\n", s);
}