include config.mk

SRC = tst.c
OBJ = ${SRC:.c=.o}
BIN = ${OBJ:.o=}

all: options tst

options:
	@echo tst build options:
	@echo "CFLAGS  = $(STCFLAGS)"
	@echo "CC      = $(CC)"

tst: $(OBJ)
	cd src/st && $(MAKE) && tic -sx st.info
	cd src/tabbed && $(MAKE)
	cp src/st/st ./st
	cp src/tabbed/tabbed ./tabbed
	cp src/tabbed/xembed ./xembed
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

install:
	@echo Installing to ${DESTDIR}${PREFIX}/bin
	chmod 755 st
	chmod 755 tabbed
	chmod 755 xembed
	chmod 755 tst
	chmod 755 tst.desktop
	cp -f st tabbed xembed tst ${DESTDIR}${PREFIX}/bin
	cp -f tst.desktop ${DESTDIR}${PREFIX}/share/applications
	mkdir -p $(DESTDIR)$(PREFIX)/share/icons
	cp -f tst.png $(DESTDIR)$(PREFIX)/share/icons

uninstall:
	@echo Removing [TST, ST, Tabbed, XEmbed]
	rm -f $(DESTDIR)$(PREFIX)/bin/st
	rm -f $(DESTDIR)$(PREFIX)/bin/tst
	rm -f $(DESTDIR)$(PREFIX)/bin/tabbed
	rm -f $(DESTDIR)$(PREFIX)/bin/xembed
	rm -f $(DESTDIR)$(PREFIX)/share/applications/tst.desktop
	@echo Done

clean:
	rm -f tst st tabbed xembed $(OBJ)
	cd src/st && $(MAKE) clean
	cd src/tabbed && $(MAKE) clean