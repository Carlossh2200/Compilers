%{
#include "validar.tab.h"
%}

%option noyywrap

%%

[0-9]+          { yylval = atoi(yytext); return NUMBER; }
"true"|"false"  { yylval = (strcmp(yytext, "true") == 0) ? 1 : 0; return BOOL; }
"AND"           { return AND; }
"OR"            { return OR; }
"NOT"           { return NOT; }
[ \t]           ;  /* Ignorar espacios y tabulaciones */
[\n]            { return '\n'; }
[+\-*/()]       { return yytext[0]; }
.               { return yytext[0]; }

<<EOF>>         { return 0; }

%%