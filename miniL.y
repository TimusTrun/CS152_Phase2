    /* cs152-miniL phase2 */
%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *msg);
%}



%union{
  int ival;
  char *sval;
  float fval;
  struct T *tval;
  /* put your types here */
}

%error-verbose
%locations

/* lower predence */
%right  '='       /* A = (B = C)   */
%left   '+' '-'   /* (A op B) op C */
%left   '*' '/'   /* A op (B op C) */
%nonassoc UMINUS

/* higher precedence */



%start S

%token INTEGER
%token <ival> INT
%type <ival> S
%type <sval> Identifier
%% 

S: INT '+' INT {
  printf("In parser: %d + %d\n", $1, $3);
}

Declaration: Identifier ':' INTEGER
           | Identifier ':' ARRARY '[' INT ']' OF INTEGER

E : E '+' E
  | E '-' E
  | E '*' E
  | E '/' E
  | '-' E %prec UMINUS
  | INT
  | '(' E ')'
  ;

%% 

int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
}