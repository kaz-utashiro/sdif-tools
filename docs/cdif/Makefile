SCRIPT=../../script/cdif

all: index.md

index.md: $(SCRIPT) HEAD.inc Makefile
	cat < HEAD.inc > $@
	echo >> $@
	cat < $(SCRIPT) | pod2markdown | sed 's/^#/##/' >> $@
