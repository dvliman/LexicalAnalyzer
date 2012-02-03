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

Toy Language Specifications:
============================
1. Keywords, which means they cannot be used as identifiers or redefined:
    bool break class double else extends for if implements int  
    interface newarray println readln return string void while

2. An identifier is a sequence of letters, digits, and underscores, starting with a letter.
   Toy is case-sensitive, e.g., if is a keyword, but IF is an identifier;
   hello and Hello are two distinct identifiers.

3. White space consists of blanks, newlines, and tabs.  White space serves to separate tokens, but is otherwise is ignored. 
   Keywords and identifiers must be separated by white space or a token that
    is neither a keyword nor an identifier.
   For instance, ifintvoid is a single identifier, not three keywords;
    while if(23void scans as four tokens.

4. An integer constant can either be specified in decimal (base 10) or hexadecimal (base 16).
   A decimal integer is a sequence of decimal digits (0-9).
   A hexadecimal integer must begin with 0X or 0x (that is a zero, not the letter oh), 
    and is followed by a sequence of hexadecimal digits. 
   Hexadecimal digits include the decimal digits and the letters a through f
    (either upper or lowercase).
   Examples of valid integers: 8, 012, 0x0, 0X12aE.

5. A double constant is a sequence of at least one digit, a period, followed by:
    any sequence of digits, may be none.
   
   Thus, .12 is not a valid double but both 0.12 and 12. are valid.
   A double can also have an optional exponent, e.g., 12.2E+2
   
   For a double in this sort of scientific notation, the decimal point is required,
    the sign of the exponent is optional (if not specified, + is assumed), 
    and the E can be lower or upper case. As above, .12E+2 is invalid, but 12.E+2 is valid.
   Leading zeroes on the mantissa and exponent are allowed.

6. A string constant is a sequence of characters enclosed in double quotes.
   Strings can contain any character except a newline or double quote.
   A string must start and end on a single line, 
   it cannot be split over multiple lines.

7. A Boolean constant is either true or false.
   Like keywords, these words are reserved.

8. Operators and punctuation characters include:
    +   -   *   /   %   <   <=   >   >=   ==  
    !=   =   ;   ,   .   (   )   [   ]   {   }
  
9. A single-line comment is started by // and extends to the end of the line.  
   Multi-line comments start with /* and end with the first subsequent */.  
   Any symbol is allowed in comment except the sequence */ which ends current comment.
   Multi-line comments do not nest.

