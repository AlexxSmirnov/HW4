DIGIT 					[0-9]
ID  					[A-Za-z_][A-Za-z0-9_]*
SPACES					[ |\f|\n|\r|\t|\v]
OPERATOR_ARIFMETIC		\+|\-|\*|\/|\%
OPERATOR_COMPARE		==|!=|>|>=|<|<=
OPERATOR_BOOLEAN		&&|\|\|
KW				skip|write|read|if|then|else|do|while


%{
#pragma GCC diagnostic ignored "-Wformat"


int pos = 0, numStr = 1;
#define printToken(type, text, len) { printf("%s(%s,%d,%d,%d)\n", type, text, numStr, pos, pos + len - 1); pos += len;}
#define printSymbol(type, len) { printf("%s(%d,%d,%d)\n", type, numStr, pos, pos + len - 1); pos += len;}
#define printError(type, text, len) { printf("%s(%s,%d,%d,%d)\n", type, text, numStr, pos, pos + len - 1); pos += len;}	
#define printEOF() {printf("EOF "); yyterminate();}


#define NUM				"Num"
#define KW 				"KW"
#define OP_A 			"Operator_arifmetic"
#define OP_C			"Operator_compare"
#define OP_B 			"Operator_boolean"
#define VARIABLE		"Var"
#define COLON 			"Colon"
#define ASSIGN			"Assign"
#define ERROR	    	"Err"
#define OPEN_BRACKET 	"Open_bracket"
#define CLOSE_BRACKET 	"Close_bracket"
%}
%Start out_com in_com
%%

0{DIGIT}+|{DIGIT}+{ID}			printError(ERROR, yytext, yyleng);						
{DIGIT}+						printToken(NUM, yytext, yyleng);			
{KW}							printToken(KW, yytext, yyleng);			
:=								printSymbol(ASSIGN, yyleng);			
{ID} 							printToken(VARIABLE, yytext, yyleng);			
{OPERATOR_ARIFMETIC}			printToken(OP_A, yytext, yyleng);
{OPERATOR_BOOLEAN}				printToken(OP_B, yytext, yyleng);
{OPERATOR_COMPARE}				printToken(OP_C, yytext, yyleng);	
\(								printSymbol(OPEN_BRACKET, yyleng);			
\)								printSymbol(CLOSE_BRACKET, yyleng);
\;								printSymbol(COLON, yyleng);		
\n 								{ numStr++; pos = 0;}				
<<EOF>>							yyterminate();
{SPACES}						{};
.								printError(ERROR, yytext, yyleng);

%%

int main(int argc, char** argv)
{
	if (argc > 1)
	{
		if (!(yyin = fopen(argv[1], "r"))) 
		{
			printf("File not open: %s\n", argv[1] );
			yyterminate();
		}
	}
	else
	{
		printf("Missing file name\n");
		yyterminate();
	}
	yylex();
}