%{
  #include <stdio.h>
  #include <string>
  #include "driver.h"
  #include "parser.tab.hh"
%}

%option noyywrap 
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

void Driver::runScanner() {
  yy_flex_debug = false;
  yyin = fopen (file.c_str (), "r");
  if(yyin == NULL){
      printf("No se encontro el archivo de entrada");
      exit(1);
  }
}

void Driver::closeFile(){
  fclose(yyin);
}