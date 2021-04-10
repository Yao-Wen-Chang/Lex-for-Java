%{
#include<stdio.h>
#include<string.h>
unsigned charCount = 1, idCount = 0, lineCount = 1;
char symbolTable[100][100];
void create() {
    int i, j;
    for(i=0; i<100; i++)
        strcpy(symbolTable[i], "");
}

int lookup(char *s) {
    int i;
    for(i=0; i<idCount; i++) {
        if(strcmp(s, symbolTable[i]) == 0)
            return 1;             
    }
    return -1;
}
int insert(char *s) {
    strcpy(symbolTable[idCount], s);
    return idCount++;
}
void dump() {
    int i;

    printf("The symbol table contains:\n");
    for(i=0; i<idCount; i++)
        printf("%s\n", symbolTable[i]);

}
%}
operator (\+)|(\-)|(\*)|(\/)|(\=)|(\+\+)|(\-\-)|(\%)|(\<)|(\<\=)|(\>\=)|(\>)|(\=\=)|(\!\=)|(\&\&)|(\|\|)|(\!)
space [ \t]
eol \n
comment (\/\/.*)|(\/\*(.*\n)*.*\*\/)


/* You should write your own regular expression. */
reserved_word (boolean|break|byte|case|char|catch|class|const|continue|default|do|double|else|extends|false|final|finally|float|for|if|implements|int|long|main|new|print|private|protected|public|return|short|static|string|switch|this|true|try|void|while)
symbol [\,\:\;\(\)\[\]\{\}]
id [a-zA-Z_][a-zA-Z0-9_]* 
integer [-+]?[0-9]*
float [-+]?[0-9]*[.][0-9]+([eE][-+][0-9]+)*
string [\"][^"]*[\"]
%%
{comment} {
    charCount += yyleng;
}
{operator} {
	printf("Line: %d, 1st char: %d, \"%s\" is an \"operator\".\n", lineCount, charCount, yytext);
	charCount += yyleng;
}

{space} {
	charCount++;
}
{eol} {
	lineCount++;
	charCount = 1;
}
{reserved_word} {
    /* You shold write your own code */

    printf("Line: %d, 1st char: %d, \"%s\" is an \"reserved word\".\n", lineCount, charCount, yytext);
    charCount += yyleng;
}


{id} {
	/* You shold write your own code */
	printf("Line: %d, 1st char: %d, \"%s\" is an \"ID\".\n", lineCount, charCount, yytext);
    charCount += yyleng;
   
    int find = lookup(yytext);
    unsigned insertIndex = 0; 

    if(find == -1) {
        insertIndex = insert(yytext);
    }
}
{symbol} {
	/* You shold write your own code */
	printf("Line: %d, 1st char: %d, \"%s\" is an \"symbol\".\n", lineCount, charCount, yytext);
    charCount += yyleng;
}
{integer} {

	printf("Line: %d, 1st char: %d, \"%s\" is an \"integer\".\n", lineCount, charCount, yytext);
    charCount += yyleng;

}
{float} {

	printf("Line: %d, 1st char: %d, \"%s\" is an \"float\".\n", lineCount, charCount, yytext);
    charCount += yyleng;
}
{string} {
	printf("Line: %d, 1st char: %d, \"%s\" is an \"string\".\n", lineCount, charCount, yytext);
    charCount += yyleng;
}
%%

int main(){
    create();
	yylex();
	dump();
	return 0;
}

