# st - simple terminal
# See LICENSE file for copyright and license details.

include config.mk

SRC = st.c x.c $(LIGATURES_C) $(SIXEL_C)
OBJ = $(SRC:.c=.o)

all: options st

options:
	@echo st build options:
	@echo "CFLAGS  = $(STCFLAGS)"
	@echo "LDFLAGS = $(STLDFLAGS)"
	@echo "CC      = $(CC)"

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o: arg.h config.h st.h win.h $(LIGATURES_H)

$(OBJ): config.h config.mk

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS) -nostartfiles

clean:
	rm -f st $(OBJ)

.PHONY: all options clean
