# Tahalil Morsilin 
# Assignment8
# 03/15/2026
all: main

MYLIBS = libFunctions.o
CC = gcc

main: main.o $(MYLIBS)
	$(CC) $@.o $(MYLIBS) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@