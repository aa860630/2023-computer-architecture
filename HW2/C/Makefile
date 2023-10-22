.PHONY: clean

include ../../../mk/toolchain.mk

CFLAGS = -march=rv32i -mabi=ilp32 -O2
ASFLAGS = -march=rv32i -mabi=ilp32

OBJS = main.o
BIN = main.elf

%.S: %.c
	$(CROSS_COMPILE)gcc $(CFLAGS)  -o $@ -S $<

%.o: %.S
	$(CROSS_COMPILE)as  $(ASFLAGS) -o $@ $<

all: $(BIN)

main.S: main.c
	$(CROSS_COMPILE)gcc $(CFLAGS)  -o $@ -S $<

main.o: main.S
	$(CROSS_COMPILE)as  $(ASFLAGS) -o $@ $<

$(BIN): $(OBJS)
	 $(CROSS_COMPILE)gcc -o $@ $^

clean:
	$(RM) $(BIN) $(OBJS)
