# CFLAGS=-Wall -g -I

# # this is a comment

# all:
# 	gcc -I/Users/yippee/vsCodeWorkspace/C  program_one.c  -o program_one

# clean:
# 	rm -f program_one.o program_one 

# Specify the target executable
target: program_one.o
	gcc program_one.o -o target

# Compile program_one.c into program_one.o
program_one.o: program_one.c program_one.h
	gcc -c program_one.c -o program_one.o

# Clean the generated files
clean:
	rm -f target program_one.o