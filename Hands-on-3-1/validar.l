%{
#include "validar.tab.h"
%}

%option noyywrap

%%

[0-9]+     { yylval = atoi(yytext); return NUMBER; }
[ \t]      ;  /* Ignorar espacios y tabulaciones */
[\n]       { return '\n'; }
[+\-*/()]  { return yytext[0]; }
.          { return yytext[0]; }

%%