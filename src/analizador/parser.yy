%skeleton "lalr1.cc" /* -*- C++ -*- */

%defines
%define api.parser.class {Parser}
%define api.token.constructor
%define api.value.type variant

%define parse.trace
%define parse.error verbose
%param { Driver& driver }


%code requires
{
   class Driver;
}

%{
   
   #include <string>
   #include <stdio.h>
   #include "driver.h"
   #include <iostream>
%}


/******* TERMINALES ********/
%token MAS"+" MENOS"-" POR"*" DIV"/" PARIZQ"(" PARDER")" PTOCOMA";" EVALUAR"EVALUAR"
%token <float> NUM "NUM"
%token FIN 0 "eof"

%left MAS MENOS
%left POR DIV
%precedence NEG 

/******* NO TERMINALES ********/
%type <float> Expr
%start Inicio;

%%

   Inicio 
      : Lista ;


   Lista
      : Lista "EVALUAR" "(" Expr ")" ";"
      {
         std::cout<< "El valor de la Expresion es: " << $4 << "\n";
      }
      | "EVALUAR" "(" Expr ")" ";"{
         std::cout<< "El valor de la Expesion es: " << $3 << "\n";
      }
   ;

   Expr 
      : Expr "+" Expr {
         $$ = $1 + $3;
      }
      | Expr "-" Expr {
         $$ = $1 - $3;
      }
      | Expr "*" Expr{
         $$ = $1 * $3;
      }
      | Expr "/" Expr{
         $$ = $1 / $3;
      }
      | "-" Expr %prec NEG{
         $$ = -$2;
      }
      | "NUM"
      {
         $$ = $1;
      }
      | "(" Expr ")"
      {
         $$ = $2;
      }
   ;
      
%%

void yy::Parser::error( const std::string& error){
  std::cout << error << std::endl;
}