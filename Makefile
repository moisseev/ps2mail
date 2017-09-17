PROG        = ps2mail
PREFIX     ?= /usr/local
ETCDIR     ?= $(PREFIX)/etc/$(PROG)
LIBEXECDIR ?= $(PREFIX)/libexec

.PHONY: all $(PROG) test install uninstall clean

all: $(PROG)

$(PROG):
	sed -i.bak 's|/usr/local/bin/|$(PREFIX)/bin/|g' $(PROG)

test: $(PROG)
	prove

install:
	install -d $(DESTDIR)$(LIBEXECDIR) $(DESTDIR)$(ETCDIR) || exit 1;
	install -m 0555 $(PROG) $(DESTDIR)$(LIBEXECDIR)/$(PROG) || exit 1;
	install -m 0644 $(PROG).conf.sample $(DESTDIR)$(ETCDIR)/$(PROG).conf.sample || exit 1;

uninstall:
	-@rm $(DESTDIR)$(LIBEXECDIR)/$(PROG) \
	     $(DESTDIR)$(ETCDIR)/$(PROG).conf.sample;

clean:
	mv $(PROG).bak $(PROG)
