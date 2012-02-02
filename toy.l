%{
  #define MAX_LENGTH      10
  #define MAX             100

  #include <stdio.h>
  #include <string.h>

  struct {
    char name[MAX_LENGTH];
    int type;
  }table[MAX];

  int yylval;

  // Toy language specific
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
%}

letter  [a-zA-Z]
digit   [0-9]
id      {letter}({letter}|{digit})*
number  {digit}+
ws      [\t\n]

%%

bool        { printf("%s ", yytext); return (t_bool); } 
break       { printf("%s ", yytext); return (t_break); }
class       { printf("%s ", yytext); return (t_class); } 
double      { printf("%s ", yytext); return (t_double); }
else        { printf("%s ", yytext); return (t_else); } 
extends     { printf("%s ", yytext); return (t_extends); } 
for         { printf("%s ", yytext); return (t_for); } 
if          { printf("%s ", yytext); return (t_if); }
implements  { printf("%s ", yytext); return (t_implements); } 
int         { printf("%s ", yytext); return (t_int); } 
interface   { printf("%s ", yytext); return (t_interface); } 
newarray    { printf("%s ", yytext); return (t_newarray); } 
println     { printf("%s ", yytext); return (t_println); } 
readln      { printf("%s ", yytext); return (t_readln); }
return      { printf("%s ", yytext); return (t_return); }
string      { printf("%s ", yytext); return (t_string); }
void        { printf("%s ", yytext); return (t_void); } 
while       { printf("%s ", yytext); return (t_while); }

"+"         { printf("plus "); return(t_plus); }
"-"         { printf("minus "); return(t_minus); }
"*"         { printf("multiplication "); return(t_multiplication); }
"/"         { printf("division "); return(t_division); }
"%"         { printf("mod "); return(t_mod); }
"<"         { printf("less "); return(t_less); }
"<="        { printf("lessequal "); return(t_lessequal); }

","         { printf("comma "); return(t_comma); }
";"         { printf("semicolon "); return(t_semicolon); }


%%

int main() {
  while(yylex()) {}
}
