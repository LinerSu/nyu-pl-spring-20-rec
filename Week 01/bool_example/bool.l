%{
#include <iostream>
#include <stdlib.h>
#include "bool.tab.h"  /* We want the tokens defined in bool.y. */
%}

%option noyywrap

%%

"TRUE"                  { yylval.val = true; return BOOL; }
"FALSE"                 { yylval.val = false; return BOOL; }
"&&"                    { return AND; }
"||"                    { return OR; }
"!"                     { return NOT; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
[ \t\r\n]+              { /* Ignore white characters. */ }
.                       { std::cerr << "Invalid token" << std::endl; exit(1); }

%%
