#include "regs.h"

.text
.globl _start
_start:
	b reset
	ldr pc, _undefined_instruction
	ldr pc, _software_interrupt
	ldr pc, _prefetch_abort
	ldr pc, _data_abort
	ldr pc, _not_used
	ldr pc, _irq
	ldr pc, _fiq

.globl _undefined_instruction
_undefined_instruction:	.word undefined_instruction
.globl _software_interrupt
_software_interrupt:	.word software_interrupt
.globl _prefetch_abort
_prefetch_abort:	.word prefetch_abort
.globl _data_abort
_data_abort:		.word data_abort
.globl _not_used
_not_used:		.word not_used
.globl _irq
_irq:			.word irq
.globl _fiq
_fiq:			.word fiq


reset:
/**********************************
 * SVC mode, disable fiq and irq
 **********************************/
	mrs r0, cpsr
	bic r0, r0, #0x1f	@--M[4:0]
	orr r0, r0, #0x13	@--SVC_10011
	orr r0, r0, #0x80	@--I[7]
	orr r0, r0, #0x40	@--F[6]
	msr cpsr, r0

/**********************************
 * init cp15
 *
 * Invalidate the MMU, I-cache and
 * D-cache
 *
 **********************************/
	mrc p15, 0, r0, c1, c0, 0
	bic r0, r0, #0x1000	@--I[12]
	bic r0, r0, #0x4	@--C[2]
	bic r0, r0, #0x1	@--M[0]
	mcr p15, 0, r0, c1, c0, 0

@/**********************************
@ * Turn on I-cache
@ **********************************/
@	mrc p15, 0, r0, c1, c0, 0
@	orr r0, r0, #0x1000	@--I[12]
@	mcr p15, 0, r0, c1, c0, 0

	mov ip, lr

#define SD_BOOT
#ifdef SD_BOOT
	bl wdt_invalidate
	bl power_manager_init
	bl init_uart
	bl ddr_mem_init
#endif

	ldr sp, =0x02026000

	bl cp_to_dram
	bl config_pll
	bl jump_to_kernel

1:
	b 1b

	mov lr, ip
	mov pc, lr

undefined_instruction:
software_interrupt:
prefetch_abort:
data_abort:
not_used:
irq:
fiq:
