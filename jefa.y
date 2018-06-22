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
    MOUSEPOSY INSTRING STRING_T INT_T AUTO_T REGEXP REGEXP_T AUTO PRINT

    %token<i> INT

%token<s> ID STRING

%type<node> file statement expression definition primary type assignment operand operator built_in function fargs boperator


%left EQCOMP EQASS NE
	    
%start file
    

%%

file : statement
	{
		root = $1;
		print_program(root);	
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
		} | function SEMICOL
		{
			$$ = new_tree();
			add_node($$, $1);
			add_terminal_node($$, semicol_);
		} | expression SEMICOL {

			$$ = new_tree();
			add_node($$, $1);
			add_terminal_node($$, semicol_);
		} | operand SEMICOL
		{
			$$ = new_tree();
			add_node($$, $1);
			add_terminal_node($$, semicol_);

		}
	;

definition : 
	type assignment 
	{
			$$ = new_tree();
			add_node($$, $1);
			add_node($$, $2);
	} 
	| type ID
	{
			$$ = new_tree();
			add_node($$, $1);
			add_terminal_node_with_value($$, id_, $2);
	} 

	;

type : INT_T
{
	$$ = new_tree();
	add_terminal_node($$, int_t_);
} | AUTO_T
{
	$$ = new_tree();
	add_terminal_node($$, auto_t);
} | REGEXP_T
{
	$$ = new_tree();
	add_terminal_node($$, regexp_t);
} | STRING_T
{
	$$ = new_tree();
	add_terminal_node($$, string_t_);
}


expression : operand boperator operand {
	
	$$ = new_tree();
	$$->token = $2->token;
	add_node($$, $1);
	add_node($$, $2);
	add_node($$, $3);

	}
	| LPAREN expression RPAREN AND LPAREN expression RPAREN
	{
		$$ = new_tree();
		add_terminal_node($$, lparen_);
		add_node($$, $2);
		add_terminal_node($$, rparen_);
		add_terminal_node($$, and_);
		add_terminal_node($$, lparen_);
		add_node($$, $6);
		add_terminal_node($$, rparen_);

	}
	| LPAREN expression RPAREN OR LPAREN expression RPAREN
	{
		$$ = new_tree();
		add_terminal_node($$, lparen_);
		add_node($$, $2);
		add_terminal_node($$, rparen_);
		add_terminal_node($$, or_);
		add_terminal_node($$, lparen_);
		add_node($$, $6);
		add_terminal_node($$, rparen_);
	}

;

boperator : EQCOMP 
	{
	$$ = new_tree();
	add_terminal_node($$, eqcomp_);
	$$->token = eqcomp_;
	} 
	| NE 
	{
	$$ = new_tree();
	add_terminal_node($$, ne_);
	$$->token = ne_;
	}
	| LT {
		$$ = new_tree();
		add_terminal_node($$, lt_);
	} | GT {
		$$ = new_tree();
		add_terminal_node($$, gt_);
	} | LE {
		$$ = new_tree();
		add_terminal_node($$, le_);
	} | GE {
		$$ = new_tree();
		add_terminal_node($$, ge_);
	}

operand : primary operator operand
{
	$$ = new_tree();
	$$->token = $2->token;
	add_node($$, $1);
	add_node($$, $2);
	add_node($$, $3);
} | primary
{
	$$ = new_tree();
	add_node($$, $1);
}



primary : ID
{
	$$ = new_tree();
	add_terminal_node_with_value($$, id_, $1);

	
} | built_in 
{
	$$ = new_tree();
	add_node($$, $1);
} | LPAREN operand RPAREN 
{
	$$ = new_tree();
	add_terminal_node($$, lparen_);
	add_node($$, $2);
	add_terminal_node($$, rparen_);
}

;

built_in : STRING 
{
	$$ = new_tree();
	add_terminal_node_with_value($$, string_, $1);
} | INT
{
	$$ = new_tree();
	char * aux = malloc(33);
	sprintf(aux, "%d", $1);
	add_terminal_node_with_value($$, int_, aux);
}

operator : ADD
{
	$$ = new_tree();
	add_terminal_node($$, add_);
} | SUB {
	$$ = new_tree();
	add_terminal_node($$, sub_);
} | AND {
	$$ = new_tree();
	add_terminal_node($$, and_);
	$$->token = and_;
} | OR {
	$$ = new_tree();
	add_terminal_node($$, or_);
	$$->token = or_;
} | MUL {
	$$ = new_tree();
	add_terminal_node($$, mul_);
} | DIV {
	$$ = new_tree();
	add_terminal_node($$, div_);
}
;
assignment : ID EQASS expression
{
	$$ = new_tree();
	add_terminal_node_with_value($$, id_, $1);
	add_terminal_node($$, eqass_);
	add_node($$, $3);
} | ID EQASS operand {
	$$ = new_tree();
	add_terminal_node_with_value($$, id_, $1);
	add_terminal_node($$, eqass_);
	add_node($$, $3);

}
;

function : PRINT fargs {
	$$ = new_tree();
	add_terminal_node($$, print_);
	add_node($$, $2);
	$$->token = print_;
}

;

fargs : expression {
	$$ = new_tree();
	add_node($$, $1);
} | operand {
	$$ = new_tree();
	add_node($$, $1);
}



%%

int main() {
	yyparse();
	return 0;
}

int yyerror(char * s) {
	fprintf(stderr, "%s\n", s);
	return 0;
}