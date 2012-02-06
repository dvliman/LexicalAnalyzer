%{
  #include <stdio.h>
  #include <string.h>

  int yylval;

  // Tokens for Toy language
  #define t_bool            1000
  #define t_break           1001
  #define t_class           1002
  #define t_double          1003
  #define t_else            1004
  #define t_extends         1005
  #define t_for             1006
  #define t_if              1007
  #define t_implements      1008
  #define t_int             1009
  #define t_interface       1010
  #define t_newarray        1011
  #define t_println         1012
  #define t_readln          1013
  #define t_return          1014
  #define t_string          1015
  #define t_void            1016
  #define t_while           1017
  #define t_plus            1018
  #define t_minus           1019
  #define t_multiplication  1020
  #define t_division        1021
  #define t_mod             1022
  #define t_less            1023
  #define t_lessequal       1024
  #define t_greater         1025
  #define t_greaterequal    1026
  #define t_equal           1027
  #define t_notequal        1028
  #define t_assignop        1029  
  #define t_semicolon       1030  
  #define t_comma           1031
  #define t_period          1032
  #define t_leftparen       1033
  #define t_rightparen      1034
  #define t_leftbracket     1035
  #define t_rightbracket    1036
  #define t_leftbrace       1037
  #define t_rightbrace      1038
  #define t_boolconstant    1039
  #define t_intconstant     1040
  #define t_doubleconstant  1041
  #define t_stringconstant  1042
  #define t_id              1043
  
  #define MAX 150
  #define LENGTH(x) (sizeof(x)/sizeof(*(x)))
  #define true 1 
  #define false 0

  struct {
    int dispatch[52];
    char symbol[MAX];
    int next[MAX];
  } symbol_table;

  void init_symbol_table(void);
  int next_symbol(char *);
  int find_first_empty(char *, int);
  void print_switch(int *, int);    
  void print_symbol(char *, int);  
  void print_next(int *, int);  
  void insert(char *);
  
%}

hex         (0x|0X)[0-9A-Fa-f]*+
letter      [a-zA-Z]
digit       [0-9]
newline     [\n]
ws          [ \t]+
string      \"[^"\n]*\"
exponent    ((E|e)("+"|"-")?({digit}+))
float1      {digit}+"."{digit}+{exponent}?
float2      {digit}+{exponent}
double      ({float1}|{float2})
integer     {hex}|{digit}+
identifier  {letter}({letter}|{digit}|"_")*   
%%


"/*"(([^*]|(("*"+)[^*/]))*)("*"+)"/"\n {; /* multiline comment, skip it */ }
"//"((.)*)\n                           {; /* line comment, skip it */ }

bool        { printf("%s ", yytext); insert(yytext); return (t_bool); } 
break       { printf("%s ", yytext); insert(yytext); return (t_break); }
class       { printf("%s ", yytext); insert(yytext); return (t_class); } 
double      { printf("%s ", yytext); insert(yytext); return (t_double); }
else        { printf("%s ", yytext); insert(yytext); return (t_else); } 
extends     { printf("%s ", yytext); insert(yytext); return (t_extends); } 
for         { printf("%s ", yytext); insert(yytext); return (t_for); } 
if          { printf("%s ", yytext); insert(yytext); return (t_if); }
implements  { printf("%s ", yytext); insert(yytext); return (t_implements); } 
int         { printf("%s ", yytext); insert(yytext); return (t_int); } 
interface   { printf("%s ", yytext); insert(yytext); return (t_interface); } 
newarray    { printf("%s ", yytext); insert(yytext); return (t_newarray); } 
println     { printf("%s ", yytext); insert(yytext); return (t_println); } 
readln      { printf("%s ", yytext); insert(yytext); return (t_readln); }
return      { printf("%s ", yytext); insert(yytext); return (t_return); }
string      { printf("%s ", yytext); insert(yytext); return (t_string); }
void        { printf("%s ", yytext); insert(yytext); return (t_void); } 
while       { printf("%s ", yytext); insert(yytext); return (t_while); }

true|false  { printf("boolconstant "); return (t_boolconstant); } 

"+"         { printf("plus "); return(t_plus); }
"-"         { printf("minus "); return(t_minus); }
"*"         { printf("multiplication "); return(t_multiplication); }
"/"         { printf("division "); return(t_division); }
"<="        { printf("lessequal "); return(t_lessequal); }
">"         { printf("greater "); return (t_greater); }
">="        { printf("greaterequal "); return(t_greaterequal); }
"=="        { printf("equal "); return (t_equal); }
"!="        { printf("notequal "); return (t_notequal); }
"="         { printf("assignop "); return (t_assignop); }
";"         { printf("semicolon "); return(t_semicolon); }
","         { printf("comma "); return(t_comma); }
"."         { printf("period "); return(t_period); }
"("         { printf("leftparen "); return(t_leftparen); }
")"         { printf("rightparen "); return(t_rightparen); }
"["         { printf("leftbracket "); return(t_leftbracket); }
"]"         { printf("rightbracket "); return(t_rightbracket); }
"{"         { printf("leftbrace "); return(t_leftbrace); }
"}"         { printf("rightbrace "); return(t_rightbrace); }

{newline}       { printf("\n"); }
{integer}       { printf("intconstant "); return(t_intconstant); }
{double}        { printf("doubleconstant "); return(t_doubleconstant); }
{string}        { printf("stringconstant "); return(t_stringconstant); }
{identifier}    { printf("id "); insert(yytext); return(t_id); }
{ws}            {; /* ignore whitespace */ }
.               {; /* ignore bad characters */ }

%%

int yywrap(void) { return (1); }

int main(int argc, char *argv[]) {

  init_symbol_table();
  
  printf("\nTokens Output\n=============\n");
  while(yylex()) {}
  
  printf("\nSwitch Table\n============\n");
  print_switch(symbol_table.dispatch, LENGTH(symbol_table.dispatch));
   
  printf("\nSymbol Table\n============\n");
  print_symbol(symbol_table.symbol, LENGTH(symbol_table.symbol));
  
  printf("\nNext Table\n==========\n");
  print_next(symbol_table.next, LENGTH(symbol_table.next));
  
  printf("\n");
  return 0;
}

/* Initialize the symbol table */
void init_symbol_table(void) {
  int i;
  for (i = 0; i < 52; i++)
    symbol_table.dispatch[i] = -1;
  for (i = 0; i < MAX; i++)
    symbol_table.symbol[i] = '\0';
  for (i = 0; i < MAX; i++)
    symbol_table.next[i] = -1;
}

/* A B C ... Z  a b c ... z
   0 1 2     25 26 ...... 51 */
int next_symbol (char *s) {
  int p = s[0];
  if (p >= 97) return p - 97 + 26; 
  return p - 65;
}

/* Insert a string to the symbol table
 * if the string already exists, do nothing
 * iF the string does not exist, create it 
 * Store same prefixes once */
void insert (char *s) {
  int value = next_symbol(s); 
  int ptr = symbol_table.dispatch[ value ];
  
  // pointer is the first prefix string[0] previously stored in the symbol table
  // if pointer is undefined, create.
  if (ptr == -1) {
    
    // find the location of prefix in dispatch table
    int slot = find_first_empty(symbol_table.symbol, LENGTH(symbol_table.symbol));
    symbol_table.dispatch[value] = slot;    // update the pointer
    
    // store the rest of characters to symbol table
    int i = 1;
    while (i < strlen(s)) 
      symbol_table.symbol[slot++] = s[i++];
    symbol_table.symbol[slot] = '@';

  } else { 
  // pointer is defined, there are same prefixes. First char is skipped
    int exit = false;

    // keep traversing as long as prefix is same
    int i = 1;      // start with second character of input string
    int p = ptr;    // start index of same prefix in the symbol table
    while (i < strlen(s)) {
      if (s[i] == symbol_table.symbol[p]) {
        i++;
        p++;
      } else {
        exit = true; 
        break;
      }
    }
    
    // The Rest of character start to differ:
    //  1. either reached end marker
    //  2. or the character is different.
    if (exit == true) {
      // use the next table to jump to the right position to store data.
      int next;
      if (symbol_table.next[p] == -1)
        next = find_first_empty(symbol_table.symbol, LENGTH(symbol_table.symbol));
      else
        next = symbol_table.next[p];
          
      // update the next table
      symbol_table.next[p] = next;
      
      while (i < strlen(s)) 
        symbol_table.symbol[next++] = s[i++];
      symbol_table.symbol[next] = '@';
    }
  
    // If exit stays false until here, the input string is accepted. 
    // The exact same string has been stored before in the trie.
  }
}

/* Find the first empty slot in the symbol table */
int find_first_empty(char *array, int size) {
  int i; 
  for (i = 0; i < size; i++) 
    if (array[i] == '\0') 
      return i;
}

/* Print switch array */
void print_switch(int *table, int size) {
  char alphabets[52] = { 'A', 'B', 'C', 'D', 'E', 'F','G','H',
                         'I','J','K','L','M','N','O','P','Q',
                         'R','S','T','U','V','W','X','Y','Z', 
                         'a','b','c','d','e','f','g','h',
                         'i','j','k','l','m','n','o','p','q',
                         'r','s','t','u','v','w','x','y','z'};
  int i;
  printf(" ");
  for (i = 0; i < 52; i++)
    printf("%1c  ", alphabets[i]);
  printf("\n"); 
  for (i = 0; i < size; i++) 
    printf("%1d ", table[i]);
}

/* Print symbol array */
void print_symbol(char *table, int size) {
  int i; 
 
  for (i = 0; i < size; i++) 
    printf("%1d ", i); 
  printf("\n");
  for (i = 0; i < size; i++) 
    printf("%1c ", table[i]);
}

/* Print next array*/
void print_next(int *table, int size) {
  int i; 
   printf("Array Indices\n");
  for (i = 0; i < size; i++) 
    printf("%1d ", i);
  printf("\nContent:\n");
  for (i = 0; i < size; i++)
    printf("%1d ", table[i]);
}
