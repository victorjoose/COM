#!/bin/bash
flex --noyywrap trabalho.lex
gcc lex.yy.c -lfl -o trabalho
./trabalho