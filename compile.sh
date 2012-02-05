#!/bin/bash 

if [ -e a.out ]; then
  rm a.out
fi

cc program.c
./a.out  
