BINDIR=bin
OBJDIR=obj
SRCDIR=src
TESTDIR=tests

BIN=$(BINDIR)/cpps
OBJ=$(OBJDIR)/*.o
CFILES=$(SRCDIR)/*.c

CC=gcc
CFLAGS=-g -pedantic -Wall


debug: build compile

release: CFLAGS=-O2 -Wall
release: build compile


compile: $(BIN)
$(BIN) : $(OBJ)
	$(CC) -o $(BIN) $(OBJ)

build: $(OBJ)
$(OBJ) : $(CFILES)
	$(CC) -c $(CFILES) $(CFLAGS)

	@mkdir -p $(OBJDIR)
	@mkdir -p $(BINDIR)
	@mv *.o $(OBJDIR)/


test: $(TESTDIR)/bin/test
$(TESTDIR)/bin/test: $(TESTDIR)/*.o
	$(CC) -o $(TESTDIR)/bin/test $(TESTDIR)/*.o

$(TESTDIR)/*.o: $(TESTDIR)/src/*.c $(SRCDIR)/functions.c $(SRCDIR)/functions.h $(SRCDIR)/commands.c $(SRCDIR)/commands.h
	$(CC) -c $(TESTDIR)/src/*.c $(SRCDIR)/functions.c $(SRCDIR)/functions.h $(SRCDIR)/commands.c $(SRCDIR)/commands.h $(CFLAGS)

	@mv *.o $(TESTDIR)/


clean:
	rm -f $(OBJ) $(BINDIR)/*

clean-test:
	rm -f $(TESTDIR)/bin/* $(TESTDIR)/*.o $(TESTDIR)/*.c
	rm -f $(TESTDIR)/NewProject/Makefile $(TESTDIR)/NewProject/src/*.c
	rmdir $(TESTDIR)/testproject/bin $(TESTDIR)/testproject/src $(TESTDIR)/testproject
	rmdir $(TESTDIR)/NewProject/bin $(TESTDIR)/NewProject/src $(TESTDIR)/NewProject
	rm -f $(TESTDIR)/Makefile

distclean: clean
	rmdir $(OBJDIR)/ $(BINDIR)
	rm -f C-Programming-Project-Setup-0.1.1-alpha.2-mingw32-release.tar
	rm -f C-Programming-Project-Setup-0.1.1-alpha.2-mingw32-debug.tar
	rm -f C-Programming-Project-Setup-0.1.1-alpha.2-mingw32-source.tar


tar-source:
	tar -cvf C-Programming-Project-Setup-0.1.1-alpha.2-mingw32-source.tar include/sput-1.4.0/* src/*.c .gitignore COPYING Makefile README.md

tar-release:
	tar -cvf C-Programming-Project-Setup-0.1.1-alpha.2-mingw32-release.tar bin/* COPYING README.md

tar-debug:
	tar -cvf C-Programming-Project-Setup-0.1.1-alpha.2-mingw32-debug.tar bin/* COPYING README.md


install:
	install -d ~/local/bin
	install -d ~/local/share/cpps
	install bin/cpps ~/local/bin
	install COPYING ~/local/share/cpps
	install README.md ~/local/share/cpps

uninstall:
	rm -fr ~/local/bin/cpps
	rm -fr ~/local/share/cpps/*
	rmdir ~/local/share/cpps


