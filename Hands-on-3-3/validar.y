%{
#include <stdio.h>
#include <stdlib.h>
int yyerror(char *s);
int yylex(void);
%}

%token NUMBER BOOL AND OR NOT

%left '+' '-'
%left '*' '/'
%left OR
%left AND
%right NOT

%%

input: /* vacío */
     | input expr '\n' { printf("Expresión válida\n"); }
     | input error '\n' { yyerror("Expresión inválida"); yyerrok; }
     ;

expr: expr '+' expr
    | expr '-' expr
    | expr AND expr
    | expr OR expr
    | NOT expr
    | term
    ;

term: term '*' term
    | term '/' term
    | factor
    ;

factor: '(' expr ')'
      | NUMBER
      | BOOL
      ;

%%

int yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main() {
    printf("Ingresa expresiones aritméticas/lógicas (Ctrl+D para salir):\n");
    while (yyparse() == 0) {
    }
    return 0;
}