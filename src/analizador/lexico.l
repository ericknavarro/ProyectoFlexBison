%{
  #include <stdio.h>
  #include <string>
  #include "driver.h"
  #include "parser.tab.hh"
%}

%option noyywrap nounput batch debug noinput
%option outfile="scanner.cc" 

DIGIT   [0-9]
NUM     {DIGIT}+("."{DIGIT}+)?

%%

{NUM}           {return yy::Parser::make_NUM(strtol (yytext, NULL, 10));}
"evaluar"       {return yy::Parser::make_EVALUAR();}
"+"		          {return yy::Parser::make_MAS();}
"-"		          {return yy::Parser::make_MENOS();}
"*"		          {return yy::Parser::make_POR();}
"/"		          {return yy::Parser::make_DIV();}
"("		          {return yy::Parser::make_PARIZQ();}
")"		          {return yy::Parser::make_PARDER();}
";"		          {return yy::Parser::make_PTOCOMA();}

[[:blank:]]     {}
.               {printf("Caracter no reconocido: %s\n",yytext);}
<<EOF>>		      {return yy::Parser::make_FIN();}
%%

void Driver::runScanner(){
  yy_flex_debug = false;
  if(file.empty() || file == "-"){
    printf("No se encuentra el archivo de entrada");
    exit(1);
  }else{
    yyin = fopen (file.c_str (), "r");
    if(yyin == NULL){
		  printf("El archivo no existe");
		  exit(1);
	  }
  }
}

void Driver::closeFile(){
  fclose(yyin);
}