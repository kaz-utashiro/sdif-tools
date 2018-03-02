SCRIPT=../../script/watchdiff

index.md: $(SCRIPT) HEAD.md Makefile
	cat HEAD.md > $@
	cat < $(SCRIPT) | \
	pod2markdown >> $@
