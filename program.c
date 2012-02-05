#include <stdio.h>

#define MAX 500
#define LENGTH(x) (sizeof(x)/sizeof(*(x)))

struct {
  int dispatch[52];
  char symbol[MAX];
  char next[MAX];
} symbol_table;

void init_symbol_table(void);
int next_symbol(char *);
int find_first_empty(char *, int);  
void print_table(char *, int);  
void create (char *);

int main(int argc, char *argv[]) {

  init_symbol_table();
  //while(yylex()) {}
  create("bool");
  //create("boolean");
  print_table(symbol_table.symbol, LENGTH(symbol_table.symbol));
  return 0;
}

/* initialize the symbol table */
void init_symbol_table(void) {
  int i;
  for (i = 0; i < 52; i++)
    symbol_table.dispatch[i] = 0;
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

void create (char *s) {
  int value = next_symbol(s); 
  int ptr = symbol_table.dispatch[ value ];
  
  if (ptr == 0) {
    
    // find the location of prefix in dispatch table
    int slot = find_first_empty(symbol_table.symbol, LENGTH(symbol_table.symbol));
    symbol_table.dispatch[value] = slot;
    int next_slot = slot;     // to be used for next table
    
    // store the rest of characters to symbol table
    int i = 1;
    while (i < strlen(s)) 
      symbol_table.symbol[slot++] = s[i++];

    symbol_table.symbol[slot] = '@';
    symbol_table.next[next_slot] = ++slot;

  } else {

  }
}

int find_first_empty(char *array, int size) {
  int i; 
  for (i = 0; i < size; i++) 
    if (array[i] == '\0') 
      return i;
}

void print_table(char *table, int size) {
  int i; 
  for (i = 0; i < size; i++) 
    printf("%c ", table[i]);
}