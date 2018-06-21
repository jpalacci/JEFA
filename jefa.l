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
number	[-+]?{digit}+

%%
"auto" {return AUTO;}
"regexp" {return REGEXP;}
{ws}	{/* no action and no return */}
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
"=="	{return EQCOMP;}
"!="	{return NE;}
"<"	{return LT;}
"<="	{return LE;}
">"	{return GT;}
">="	{return GE;}
"+"	{return ADD;}
"-"	{return SUB;}
"*"	{return MUL;}
"/"	{return DIV;}
"%"	{return MOD;}
"!"	{return OPP;}
"string"	{return STRING_T;}
"int"	{return INT_T;}

\".*\"	{return STRING;}
{number}	{yylval.i = strtol(yytext, NULL, 10); return INT;}

{word}	{return ID;}

	
%%

int yywrap(void) {
	return 1;
}