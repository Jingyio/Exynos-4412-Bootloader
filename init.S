#include "regs.h"

.text
/***********************************************
 * Disable watch dog
 ***********************************************/
.globl wdt_invalidate
wdt_invalidate:
	mov r0, #0
	ldr r1, =WTBASE
	str r0, [r1]

	mov pc, lr

/***********************************************
 * Do something puzzling for power manager
 *
 * Note: As the rm says, "You should reset
 *		 PSHOLD control only when cold booted."
 *
 ***********************************************/
.globl power_manager_init
power_manager_init:
	ldr r0, =PS_HOLD_CONTROL
	ldr r1, =0x00005300
	str r1, [r0]

	/* It seems that the following code is to
	   support the tf card pin */
	ldr r0, =GPX0PUD
	mov r1, #0
	str r1, [r0]

	mov pc, lr

/***********************************************
 * Configure the clock pll
 *
 * MPLL:	800MHz
 * APLL:	1000MHz
 *
 ***********************************************/
.globl config_pll
config_pll:
	ldr r0, =MPLL_CON0
	ldr r1, [r0]
	ldr r2, =0x3FFFFFF
	bic r1, r1, r2
	ldr r2, =0x640300
	orr r1, r1, r2
	str r1, [r0]

	ldr r0, =APLL_CON0
	ldr r1, [r0]
	ldr r2, =0x3FFFFFF
	bic r1, r1, r2
	ldr r2, =0x7D0300
	orr r1, r1, r2
	str r1, [r0]

	mov pc, lr

/***********************************************
 * Initialize the ddr sdram
 ***********************************************/
.globl ddr_mem_init
ddr_mem_init:
	/* Push */
	mov r5, lr

	/* Async bridge configuration at CPU_core */
	/* 1: half_sync */
	/* 0: full_sync */
	ldr r0, =0x10010350
	mov r1, #1
	str r1, [r0]

	/* Note that the memory CK/CKn must
	   be less than or equal to 50 MHz before you
	   initialize the LPDDR2-S4 device */
	ldr r0, =ELFIN_CLOCK_BASE
	ldr r1, =CLK_DIV_DMC0_OFFSET
	ldr r2, =0x00117713
	str r2, [r0, r1]


/* ---------------DREX0-------------------- */
	ldr	r0, =DMC_0_BASE

	ldr	r1, =0xE3855403
	str	r1, [r0, #DMC_PHYZQCONTROL]

	ldr	r1, =0x71101008
	str	r1, [r0, #DMC_PHYCONTROL0]

	ldr	r1, =0x7110100A
	str	r1, [r0, #DMC_PHYCONTROL0]

	ldr	r1, =0x00000084
	str	r1, [r0, #DMC_PHYCONTROL1]

	ldr	r1, =0x71101008
	str	r1, [r0, #DMC_PHYCONTROL0]

	ldr	r1, =0x0000008C
	str	r1, [r0, #DMC_PHYCONTROL1]

	ldr	r1, =0x00000084
	str	r1, [r0, #DMC_PHYCONTROL1]

	ldr	r1, =0x0000008C
	str	r1, [r0, #DMC_PHYCONTROL1]

	ldr	r1, =0x00000084
	str	r1, [r0, #DMC_PHYCONTROL1]

	ldr	r1, =0x0FFF30CA
	str	r1, [r0, #DMC_CONCONTROL]

	ldr	r1, =0x00202500
	str	r1, [r0, #DMC_MEMCONTROL]

	ldr	r1, =0x40C01323
	str	r1, [r0, #DMC_MEMCONFIG0]

	ldr	r1, =0x8000001D
	str	r1, [r0, #DMC_IVCONTROL]

	ldr	r1, =0xff000000
	str	r1, [r0, #DMC_PRECHCONFIG]

	ldr	r1, =0x9C4000FF
	str	r1, [r0, #DMC_PHYCONTROL0]

	ldr	r1, =0x0000005D
	str	r1, [r0, #DMC_TIMINGAREF] @TimingAref

	//Timing Configure, for MCLK_330
	ldr	r1, =0x2b47654e
	str	r1, [r0, #DMC_TIMINGROW]
	ldr	r1, =0x35330306
	str	r1, [r0, #DMC_TIMINGDATA]
	ldr	r1, =0x442f0365
	str	r1, [r0, #DMC_TIMINGPOWER]

	/* 0x64: wait 250 nano seconds at ARMCLK 1.5 Ghz */
	mov r2, #0x64
1:	subs r2, r2, #1
	bne 1b

	ldr	r1, =0x07000000
	str	r1, [r0, #DMC_DIRECTCMD]

	/* 0x19000: wait 250 micro seconds at ARMCLK 1.5 Ghz */
	mov	r2, #0x19000
2:	subs r2, r2, #1
	bne 2b

	ldr	r1, =0x00071C00
	str	r1, [r0, #DMC_DIRECTCMD]

	/* 0x2700: wait 25 micro seconds at ARMCLK 1.5 Ghz */
	mov	r2, #0x2700
3:	subs r2, r2, #1
	bne 3b

	ldr	r1, =0x00010BFC
	str	r1, [r0, #DMC_DIRECTCMD]

	/* 0x3f0: wait 2.5 micro seconds at ARMCLK 1.5 Ghz */
	mov	r2, #0x3f0
4:  subs r2 ,r2, #1
	bne 4b

	ldr	r1, =0x00000488
	str	r1, [r0, #DMC_DIRECTCMD]
	ldr	r1, =0x00000810
	str	r1, [r0, #DMC_DIRECTCMD]
	ldr	r1, =0x00000C08
	str	r1, [r0, #DMC_DIRECTCMD]


/* ---------------DREX1-------------------- */
	ldr	r0, =DMC_1_BASE

	ldr	r1, =0xE3855403
	str	r1, [r0, #DMC_PHYZQCONTROL]

	ldr	r1, =0x71101008
	str	r1, [r0, #DMC_PHYCONTROL0]

	ldr	r1, =0x7110100A
	str	r1, [r0, #DMC_PHYCONTROL0]

	ldr	r1, =0x00000084
	str	r1, [r0, #DMC_PHYCONTROL1]

	ldr	r1, =0x71101008
	str	r1, [r0, #DMC_PHYCONTROL0]

	ldr	r1, =0x0000008C
	str	r1, [r0, #DMC_PHYCONTROL1]

	ldr	r1, =0x00000084
	str	r1, [r0, #DMC_PHYCONTROL1]

	ldr	r1, =0x0000008C
	str	r1, [r0, #DMC_PHYCONTROL1]

	ldr	r1, =0x00000084
	str	r1, [r0, #DMC_PHYCONTROL1]

	ldr	r1, =0x0FFF30CA
	str	r1, [r0, #DMC_CONCONTROL]

	ldr	r1, =0x00202500
	str	r1, [r0, #DMC_MEMCONTROL]

	ldr	r1, =0x40C01323
	str	r1, [r0, #DMC_MEMCONFIG0]

	ldr	r1, =0x8000001D
	str	r1, [r0, #DMC_IVCONTROL]

	ldr	r1, =0x64000000
	str	r1, [r0, #DMC_PRECHCONFIG]

	ldr	r1, =0x9C4000FF
	str	r1, [r0, #DMC_PHYCONTROL0]

	ldr	r1, =0x0000005D
	str	r1, [r0, #DMC_TIMINGAREF] @TimingAref

	//Timing Configure for MCLK_330
	ldr	r1, =0x2b47654e
	str	r1, [r0, #DMC_TIMINGROW]
	ldr	r1, =0x35330306
	str	r1, [r0, #DMC_TIMINGDATA]
	ldr	r1, =0x442f0365
	str	r1, [r0, #DMC_TIMINGPOWER]

	/* 0x64: wait 250 nano seconds at ARMCLK 1.5 Ghz */
	mov r2, #0x64
5:	subs r2, r2, #1
	bne 5b

	ldr	r1, =0x07000000
	str	r1, [r0, #DMC_DIRECTCMD]

	/* 0x19000: wait 250 micro seconds at ARMCLK 1.5 Ghz */
	mov	r2, #0x19000
6:	subs r2, r2, #1
	bne 6b

	ldr	r1, =0x00071C00
	str	r1, [r0, #DMC_DIRECTCMD]

	/* 0x2700: wait 25 micro seconds at ARMCLK 1.5 Ghz */
	mov	r2, #0x2700
7:	subs r2, r2, #1
	bne 7b

	ldr	r1, =0x00010BFC
	str	r1, [r0, #DMC_DIRECTCMD]

	/* 0x3f0: wait 2.5 micro seconds at ARMCLK 1.5 Ghz */
	mov	r2, #0x3f0
8:  subs r2 ,r2, #1
	bne 8b

	ldr	r1, =0x00000488
	str	r1, [r0, #DMC_DIRECTCMD]
	ldr	r1, =0x00000810
	str	r1, [r0, #DMC_DIRECTCMD]
	ldr	r1, =0x00000C08
	str	r1, [r0, #DMC_DIRECTCMD]


/* ---------------Turn on!-------------------- */
	ldr	r0, =DMC_0_BASE
	ldr	r1, =0x0FFF303a
	str	r1, [r0, #DMC_CONCONTROL]

	ldr	r0, =DMC_1_BASE
	ldr	r1, =0x0FFF303a
	str	r1, [r0, #DMC_CONCONTROL]

	/* POP */
	mov lr, r5
	mov pc, lr



/***********************************************
 * Initialize the uart
 ***********************************************/
.globl init_uart
init_uart:
	ldr r0, =0x222222		@gpio
	ldr r1, =GPA1CON
	str r0, [r1]

	ldr r0, =0x22222222
	ldr r1, =GPA0CON
	str r0, [r1]

	@------configure for clk
	ldr r0, =0x66666		@we choose SCLKMPLL_USER_T for uart0~4

	ldr r1, =CLK_SRC_PERIL0
	str r0, [r1]

	ldr r0, =0x77777		@SCLK_UART = MOUTUART0/(UART0_RATIO + 1), RATIO is 7 here
	ldr r1, =CLK_DIV_PERIL0
	str r0, [r1]


@-------------------uart3
	mov r0, #0x3			@--[1:0]--data bit
	ldr r1, =ULCON3			@--[2]--stop bit
	str r0, [r1]

	mov r0, #0
	orr r0, r0, #(1 << 2)		@--[3:2]--TX IT/pl mode
	orr r0, r0, #1			@--[1:0]--RX IT/pl mode
	ldr r1, =UCON3
	str r0, [r1]

	ldr r0, =0x111
	ldr r1, =UFCON3
	str r0, [r1]

	mov r0, #53			@baud rate for 115200
	ldr r1, =UBRDIV3
	str r0, [r1]
	mov r0, #4
	ldr r1, =UFRACVAL3
	str r0, [r1]

@-------------------uart2
	mov r0, #0x3			@--[1:0]--data bit
	ldr r1, =ULCON2			@--[2]--stop bit
	str r0, [r1]

	mov r0, #0
	orr r0, r0, #(1 << 2)		@--[3:2]--TX IT/pl mode
	orr r0, r0, #1			@--[1:0]--RX IT/pl mode
	ldr r1, =UCON2
	str r0, [r1]

	ldr r0, =0x111
	ldr r1, =UFCON2
	str r0, [r1]

	mov r0, #53 			@baud rate for 115200
	ldr r1, =UBRDIV2
	str r0, [r1]
	mov r0, #4
	ldr r1, =UFRACVAL2
	str r0, [r1]


	mov pc, lr				@return

/***********************************************
 * Send the data to uart
 ***********************************************/
.globl printf_addr_data
printf_addr_data:
	stmfd sp!, {r0-r5, lr}

	ldr r0, [r0]
	mov r2, #28			@loop times
	ldr r3, =UTXH3

	mov r1, #48
	str r1, [r3]			@send '0'
	bl wait_for_TX_idle
	mov r1, #120
	str r1, [r3]			@send 'x'


shift_loop:
	mov r1, r0, lsr r2
	and r1, r1, #0xf
	cmp r1, #10
	addmi r1, r1, #48
	addpl r1, r1, #55

	bl wait_for_TX_idle
	str r1, [r3]			@send data

	sub r2, r2, #4
	cmp r2, #0
	bpl shift_loop

	mov r1, #10
	str r1, [r3]			@send '\n'
	mov r1, #13
	str r1, [r3]			@send '\r'

	ldmfd sp!, {r0-r5, pc}

wait_for_TX_idle:
	ldr r4, =UTRSTAT3
	ldr r4, [r4]
	and r4, r4, #(1 << 2)
	cmp r4, #0
	beq wait_for_TX_idle

	mov pc, lr



/***********************************************
 * Turn on the led
 ***********************************************/
.globl led_on
led_on:
	//Ouput configure
	ldr r0, =GPL2CON
	ldr r1, [r0]
	bic r1, r1, #0xf
	orr r1, r1, #0x1
	str r1, [r0]

	//Disable pull-up
	ldr r0, =GPL2PUD
	mov r1, #0
	str r1, [r0]

	//Set high
	ldr r0, =GPL2DAT
	mov r1, #1
	str r1, [r0]

	mov pc, lr

/***********************************************
 * Test the ddr sdram
 ***********************************************/
.globl ram_test
ram_test:
	mov r5, lr

	ldr r1, =0x600C0000
	str r1, [r1]
	ldr r1, =0x40001000
	str r1, [r1]

	ldr r0, =0x60038000
	bl printf_addr_data
	ldr r0, =0x40001000
	bl printf_addr_data

	mov lr, r5
	mov pc, lr
