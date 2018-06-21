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

%type<node> file statement expression definition primary type assignment


%left EQCOMP EQASS NE
	    
%start file
    

%%

file : statement
	{
		root = $1;
		print_tree(root);	
	}
     ;

statement : statement statement {
		$$ = new_tree();
		add_node($$, $1);
		add_node($$, $2);

	}
	| WHILE LPAREN expression RPAREN LCURLY statement RCURLY {
		$$ = new_tree();

		add_terminal_node($$, while_);
		add_terminal_node($$, lparen_);
		add_node($$, $3);
		add_terminal_node($$, rparen_);
		add_terminal_node($$, lcurly_);
		add_node($$, $6);
		add_terminal_node($$, rcurly_);


	}
	| SEMICOL {
		$$ = new_tree();
		add_terminal_node($$, semicol_);

	}
	| IF LPAREN expression RPAREN LCURLY statement RCURLY {

		$$ = new_tree();

		add_terminal_node($$, if_);
		add_terminal_node($$, lparen_);
		add_node($$, $3);
		add_terminal_node($$, rparen_);
		add_terminal_node($$, lcurly_);
		add_node($$, $6);
		add_terminal_node($$, rcurly_);

	} | definition SEMICOL 
		{
			$$ = new_tree();
			add_node($$, $1);
			add_terminal_node($$, semicol_);

		} | assignment SEMICOL
		{
			$$ = new_tree();
			add_node($$, $1);
			add_terminal_node($$, semicol_);
		}
	;

definition : type ID
	{
			$$ = new_tree();
			add_node($$, $1);
			add_terminal_node_with_value($$, id_, $2);
	} | type assignment 
	{
			$$ = new_tree();
			add_node($$, $1);
			add_node($$, $2);
	} 

	;

type : INT_T
{
	$$ = new_tree();
	add_terminal_node($$, int_t_);
}


expression : expression EQCOMP expression {
	$$ = new_tree();
	add_node($$, $1);
	add_terminal_node($$, eqcomp_);
	add_node($$, $3);
	add_terminal_node($$, rparen_);

} | expression NE expression 
	{
		$$ = new_tree();
		add_terminal_node($$, ne_);
		add_node($$, $1);
		add_terminal_node($$, eqcomp_);
		add_node($$, $3);
		add_terminal_node($$, rparen_);
	}
	| primary
	{
		$$ = new_tree();
		add_node($$, $1);
	}

;

primary : ID
{
	$$ = new_tree();
	add_terminal_node_with_value($$, id_, $1);

	
} | INT {
	
	$$ = new_tree();
	char * buffer = malloc(33);
	sprintf(buffer, "%d", $1);
	add_terminal_node_with_value($$, int_, buffer);
} | LPAREN expression RPAREN 
	{

		$$ = new_tree();

		add_terminal_node($$, lparen_);
		add_node($$, $2);
		add_terminal_node($$, rparen_);
	}

;

assignment : ID EQASS expression
{
	$$ = new_tree();
	add_terminal_node_with_value($$, id_, $1);
	add_terminal_node($$, eqass_);
	add_node($$, $3);
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