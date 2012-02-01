%{
#define MAX_LENGTH 100

%}
letter [a-zA-Z]
digit [0-9]
id {letter}({letter}|{digit})*
number {digit}+
ws [\t\n]
%%
{ws} ;
int   {printf("%s\n", yytext);}
float {printf("%s\n", yytext);}
%%
int main() {
  yylex();
}
