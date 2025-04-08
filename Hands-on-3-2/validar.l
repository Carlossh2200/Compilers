%{
    #include "validar.tab.h"
%}

%option noyywrap

%%

"true"|"false"  { yylval = (strcmp(yytext, "true") == 0) ? 1 : 0; return BOOLEAN; }
"AND"           { return AND; }
"OR"            { return OR; }
"NOT"           { return NOT; }
[ \t]           ;  /* Ignorar espacios y tabulaciones */
[\n]            { return '\n'; }
[()]            { return yytext[0]; }
.               { return yytext[0]; }  /* Cualquier otro carácter se devuelve como está */
<<EOF>>         { return 0; }

%%