%{
#include <stdio.h>
#include "y.tab.h"

%}
/* Regular definitions */

delim	[ \t\n]
ws		{delim}+
letter	[a-zA-Z]
digit	[0-9]
word	{letter}({letter}|{digit})*
number	{digit}+

%%
{ws}	{/* no action and no return */}
"auto" {return AUTO_T;}
"regexp" {return REGEXP_T;}
#.*	{/* comments, no action and no return */}
"if"	{return IF;}
"else"	{return ELSE;}
"while"	{return WHILE;}
\{	{return LCURLY;}
\}	{return RCURLY;}
\(	{return LPAREN;}
\)	{return RPAREN;}
\;	{return SEMICOL;}
=	{return EQASS;}
"or"	{return OR;}
"and"	{return AND;}
"equals"	{return EQCOMP;}
"not equals"	{return NE;}
"<"	{return LT;}
"true"	{return TRUE;}
"false"	{return FALSE;}
"<="	{return LE;}
">"	{return GT;}
">="	{return GE;}
"+"	{return ADD;}
"-"	{return SUB;}
"*"	{return MUL;}
"/"	{return DIV;}
"%"	{return MOD;}
"!"	{return OPP;}
"scan"	{return SCAN;}
"graph" {return GRAPH;}
"accepts"	{return ACC;}
"_" {return TOREGEXP;}
"string"	{return STRING_T;}
"int"	{return INT_T;}
"print " {return PRINT;}
"det" {return DET;}
"min" {return MIN;}
"concat" {return CONCAT;}
"~" {return COMP;}

\".*\"	{char * text = malloc(strlen(yytext)+1);
			strcpy(text, yytext);
			yylval.s = text;
			return STRING;}

{number}	{yylval.i = strtol(yytext, NULL, 10); return INT;}

{word}	{ 	char * text = malloc(strlen(yytext)+1);
			strcpy(text, yytext);
			yylval.s = text; return ID;
		}

	
%%

int yywrap(void) {
	return 1;
}
