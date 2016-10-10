all:
	gcc lex.yy.c -o hw4 -lfl
clean:
	rm -rf *.o hw4
