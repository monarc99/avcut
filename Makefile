
APP=avcut
AVCUT_VERSION=0.2

CFLAGS+=-Wall -DAVCUT_VERSION=\"$(AVCUT_VERSION)\"
LDLIBS=-lavcodec -lavformat -lavutil

## enable support for libav (EXPERIMENTAL)
#CFLAGS=-DUSING_LIBAV

TAR?=$(shell which tar)
ARCH?=$(shell gcc -dumpmachine | cut -d "-" -f1)
PREFIX?=/usr


.PHONY: clean install

all: $(APP)

$(APP): avcut.c

clean:
	rm -f *.o $(APP)

install: $(APP)
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 755 avcut $(DESTDIR)$(PREFIX)/bin/
	install -m 644 README.md $(DESTDIR)$(PREFIX)/share/doc/$(APP)/

package: $(APP)
	$(TAR) -czf avcut-$(AVCUT_VERSION)-$(ARCH).tar.gz avcut README.md LICENSE

debug: CFLAGS+=-g -DDEBUG
debug: all