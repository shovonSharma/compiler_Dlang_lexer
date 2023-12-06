%{
 
#include<bits/stdc++.h>
using namespace std;

string x;

map<string,int>m;
int sc=0,mc=0,tv=0,hd=0,fl=0,wl=0,iv=0;

int count_of_identifiers = 0;
int count_of_keywords = 0;
int count_of_statements = 0;

void print(string comment, string message) {
    cout << "input : " << message << "\n";
		cout << "token : " << comment << "\n\n";
	}


%}


array       {var}[\[]{integer}[\]]

structure   "structure"[\{].*[\}][\;]


var            [a-zA-Z_][a-zA-Z_0-9]*

integer        [\+\-]?[0-9]+
real          (integer([\.]integer)?(E[\+\-]?integer)|integer([\.]integer))

boolean        "true"|"false"
char           [\'][^\n][\']
string         [\"].*[\"]

datatype       "integer"|"real"|"boolean"|"char"|"string"|"structure"



math_op    			(\+|\-|\*|\/|%)
assignment_op 				=
bitwise_op 			(&|\|\^|>>|<<)
increment_decrement_op 			("++"|"--")
comparison_op              ("EQUAL"|"NOTEQUAL"|<|>|<=|>=)
logical_op			("OR"|"AND"|"NOT"|"XOR")
assignment_init     \+=|\-=|\*=|\/=|%=
bitassign_init       &=|\|=|\^=|<<=|>>=

comma      ,
pass	          	("pass")
back              	("back")
break				("break")
comment       ("#")[^\n]*
multicomment  ("$#").*?("#$")
end_of_line   [\n]


if            		("if")[ ][\(].[\)][ ][\{].[\}]
elif            	("elif")[ ][\(].[\)][ ][\{].[\}]
else            	("else")[ ][\{].[\}]
if_condition		{if}[ ]{elif}?{else}?

forloop   			("for")[ ]{var}[ ]("in")[ ]({var}|{integer})(\.\.)({var}|{integer})[ ][\{].*[\}]
untilloop			("until")[ ][\(].[\)][ ][\{].[\}]
returntype			({datatype}|"void")
func				("func")[ ]{var}[ ][\(].[\)][ ][\(][ ]{returntype}[ ][\)][ ][\{].*[\}]

%%


{array} {
			string ss="";
			string ss2=yytext;
			int i=0;
			for(i=0;i<ss2.size();i++)
			{
				if(ss2[i]='[')break;
				ss+=ss2[i];
			}
			if(m[ss]==0)
			{
				x = yytext; print("array", x);
				m[ss]++;
				tv++;
			}
			else 
			{
				fprintf(yyout,"error! array declared twice.\n");
			}
	 }


{boolean}    		{x = yytext; print("boolean",  x);}
{pass}|{back}|{break} {x = yytext; print("keyword", x); count_of_keywords++;}
{end_of_line}				{x = yytext; print("end of statement", x); count_of_statements++;}
{logical_op}  		{x = yytext; print("logical_operator",  x);}
{comparison_op}      		{x = yytext; print("comparison operator",  x);}
{datatype}    		{x = yytext; print("datatype",  x); count_of_keywords++;}
{var}    	{
   {
			
			if(m[yytext]==0)
			{
				x = yytext; print("variable", x);
				m[yytext]++;
				tv++;
        count_of_identifiers++;
			}
			else 
			{
				fprintf(yyout,"ERROR! Same varriable twice.\n");
			}
	 }
   
  }
{string}    {x = yytext; print("string",  x);}
{integer}    		{x = yytext; print("integer",  x);}
{real}    {x = yytext; print("real number", x);}
{char} {x=yytext; print("character",x);}
{math_op}     		{x = yytext; print("math_op",  x);}
{assignment_op}      		{x = yytext; print("assignment operator",  x);}
{assignment_init}    		{x = yytext; print("operation with assignment",  x);}
{bitassign_init}  		{x = yytext; print("bitwise operator",  x);}
{bitwise_op}  		{x = yytext; print("bitwise operator",  x);}
{increment_decrement_op}    		{x = yytext; print("increment_decrement_operator",  x);}

{comma}       		{x = yytext; print("comma operator",  x);}

{if_condition}		{x = yytext; print("if condition", x); count_of_keywords++;}
{forloop}			{x = yytext; print("for loop", x);}
{untilloop}	 		{x = yytext; print("until loop", x);}

{func}			{x = yytext; print("function", x); count_of_keywords++;}

{comment}   {x=yytext;print("one line comment",x);}
{multicomment}			{x = yytext; print("multiline comment", x);}



%%

int yywrap()
{
	return 1;
}

int main()
{


 cout << "compiled...\n";

	yylex();
	

	cout << "Total identifiers found: " << count_of_identifiers << "\n";
	cout << "Total keywords found   : " << count_of_keywords << "\n";
	cout << "Total statements found: " << count_of_statements << "\n";

	return 0;
}
