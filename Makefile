# tst - tabbed simple terminal
# A combination of tabbed and ST into a single executable
# See LICENSE file for copyright and license details.

include config.mk

SRC = tst.c
OBJ = ${SRC:.c=.o}
BIN = ${OBJ:.o=}

all: options ${BIN}

options:
	@echo tst build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	cp config.def.h $@

.o:
	cd st/ && $(MAKE)
	${CC} -o $@ st/x.o st/st.o st/sixel.o st/sixel_hls.o st/hb.o $< ${LDFLAGS}

clean:
	cd st/ && $(MAKE) clean
	rm -f ${BIN} ${OBJ}

install: all
	echo installing executable files to ${DESTDIR}${PREFIX}/bin
	mkdir -p "${DESTDIR}${PREFIX}/bin"
	cp -f ${BIN} ${DESTDIR}${PREFIX}/bin
	chmod 755 "${DESTDIR}${PREFIX}/bin/tst"
	echo installing desktop entry to ${DESTDIR}${PREFIX}/share/applications
	mkdir -p "${DESTDIR}${PREFIX}/share/applications"
	cp -f tst.desktop ${DESTDIR}${PREFIX}/share/applications/
	chmod 755 ${DESTDIR}${PREFIX}/share/applications/tst.desktop
	echo installing manual pages to ${DESTDIR}${MANPREFIX}/man1
	mkdir -p "${DESTDIR}${MANPREFIX}/man1"
	sed "s/VERSION/${VERSION}/g" < tst.1 > "${DESTDIR}${MANPREFIX}/man1/tst.1"
	chmod 644 "${DESTDIR}${MANPREFIX}/man1/tst.1"
	tic -sx st/st.info

uninstall:
	echo removing executable files from ${DESTDIR}${PREFIX}/bin
	rm -f "${DESTDIR}${PREFIX}/bin/tst"
	echo removing manual pages from ${DESTDIR}${MANPREFIX}/man1
	rm -f "${DESTDIR}${MANPREFIX}/man1/tst.1"
	echo removing desktop entry from ${DESTDIR}${PREFIX}/share/applications
	rm -f "${DESTDIR}${PREFIX}/share/applications/tst.desktop"

.PHONY: all options clean install uninstall
