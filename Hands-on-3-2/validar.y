%{
#include <stdio.h>
#include <stdlib.h>
int yyerror(char *s);  // Declaración de yyerror
int yylex(void);       // Declaración de yylex
%}

%token BOOLEAN AND OR NOT

%left OR
%left AND
%right NOT

%%

input: /* vacío */
     | input expr '\n' { printf("Expresión lógica válida\n"); }
     | input error '\n' { yyerror("Expresión lógica inválida"); yyerrok; }
     ;

expr: expr AND term
    | expr OR term
    | term
    ;

term: NOT factor
    | factor
    ;

factor: '(' expr ')'
      | BOOLEAN
      ;

%%

int yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main() {
    printf("Ingresa expresiones lógicas (Ctrl+D para salir):\n");
    while (yyparse() == 0) {
        // Continúa procesando hasta que se reciba EOF (Ctrl+D)
    }
    return 0;
}