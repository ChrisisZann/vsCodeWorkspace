# CFLAGS=-Wall -g -I

# # this is a comment

# all:
# 	gcc -I/Users/yippee/vsCodeWorkspace/C  inner.c  -o inner

# clean:
# 	rm -f inner.o inner 

# Specify the target executable
target: inner.o
	gcc inner.o -o inner

# Compile inner.c into inner.o
inner.o: inner.c inner.h
	gcc -c inner.c -o inner.o

# Clean the generated files
clean:
	rm -f target inner.o