 /* cs152-phase1*/
   
%{   
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
{WHITESPACE}+  {printf("");}
{COMMENT}      {printf("");}
"\n"           {row++; column = 1;}
"="            {printf("EQUAL\n"); column += yyleng;}
"function"     {printf("FUNCTION \n"); column += yyleng;}
"beginparams"  {printf("BEGIN_PARAMS \n"); column += yyleng;}
"endparams"    {printf("END_PARAMS \n"); column += yyleng;}
"beginlocals"  {printf("BEGIN_LOCALS \n"); column += yyleng;}
"endlocals"    {printf("END_LOCALS \n"); column += yyleng;}
"beginbody"    {printf("BEGIN_BODY \n"); column += yyleng;}
"endbody"      {printf("END_BODY \n"); column += yyleng;}
"integer"      {printf("INTEGER \n"); column += yyleng;}
"array"        {printf("ARRAY \n"); column += yyleng;}
"of"           {printf("OF \n"); column += yyleng;}
"if"           {printf("IF \n"); column += yyleng;}
"then"         {printf("THEN \n"); column += yyleng;}
"endif"        {printf("ENDIF \n"); column += yyleng;}
"else"         {printf("ELSE \n"); column += yyleng;}
"while"        {printf("WHILE \n"); column += yyleng;}
"do"           {printf("DO \n"); column += yyleng;}
"beginloop"    {printf("BEGINLOOPS \n"); column += yyleng;}
"endloop"      {printf("ENDLOOPS \n"); column += yyleng;}
"continue"     {printf("CONTINUE \n"); column += yyleng;}
"break"        {printf("BREAK \n"); column += yyleng;}
"read"         {printf("READ \n"); column += yyleng;}
"write"        {printf("WRITE \n"); column += yyleng;}
"not"          {printf("NOT \n"); column += yyleng;}
"true"         {printf("TRUE \n"); column += yyleng;}
"false"        {printf("FALSE \n"); column += yyleng;}
"return"       {printf("RETURN \n"); column += yyleng;}
"-"            {printf("SUB \n"); column += yyleng;}
"+"            {printf("ADD \n"); column += yyleng;}
"*"            {printf("MULT \n"); column += yyleng;}
"/"            {printf("DIV \n"); column += yyleng;}
"%"            {printf("MOD \n"); column += yyleng;}
"=="           {printf("EQ \n"); column += yyleng;}
"<>"           {printf("NEQ \n"); column += yyleng;}
"<"            {printf("LT \n"); column += yyleng;}
">"            {printf("GT \n"); column += yyleng;}
"<="           {printf("LTE \n"); column += yyleng;}
">="           {printf("GTE \n"); column += yyleng;}
{DIGIT}+       {printf("NUMBER %s\n", yytext); column += yyleng;}
{START}+       {printf("Error at line %i, column %i: identifier \"%s\" must begin with a letter", row, column, yytext); exit(0);}
{END}+         {printf("Error at line %i, column %i: identifier \"%s\" cannot end with an underscore", row, column, yytext); exit(0);}
{IDENTIFIER}+  {printf("IDENT %s\n", yytext); column += yyleng;}
";"            {printf("SEMICOLON \n"); column += yyleng;}
":"            {printf("COLON \n"); column += yyleng;}
","            {printf("COMMA \n"); column += yyleng;}
"("            {printf("L_PAREN \n"); column += yyleng;}
")"            {printf("R_PAREN \n"); column += yyleng;}
"["            {printf("L_SQUARE_BRACKET \n"); column += yyleng;} 
"]"            {printf("R_SQUARE_BRACKET \n"); column += yyleng;}
":="           {printf("ASSIGN \n"); column += yyleng;}

.              {printf("Error at line %i, column %i: unrecognized symbol \"%s\"\n",row, column, yytext); exit(0);}

%%
	/* C functions used in lexer */
