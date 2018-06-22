#include "tag.h"

typedef void (*SDMMC_ReadBlocks)(unsigned long uStBlock, unsigned long uNumberofBlocks, void *uDstAddr);

void cp_to_dram(void)
{
	SDMMC_ReadBlocks cp_fun = (SDMMC_ReadBlocks)(*(unsigned int *)(0x02020030));

	cp_fun(3000, 12000, (unsigned long *)0x40008000);
	cp_fun(2900, 1, (unsigned long *)0x70005000);
	cp_fun(2950, 2, (unsigned long *)0x70000000);
//	cp_fun(1200, 1600, (unsigned long *)0x40800000);
	led_on();
}

/**********************************
 * Set up the tags
 *
 **********************************/
struct tag *parameters = (struct tag*)0x40000100;

static void setup_tag_core(void)
{
	/* Header */
	parameters->hdr.type = ATAG_CORE;
	parameters->hdr.size = SIZE_TAG_HEADER + SIZE_TAG_CORE;

	parameters->u.core.flags = 0;
	parameters->u.core.pagesize = 0;
	parameters->u.core.rootdev = 0;

	parameters += SIZE_TAG_HEADER + SIZE_TAG_CORE;
}

static void setup_tag_mem32(void)
{
	/* Header */
	parameters->hdr.type = ATAG_MEM;
	parameters->hdr.size = SIZE_TAG_HEADER + SIZE_TAG_MEM32;

	parameters->u.mem.size = 1024 * 1024 * 1024;
	parameters->u.mem.start = 0x40000000;

	parameters += SIZE_TAG_HEADER + SIZE_TAG_MEM32;
}

static void setup_tag_ramdisk(void)
{
	/* Header */
	parameters->hdr.type = ATAG_RAMDISK;
	parameters->hdr.size = SIZE_TAG_HEADER + SIZE_TAG_RAMDISK;

	parameters->u.ramdisk.flags = 1;
	parameters->u.ramdisk.size = 0;
	parameters->u.ramdisk.start = 0x40800000;

	parameters += SIZE_TAG_HEADER + SIZE_TAG_RAMDISK;
}


static void setup_tag_cmdline(char *p_cmd)
{
	int cmd_length = 0;

	/* Get cmd string's length */
	for (cmd_length = 0; *p_cmd != '\0'; cmd_length++, p_cmd++) {;}
	cmd_length++;	//for '\0'

	/* Header */
	parameters->hdr.type = ATAG_CMDLINE;
	parameters->hdr.size = (SIZE_TAG_HEADER + cmd_length + 3) >> 2 ;

	while(*p_cmd != '\0')
	{
		*(parameters->u.cmdline.cmdline) = *p_cmd;
		parameters->u.cmdline.cmdline++;
		p_cmd++;
	}

	parameters += parameters->hdr.size;
}

static void setup_tag_none(void)
{
	/* Header */
	parameters->hdr.type = ATAG_NONE;
	parameters->hdr.size = 0;
}


void jump_to_kernel(void)
{
	void (*jump_to_zImage)(int zero, int mach_id, unsigned long params);
	jump_to_zImage = (void (*)(int zero, int mach_id, unsigned long params))0x40008000;


	setup_tag_core();
	setup_tag_mem32();
	setup_tag_ramdisk();
	setup_tag_cmdline("root=/dev/mmcblk0p2 rootfstype=ext4 init=/linuxrc debug console=ttySAC2,115200");
	setup_tag_none();

	/* Will not return */
	jump_to_zImage(0, 0xb16, 0x40000100);
}
