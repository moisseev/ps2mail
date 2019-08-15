PROG        = ps2mail
PREFIX     ?= /usr/local
ETCDIR     ?= $(PREFIX)/etc/$(PROG)
LIBEXECDIR ?= $(PREFIX)/libexec
LOCALEDIR   = $(PREFIX)/share/locale

.PHONY: all $(PROG) test install uninstall clean po

all: $(PROG) po/ru.mo

$(PROG): $(PROG).bak

$(PROG).bak:
	sed -i.bak 's|/usr/local/bin/|$(PREFIX)/bin/|g' $(PROG)

po/ru.mo:
	msgfmt -o po/ru.mo po/ru.po

test: $(PROG)
	prove -V
	prove

install: $(PROG) po/ru.mo
	install -d $(DESTDIR)$(LIBEXECDIR) $(DESTDIR)$(ETCDIR) || exit 1;
	install -m 0555 $(PROG) $(DESTDIR)$(LIBEXECDIR)/$(PROG) || exit 1;
	install -m 0644 \
	    $(PROG).conf.sample \
	    $(PROG).newsyslog.conf.sample \
	    $(DESTDIR)$(ETCDIR) || exit 1;
	install -m 0644 po/ru.mo $(DESTDIR)$(LOCALEDIR)/ru/LC_MESSAGES/$(PROG).mo || exit 1;

uninstall:
	-@rm $(DESTDIR)$(LIBEXECDIR)/$(PROG) \
	     $(DESTDIR)$(ETCDIR)/$(PROG).conf.sample \
	     $(DESTDIR)$(ETCDIR)/$(PROG).newsyslog.conf.sample \
	     $(DESTDIR)$(LOCALEDIR)/ru/LC_MESSAGES/$(PROG).mo

clean:
	-@mv $(PROG).bak $(PROG)
	-@rm po/*.mo

po:
	xgettext --language=Perl --output=po/$(PROG).pot $(PROG)
	msgmerge --update --backup=off po/ru.po po/$(PROG).pot
