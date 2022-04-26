# tabbed version
VERSION = 0.6

# Customize below to fit your system

# paths
PREFIX = /usr/local/
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

PKG_CONFIG = pkg-config

XRENDER = -lXrender

LIGATURES_C = st/hb.c
LIGATURES_H = st/hb.h
LIGATURES_INC = `$(PKG_CONFIG) --cflags harfbuzz`
LIGATURES_LIBS = `$(PKG_CONFIG) --libs harfbuzz`

# freetype
FREETYPELIBS = -lfontconfig ./libs/libXft.a
FREETYPEINC = /usr/include/freetype2
# OpenBSD (uncomment)
#FREETYPEINC = ${X11INC}/freetype2

# includes and libs
INCS = -I. -I/usr/include -I$(X11INC) -I${FREETYPEINC} \
			 `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2` \
       $(LIGATURES_INC)
LIBS = -L/usr/lib -lc -L${X11LIB} -lX11 ${FREETYPELIBS} \
			 -lm -lrt -lX11 -lutil ./libs/libXft.a ${XRENDER} ${XCURSOR}\
       `$(PKG_CONFIG) --libs fontconfig` \
       ./libs/libfreetype.a \
       $(LIGATURES_LIBS)

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\" -D_DEFAULT_SOURCE
CFLAGS = -std=c99 -pedantic -Wall -Os ${INCS} ${CPPFLAGS}
LDFLAGS = -s ${LIBS}

# Solaris
#CFLAGS = -fast ${INCS} -DVERSION=\"${VERSION}\"
#LDFLAGS = ${LIBS}

# compiler and linker
CC = cc
