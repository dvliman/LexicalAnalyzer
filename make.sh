#!/bin/bash 

if [ -e a.out ]; then
  rm a.out
fi

if [ -e lex.yy.cc ]; then
  rm lex.yy.c
fi

lex toy.l
cc lex.yy.c -ll
./a.out < input.toy
