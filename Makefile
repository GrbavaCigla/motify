# motify - mail daemon
# Makefile and config.mk stolen from dwm :)
NAME = motify
VERSION = 1.0

PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

INC = `pkgconf --cflags libnotify libcurl` -I/usr/include/libsecret-1/
LIBS = `pkgconf --libs libnotify libcurl` -lsecret

CFLAGS = ${INC} -std=c99 -pedantic -Wall -Werror -Wno-deprecated-declarations -O3
LDFLAGS = ${LIBS}

CC = cc

SRC = motify.c util.c
OBJ = ${SRC:.c=.o}

all: options motify

options:
	@echo motify build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h

config.h:
	cp config.def.h $@

motify: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -rf motify ${OBJ}

