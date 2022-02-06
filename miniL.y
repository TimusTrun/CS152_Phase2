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
%nonassoc UMINUS

/* higher precedence */



%start Program

%token <ival> NUMBER
%token <sval> Identifier

%token Terms
%token INTEGER 
%token FUNCTION
%token BEGINPARAMS
%token ENDPARAMS
%token BEGINLOCALS
%token ENDLOCALS
%token BEGINBODY
%token ENDBODY
%token ARRAY
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token WHILE
%token DO
%token BEGINLOOP
%token ENDLOOP
%token CONTINUE
%token BREAK
%token READ
%token WRITE
%right NOT
%token TRUE
%token FALSE
%token RETURN


%left SUB 
%left ADD
%left MULT 
%left DIV
%left EQ
%left NEQ
%left LT
%left GT
%left LTE
%left GTE


%token LPAREN
%token RPAREN
%token LBRACKET
%token RBRACKET
%token COLON
%token SEMI
%token COMMA
%left ASSIGN
%% 


Program: Functions Program {printf("Program -> Functions Program\n");} 
       | {printf("Program -> epsilon\n");}

Functions: FUNCTION Identifier SEMI BEGINPARAMS Declarations ENDPARAMS BEGINLOCALS Declarations ENDLOCALS BEGINBODY Statements ENDBODY
          {printf("Functions -> FUNCTION Identifier ';' BEGINPARAMS Declarations ENDPARAMS BEGINLOCALS Declarations ENDLOCALS BEGINBODY Statements ENDBODY\n");} 

Declarations: Declaration SEMI Declarations {printf("Declarations -> Declaration ';' Declarations\n");} 
            | {printf("Declarations -> epsilon\n");}

Declaration: Identifier COLON INTEGER { printf("Declaration -> Identifier ':' INTEGER\n"); }
           | Identifier COLON ARRAY '[' NUMBER ']' OF INTEGER { printf("Declaration -> Identifier ':' ARRAY '[' INT ']' OF INTEGER");}

Statements: Statement SEMI Statements {printf("Statements -> Statement ';' Statements\n");}
          | {printf("Statements -> epsilon\n");}

Statement: Var ASSIGN Expression {printf("Statement -> Var ':=' Expression\n");}
         | IF Bool_Exp THEN Statements Statementss ENDIF {printf("Statement -> IF Bool_Exp THEN Statements Statementss ENDIF\n");}
         | WHILE Bool_Exp BEGINLOOP Statements ENDLOOP {printf("Statement -> WHILE Bool_Exp BEGINLOOP Statements ENDLOOP\n");}
         | DO BEGINLOOP Statements ENDLOOP WHILE Bool_Exp {printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE Bool_Exp\n");}
         | READ Var {printf("Statement -> READ Var\n");}
         | WRITE Var {printf("Statement -> WRITE Var\n");}
         | CONTINUE {printf("Statement -> CONTINUE\n");}
         | BREAK {printf("Statement -> BREAK\n");}
         | RETURN Expression {printf("Statement -> RETURN Expression\n");}

Statementss: ELSE Statements {printf("Statementss -> ELSE Statements\n");}
        | {printf("Statementss -> epsilon\n");}
Bool_Exp: Bool_Exps Expression Comp Expression {printf("Bool_Exp -> Bool_Exps Expression Comp Expression\n");} 

Bool_Exps: NOT Bool_Exps {printf("Bool_Exps -> NOT Bool_Exps\n");}
         | {printf("Bool_Exps -> epsilon\n");}}

Comp: EQ { printf("Comp -> '=='\n");}
    | NEQ { printf("Comp -> '<>'\n");}
    | LT  { printf("Comp -> '<'\n");}
    | GT  { printf("Comp -> '>'\n");}
    | LTE { printf("Comp -> '<='\n");}
    | GTE { printf("Comp -> '>='\n");}

Expression: Multiplicative_Expr {printf("Expression -> Multiplicative_Expr\n");}
          | Multiplicative_Expr Multiplicative_Exprs {printf("Expression -> Multiplicative_Expr Multiplicative_Exprs\n");}

Expressions: ',' Expressions {printf("Expressions -> ',' Expressions\n");}
           | {printf("Expressions -> epsilon\n");}

Multiplicative_Expr: Term {printf("Multiplicative_Expr -> Term\n");}
                   | Term Terms {printf("Multiplicative_Expr -> Term Terms\n");}

Multiplicative_Exprs: '+' Multiplicative_Exprs {printf("Multiplicative_Exprs -> '+' Multiplicative_Exprs\n");}
                    | '-' Multiplicative_Exprs {printf("Multiplicative_Exprs -> '-' Multiplicative_Exprs\n");}
                    | {printf("Multiplicative_Exprs -> epsilon\n");}

Term: Var {printf("Term -> Var\n");}
    | NUMBER {printf("Term -> NUMBER\n");}
    | '(' Expression ')' {printf("Term -> '(' Expression ')'\n");}
    | Identifier '(' ')' {printf("Term -> Identifier '(' ')'\n");}
    | Identifier '(' Expressions ')' {printf("Term -> Identifier '(' Expressions ')'\n");}

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