SUBDIRS = cdif sdif watchdiff

.PHONY: all clean $(SUBDIRS)

all: index.md
	for dir in $(SUBDIRS); do $(MAKE) --no-print-directory -C  $$dir $@; done

MOD=../lib/App/sdif.pm

index.md: $(MOD) HEAD.inc Makefile
	( \
	[ -f HEAD.inc ] && cat HEAD.inc ; \
	cat < $(MOD) | pod2markdown | sed 's/^#/##/' ; \
	: ) > $@
