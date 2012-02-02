Toy Language Parser: 
====================
  This is a Lexical Analyzer for "toy" programming language. 
  It tokenizes the source code and stores them into symbol table.

To run this program:
====================
  1. With bash script
     ./make.sh (sudo chmod+x make.sh if permission needed)

  2. Without bash script
     lex toy.l 
     cc lex.yy.c -ll 
     ./a.out < input.toy
