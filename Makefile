CFLAGS += -O0 -g

all: bpar

bpar: bpar.c
	cc $(CFLAGS) -o $@ $>

clean: bpar
	rm bpar
