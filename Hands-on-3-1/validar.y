%{
#include <stdio.h>
#include <stdlib.h>
int yyerror(char *s);  // Declaración de yyerror
int yylex(void);       // Declaración de yylex
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input: /* vacío */
     | input expr '\n' { printf("Expresión válida\n"); }
     | input error '\n' { yyerror("Expresión inválida"); yyerrok; }
     ;

expr: expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '-' expr %prec UMINUS
    | '(' expr ')'
    | NUMBER
    ;

%%

int yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main() {
    printf("Ingresa expresiones (Ctrl+D para salir):\n");
    while (yyparse() == 0) {
        // Continúa procesando hasta que se reciba EOF (Ctrl+D)
    }
    return 0;
}