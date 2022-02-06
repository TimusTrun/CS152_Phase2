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



%start Program

%token INTEGER 
%token <ival> NUMBER
%token <sval> Identifier
%% 


Program: Functions Program {printf("Program -> Functions Program\n");} 
       | {printf("Program -> epsilon\n");}

Functions: FUNCTION Identifier ';' BEGINPARAMS Declarations ENDPARAMS BEGINLOCALS Declarations ENDLOCALS BEGINBODY Statements ENDBODY
          {printf("Functions -> FUNCTION Identifier ';' BEGINPARAMS Declarations ENDPARAMS BEGINLOCALS Declarations ENDLOCALS BEGINBODY Statements ENDBODY\n");} 

Declarations: Declaration ';' Declarations {printf("Declarations -> Declaration ';' Declarations\n");} 
            | {printf("Declarations -> epsilon\n");}

Declaration: Identifier ':' INTEGER { printf("Declaration -> Identifier ':' INTEGER\n"); }
           | Identifier ':' ARRARY '[' NUMBER ']' OF INTEGER { printf("Declaration -> Identifier ':' ARRARY '[' INT ']' OF INTEGER");}

Statements: Statement ';' Statements {printf("Statements -> Statement ';' Statements\n");}
          | {printf("Statements -> epsilon\n");}

Statement: Var ':=' Expression {printf("Statement -> Var ':=' Expression\n");}
         | IF Bool_Exp THEN Statements ENDIF {printf("Statement -> IF Bool_Exp THEN Statements ENDIF\n");}
         | IF Bool_Exp THEN Statements ELSE Statements ENDIF {printf("Statement -> IF Bool_Exp THEN Statements ELSE Statements ENDIF\n");}
         | WHILE Bool_Exp BEGINLOOP Statements ENDLOOP {printf("Statement -> WHILE Bool_Exp BEGINLOOP Statements ENDLOOP\n");}
         | DO BEGINLOOP Statements ENDLOOP WHILE Bool_Exp {printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE Bool_Exp\n");}
         | READ Var {printf("Statement -> READ Var\n");}
         | WRITE Var printf("Statement -> WRITE Var\n");}
         | CONTINUE printf("Statement -> CONTINUE\n");}
         | BREAK printf("Statement -> BREAK\n");}
         | RETURN Expression printf("Statement -> RETURN Expression\n");}

Comp: '==' { printf("Comp -> '=='\n");}
    | '<>' { printf("Comp -> '<>'\n");}
    | '<'  { printf("Comp -> '<'\n");}
    | '>'  { printf("Comp -> '>'\n");}
    | '<=' { printf("Comp -> '<='\n");}
    | '>=' { printf("Comp -> '>='\n");}

Var: Identifier { printf("Var -> Identifier\n");}
   | Identifier '[' Expression ']' { printf("Var -> dentifier '[' Expression ']'\n");}

%% 

int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
}