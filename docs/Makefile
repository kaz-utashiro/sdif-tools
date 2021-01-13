SUBDIRS = cdif sdif watchdiff

.PHONY: all clean $(SUBDIRS)

all clean:
	for dir in $(SUBDIRS); do $(MAKE) --no-print-directory -C  $$dir $@; done
