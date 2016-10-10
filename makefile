all:
	gcc lex.yy.c -o main -lfl
clean:
	rm -rf *.o main
