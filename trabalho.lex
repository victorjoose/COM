%option noyywrap
%{
/* Para as funções atoi() e atof() */
#include <math.h>
void showError();
%}

/* ===========================  Sessão DEFINIÇÔES  ========================== */

NUM     [0-9]+
ID      [a-z][a-z0-9]*

/*
int     []
void    []
if      []
while   []
return  []
programa declaracao_lista
declaracao_lista declaracao_lista declaracao | declaracao
declaracao var_declaracao | fun_declaracao
var_declaracao tipo_especificador ID; | tipo_especificador ID[NUM]
tipo_especificador int | void
fun_declaracao tipo_especificador ID(params) composto_decl
params params_lista | void
params_lista params_lista, param | param
param tipo_especificador ID | tipo_especificador ID[]
composto_decl {local_declaracoes statement_lista}
local_declaracoes local_declaracoes var_declaracao | vazio
statement_lista local_declaracoes var_declaracao | vazio
statement expressao_decl | composto_decl | selecao_decl | iteracao_decl | retorno_decl
expressao_decl expressao; | ;
selecao_decl if(expressao) statement | if(expressao) statement else statement
iteracao_decl while(expressao) statement
retorno_decl return; | return expressao;
expressao var = expressao | expressao_simples
var ID | ID[expressao]
simples_expressao ID | ID[expressao]
relacional <=|<|>|>=|==|!=
soma_expressao soma_expressao relacional soma_expressao | soma_expressao
soma + | -
termo termo mult fator | fator
mult * | /
fator (expressao) | var | ativacao | NUM
ativacao ID(args)
args args_lista | vazio
args_lista
*/

%%

{NUM}+                                       	{printf("Um valor inteiro: %s (%d)\n", yytext, atoi(yytext));}

{NUM}+"."{NUM}*                           		{printf("Um valor real: %s (%g)\n", yytext, atof(yytext));}

if|then|begin|end|procedure|function          {printf("Uma palavra-chave: %s\n", yytext);}

{ID}                                          printf("Um identificador: %s\n", yytext);

"+"|"-"                                 		  printf("Operador de soma: %s\n", yytext);
"*"|"/"											                  printf("Operador de multiplicação: %s\n", yytext);
"<="|"<"|">"|">="|"=="|"!="						        printf("Operador relacional: %s\n", yytext );

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

void showError() {
	printf("Caracter desconhecido");
}