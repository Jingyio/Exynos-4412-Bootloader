LD = arm-none-linux-gnueabi-ld
OC = arm-none-linux-gnueabi-objcopy
CC = arm-none-linux-gnueabi-gcc

OBJ = start.o init.o boot.o

project.bin : $(OBJ)
	$(LD) -Tbootloader.lds -N -o a.elf $^
	$(OC) -O binary -S a.elf $@


%.o : %.c
	$(CC) -c -nostdlib -o $@ $<

%.o : %.S
	$(CC) -Wall -marm -O2 -c -o $@ $<

.PHONY : clean
clean:
	rm -rf *.o *.elf *.bin
