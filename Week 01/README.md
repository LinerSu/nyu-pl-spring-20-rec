# Flex and Bison Tutorial

## Installation
**Mac:**

If you do not have installed homebrew, please do this following code in your terminal:
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
If you have installed homebrew, do those two commands in your terminal:
```bash
brew install flex # to install flex
brew install bison # to install bison
```
**Windows:**

Please find [this page](https://samskalicky.wordpress.com/2014/01/25/tutorial-setting-up-flex-bison-on-windows/) for the tutorial.

**Ubuntu Linux:**

Please find [this page](https://ccm.net/faq/30635-how-to-install-flex-and-bison-under-ubuntu) for the tutorial.

## Flex Scanner (*.l files)
**Skeleton(structure for a flex file):**
``` c++
%{
C/C++ declarations
%}

Flex declarations

%%
Token rules (Regular expression i.e. Regex)
%%
Additional C code
```

**Creating a Regex(regular expression):**

This is the syntax how to design regular expression:
```c++
%%
<regular expression>        {return <token>;}
  /*example*/
"+"                         {return PLUS;}
%%
```
## Bison Parser (*.y files)
**Skeleton(structure for a bison file):**
``` c++
%{
C declarations
%}

Bison declarations

%%
Grammar rules (BNF form)
%%

Additional C code
```

**Creating a grammar:**

This is the syntax that generates the grammars and tokens:

``` c++
/****** Start Symbol ****/
%start <start_symbol> /* put start symbol here*/
  /*example*/
%start prog

/****** Token ****/
%token <token_name> <token_name> ...
  /*example*/
%token PLUS NUM

/****** Grammar ****/
%%
  /*example*/
prog :  NUM PLUS NUM /* This is the same as CFG: prog -> NUM + NUM*/                   
     ;
%%
```
Don't forget to put the main function in your parser at the end of the file.

## How to run the program

Make sure you have make.sh, <file_name>.l and <file_name>.y in your folder. Run the following code on the terminal:
```
./make.sh <file_name>
./a.out
1 + 3
# click control + D to exit
```

## Exercise Questions
**Question 1:**

Design a regular expression for a language that accept all strings of lowercase letters containing the five english vowels (a,e,i,o,u) in order and each occurring exactly at once. For instance, a valid string is:
```
h a b e c i k o u m
```
and an invalid string is:
```
s a a a a b e
```
###### Answer:
Let C be the character class 
```
C = [b-df-hj-np-t-v-z]
```
Then we could generate regex like this:
```
C*aC*eC*iC*oC*uC*
```

**Question 2:**

Design a context-free grammar that accept this language:

<img src="http://latex.codecogs.com/svg.latex?\{  a^i b^j c^k | i,j,k \geq 0 \, and \, i+j=k \}" border="0"/>

###### Answer:
The idea is that the number of occurences of c must equal to the sum of the occurences for a and b. That is, when we design this grammar, we have to make sure the grammar contains a | b with c at the same time. Here is one possible solution:
```
S -> aSc | X
X -> aXb | ε
```

## Notes
1. If you plan to learn more about flex and bison, please see [this manual](http://web.iitd.ac.in/~sumeet/flex__bison.pdf).
2. Here is the [website](https://web.stanford.edu/class/archive/cs/cs103/cs103.1156/tools/cfg/) for testing the correctness of CFG.
3. Here is one [website](https://regex101.com/) for testing the correctness of regular expression.
