SCRIPT=../../script/sdif

all: index.md

index.md: $(SCRIPT) HEAD.inc Makefile
	cat HEAD.inc > $@
	cat < $(SCRIPT) | \
	pod2markdown | sed 's/^#/##/' >> $@
