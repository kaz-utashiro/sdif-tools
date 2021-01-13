SCRIPT=../../script/sdif

all: index.md

index.md: $(SCRIPT) HEAD.md Makefile
	cat HEAD.md > $@
	cat < $(SCRIPT) | \
	pod2markdown >> $@
