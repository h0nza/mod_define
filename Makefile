
#for compare with ~rjung original

default : ; @cat Makefile

diff-q : rjung ; diff -q . rjung

rjung :
	test -d $@ || mkdir $@
	cd $@ && wget -nH -nd -r http://people.apache.org/~rjung/mod_define/

meld : rjung ; $@ mod_define.c rjung/mod_define.c

mod_define.md : ; pandoc rjung/$(@:.md=.html) -o $@

ApacheDir = $(HOME)/apache22
APXS = $(ApacheDir)/sbin/apxs

apxs : ; $(APXS) -q CFLAGS

build : ; $(APXS) -c mod_define.c

install : ; $(APXS) -cia mod_define.c