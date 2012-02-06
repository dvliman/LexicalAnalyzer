#include <stdio.h>
#include <string.h>

#define MAX 500
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
void print_carray(char *, int);  
void print_iarray(int *, int);  
void insert(char *);

int main(int argc, char *argv[]) {

  init_symbol_table();
  printf("Tokens Output\n=============\n");
  //while(yylex()) {}

  
  insert("boolean");
  insert("break");
  insert("extends");
  insert("a");
  insert("b");
  insert("A");
  insert("Babi");
  
  printf("Switch Table\n============\n");
  print_iarray(symbol_table.dispatch, LENGTH(symbol_table.dispatch));
   
  printf("\nSymbol Table\n============\n");
  print_carray(symbol_table.symbol, LENGTH(symbol_table.symbol));
  
  printf("\nNext Table\n==========\n");
  print_iarray(symbol_table.next, LENGTH(symbol_table.next));
  
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

/* Print chars array */
void print_carray(char *table, int size) {
  int i; 
  for (i = 0; i < size; i++) 
    printf("%c ", table[i]);
}

/* Print ints array */
void print_iarray(int *table, int size) {
  int i; 
  for (i = 0; i < size; i++) 
    printf("%d ", table[i]);
}
