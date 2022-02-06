 /* cs152-phase1*/

%{   
   #include "miniL-parser.h"
   int row= 1;
   int column = 1;
%}


   /* some common rules, for example DIGIT */
DIGIT       [0-9]
LETTER      [a-zA-Z]

IDENTIFIER  ({LETTER})({LETTER}|{DIGIT}|"_")*
START       ({DIGIT}|"_")+{IDENTIFIER}
END         {IDENTIFIER}+("_")
WHITESPACE  [\s\S\t\T ]
COMMENT     ##.*


%%
   /* specific lexer rules in regex */
{WHITESPACE}+  {} 
{COMMENT}      {} 
"\n"           {}
"="            {return '=';}
"function"     {return FUNCTION;}
"beginparams"  {return BEGINPARAMS;}
"endparams"    {return ENDPARAMS;}
"beginlocals"  {return BEGINLOCALS;}
"endlocals"    {return ENDLOCALS;}
"beginbody"    {return BEGINBODY;}
"endbody"      {return ENDBODY;}
"integer"      {return INTEGER;}
"array"        {return ARRAY;}
"of"           {return OF;}
"if"           {return IF;}
"then"         {return THEN;}
"endif"        {return ENDIF;}
"else"         {return ELSE;}
"while"        {return WHILE;}
"do"           {return DO;}
"beginloop"    {return BEGINLOOP;}
"endloop"      {return ENDLOOP;}
"continue"     {return CONTINUE;}
"break"        {return BREAK;}
"read"         {return READ;}
"write"        {return WRITE;}
"not"          {return NOT;}
"true"         {return TRUE;}
"false"        {return FALSE;}
"return"       {return RETURN;}
"-"            {return SUB;}
"+"            {return ADD;}
"*"            {return MULT;}
"/"            {return DIV;}
"%"            {return MOD;}
"=="           {return EQ;}
"<>"           {return NEQ;}
"<"            {return LT;}
">"            {return GT;}
"<="           {return LTE;}
">="           {return GTE;}
{DIGIT}+       {yylval.ival = atoi(yytext); return NUMBER;}
{START}+       {printf("Error at line %i, column %i: identifier \"%s\" must begin with a letter", row, column, yytext); exit(0);} //fix?
{END}+         {printf("Error at line %i, column %i: identifier \"%s\" cannot end with an underscore", row, column, yytext); exit(0);} //fix?
{IDENTIFIER}+  {return IDENT;}
";"            {return SEMI;}
":"            {return COLON;}
","            {return COMMA;}
"("            {return LPAREN;}
")"            {return RPAREN;}
"["            {return LBRACKET;} 
"]"            {return RBRACKET;}
":="           {return ASSIGN;}

.              {printf("ERROR\n"); exit(1);}

%%
	/* C functions used in lexer */
