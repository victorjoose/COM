%option noyywrap
%{
/* Para as funções atoi() e atof() */
#include <math.h>
#include <ctype.h>
void showError();
void valorInteiro();
void valorReal();
void palavraChave();
void identificador();
%}

/* Sessão DEFINIÇÔES   */

ID      [a-z][a-z0-9]*
NUM     [0-9]+
int     []
void    []
if      []
while   []
return  []


%%

{NUM}+                                       {valorInteiro();}

{NUM}+"."{NUM}*                           	 {valorReal();}

if|then|begin|end|procedure|function         {palavraChave();}

{ID}                                         {identificador();}

"+"|"-"                                 	printf("Operador de soma: %s\n", yytext);
"*"|"/"										printf("Operador de multiplicação: %s\n", yytext);
"<="|"<"|">"|">="|"=="|"!="					printf("Operador relacional: %s\n", yytext );

"{"[^}\n]*"}"                                 /* comentários*/
[ \t]+                                        /*espaços em branco*/
.                                             printf( "Caracter não reconhecido: %s\n", yytext );

%%

int main(int argc, char **argv) {
	++argv, --argc;
	if (argc > 0) {
    	yyin = fopen( argv[0], "r");
	} else {
		yyin = stdin;
	}
		
	yylex();    
	return 0;
}

void valorInteiro() {

	int len;
	len = strlen(yytext);

	for(int i=0; i<=len; i++) {
		if(!isdigit(yytext[i])) {
			printf("identificador dentro do numero");
			printf("Um identificador: %s\n", yytext);
			return;
		}
	}
	
	printf("Um valor inteiro: %s (%d)\n", yytext, atoi(yytext));

}

void valorReal() {
	printf("Um valor real: %s (%g)\n", yytext, atof(yytext));
}

void palavraChave() {
	printf("Uma palavra-chave: %s\n", yytext);
}

void identificador() {
	printf("identificador de verdade");
	printf("Um identificador: %s\n", yytext);
}

void showError() {
	printf("Caracter desconhecido");
}