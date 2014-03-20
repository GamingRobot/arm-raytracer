NAME=color

TOOLPREFIX=arm-none-eabi
all: ${NAME}.bin
	qemu-system-arm -M vexpress-a9 -m 128M -kernel $^
debug: ${NAME}.bin ${NAME}.elf
	qemu-system-arm -M vexpress-a9 -m 128M -kernel $^ -S -s

%.elf: %.s
	${TOOLPREFIX}-as --gstabs $^ -o $@
%.out: %.elf
	${TOOLPREFIX}-ld -Ttext=0x60010000 $^ -o $@
%.bin: %.out
	${TOOLPREFIX}-objcopy -O binary $^ $@
%.objdump: %.out
	${TOOLPREFIX}-objdump -d $^  > $@
