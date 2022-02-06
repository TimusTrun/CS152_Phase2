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
%token <sval> IDENT
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
%left MOD
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


Program: Functions {printf("Program -> Functions\n");};

Functions: %empty {printf("Functions -> epsilon\n");}
    | Function Functions {printf("Functions -> Function Functions\n");};

Identifier: IDENT {printf("ident -> IDENT \n");};
Identifiers: Identifier {printf("Identifiers -> Identifier\n");};

Function: FUNCTION Identifier SEMI BEGINPARAMS Declarations ENDPARAMS BEGINLOCALS Declarations ENDLOCALS BEGINBODY Statements ENDBODY
          {printf("Functions -> FUNCTION Identifier ';' BEGINPARAMS Declarations ENDPARAMS BEGINLOCALS Declarations ENDLOCALS BEGINBODY Statements ENDBODY\n");};

Declarations: %empty {printf("Declarations -> epsilon\n");}
        | Declaration SEMI Declarations {printf("Declarations -> Declaration ';' Declarations\n");} ;

Declaration: Identifiers COLON INTEGER { printf("Declaration -> Identifier ':' INTEGER\n"); }
           | Identifiers COLON ARRAY LBRACKET NUMBER RBRACKET OF INTEGER { printf("Declaration -> Identifier ':' ARRAY '[' INT ']' OF INTEGER");};

Statements: Statement SEMI Statements {printf("Statements -> Statement ';' Statements\n");};
          | %empty {printf("Statements -> epsilon\n");};

Statementss: ELSE Statements {printf("Statementss -> ELSE Statements\n");};
        | %empty {printf("Statementss -> epsilon\n");};
>>>>>>> 408b6962ac7e7c079a9527696a4a232eb49846b4

Statement: Var ASSIGN Expression {printf("Statement -> Var ':=' Expression\n");}
         | IF Bool_Exp THEN Statements Statementss ENDIF {printf("Statement -> IF Bool_Exp THEN Statements Statementss ENDIF\n");};
         | WHILE Bool_Exp BEGINLOOP Statements ENDLOOP {printf("Statement -> WHILE Bool_Exp BEGINLOOP Statements ENDLOOP\n");};
         | DO BEGINLOOP Statements ENDLOOP WHILE Bool_Exp {printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE Bool_Exp\n");};
         | READ Var {printf("Statement -> READ Var\n");};
         | WRITE Var {printf("Statement -> WRITE Var\n");};
         | CONTINUE {printf("Statement -> CONTINUE\n");};
         | BREAK {printf("Statement -> BREAK\n");};
         | RETURN Expression {printf("Statement -> RETURN Expression\n");};


Bool_Exp: Expression Comp Expression {printf("Bool_Exp -> Bool_Exps Expression Comp Expression\n");};
        | NOT Bool_Exp{printf("BoolExp -> NOT BoolExp\n");};

Comp: EQ { printf("Comp -> '=='\n");};
    | NEQ { printf("Comp -> '<>'\n");};
    | LT  { printf("Comp -> '<'\n");};
    | GT  { printf("Comp -> '>'\n");};
    | LTE { printf("Comp -> '<='\n");};
    | GTE { printf("Comp -> '>='\n");};

Expression: Multiplicative_Expr {printf("Expression -> Multiplicative_Expr\n");};
          | Multiplicative_Expr ADD Expression {printf("Expression -> Multiplicative_Expr ADD Multiplicative_Exprs\n");};
          | Multiplicative_Expr SUB Expression {printf("Expression -> Multiplicative_Expr SUB Multiplicative_Exprs\n");};

Multiplicative_Expr: Term {printf("Multiplicative_Expr -> Term\n");}
                   | Multiplicative_Expr Term MULT Multiplicative_Expr {printf("Multiplicative_Expr -> Term '*' Multiplicative_Expr\n");};
                   | Multiplicative_Expr Term DIV Multiplicative_Expr {printf("Multiplicative_Expr -> Term '/' Multiplicative_Expr\n");};
                   | Multiplicative_Expr Term MOD Multiplicative_Expr {printf("Multiplicative_Expr -> Term '%'  Multiplicative_Expr\n");};

Term: Var {printf("Term -> Var\n");};
    | NUMBER {printf("Term -> NUMBER\n");};
    | LPAREN Expression RPAREN {printf("Term -> '(' Expression ')'\n");};
    | Identifier LPAREN Expression RPAREN {printf("Term -> Identifier '(' ')'\n");};
    | Identifier LPAREN Expression COMMA RPAREN {printf("Term -> Identifier '(' Expressions ')'\n");};
    | Identifier LPAREN RPAREN {printf("Term -> '(' ')''\n");};

Var: Identifier { printf("Var -> Identifier\n");};
   | Identifier LBRACKET Expression RBRACKET { printf("Var -> dentifier '[' Expression ']'\n");};

%% 

int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
}
