.arch armv7-a
.fpu neon
.syntax unified

.global _start
_start:
	mov r1, $0
	movt r1, $0x1002	//Primecell pl111 clcd is mapped to 0x10020000

	//setup primecell registers
	movw r3, $0x3F9C
	movt r3, $0x3F1F	//0x3F1F3F9C 
	str r3, [r1, $0x0]	//CLCD_TIM0

	movw r3, $0x61DF
	movt r3, $0x090B	//0x090B61DF
	str r3, [r1, $0x4]	//CLCD_TIM1

	mov r3, $0x1800
	movt r3, $0x067F	//0x067F1800
	str r3, [r1, $0x8]	//CLCD_TIM2

	mov r2, $0
	movt r2, $0x6002 	//0x60020000
	str r2, [r1, $0x10]	//CLCD_UBAS

	movw r3, $0x082B	//CNTL_LCDEN | CNTL_LCDBPP24 | CNTL_LCDTFT | CNTL_LCDPWR
	str r3, [r1, $0x18]	//CLCD_PL111_CNTL


	//testcode
	mov r0, $0
	mov r3, $0x12c000	//640 x 480 x 4

redbars:
	mov r1, r0
	//and r1, r1, $0xFF
	//str r1, [r2, r0]
	//0xFF8000
	movw r4, $0xcc33	//99cc33 bgr in register, but is 33cc99 rgb color
	movt r4, $0x99
	str r4, [r2, r0]
	add r0, r0, $4
	cmp r0, r3		//we have drawn all pixles on the screen
	bne redbars

hcf: B hcf	//loop

