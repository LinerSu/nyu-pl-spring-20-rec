%{
#include <iostream>

int yylex(); // A function that is to be generated and provided by flex,
             // which returns a next token when called repeatedly.
int yyerror(const char *p) { std::cerr << "error: " << p << std::endl; };
void printer (int val_par);
%}

%union { /* Declare the collection of data types that semantic values may have  */
    int val;
    /* You may need to include additional fields in here. */
};

%start prog // Grammar start symbol

%token LPAREN RPAREN
%token PLUS MINUS MUL DIV
%token <val> NUM    /* 'val' is the (only) field declared in %union
                       which represents the type of the token. */

/* Declare the type of semantic values for a nonterminal symbol */
%type <val> expr term factor

%%

prog : expr                             {printer($1);}
     ;

expr : expr PLUS term                   { $$ = $1 + $3; }
     | expr MINUS term                  { $$ = $1 - $3; }
     | term                             /* default action: { $$ = $1; } */
     ;

term : term MUL factor                  { $$ = $1 * $3; }
     | term DIV factor                  { $$ = $1 / $3; }
     | factor                           /* default action: { $$ = $1; } */
     ;

factor : NUM                            /* default action: { $$ = $1; } */                           
       | LPAREN expr RPAREN             { $$ = $2; }
       ;

%%

int main()
{
    yyparse(); // A parsing function that will be generated by Bison.
    return 0;
}

void printer (int val_par) {
    std::cout<< val_par <<std::endl;
}