while (exit != true) {
  
  // traverse thru both prefixes while they are the same
  int i = 1;
  if ( s[i] == symbol_table.symbol[slot] ) {
    if (symbol_table.symbol[slot] != '@') {
      i++;
    }
    slot++;
  }
  // prefixes are not the same, store the rest chars to available position
  else if () {
  
  }
  
  
  
  if (exit == true) {
    
    // find empty slot in symbol table, store it there, update pointer
    if (symbol_table.symbol[ptr] == '@') {
      int start = symbol_table.next[ptr];
      
      while (symbol_table.next[start] != '-1')
        start = symbol_table.next[start];
      
      int next_start = start;
      while (i < strlen(s))
        symbol_table.symbol[start++] = s[i++];
      
      symbol_table.symbol[start] = '@';
      symbol_table.next[next_start] = ++start;  
    }
  }