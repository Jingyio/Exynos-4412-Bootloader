#ifndef _TAG_H
#define _TAG_H

#define ATAG_CORE			0x54410001
#define ATAG_MEM			0x54410002
#define ATAG_CMDLINE		0x54410009
#define ATAG_RAMDISK		0x54410004
#define ATAG_ACORN			0x41000101
#define ATAG_MEMCLK			0x41000402
#define ATAG_INITRD			0x54410005
#define ATAG_INITRD2		0x54420005
#define ATAG_SERIAL			0x54410006
#define ATAG_REVISION		0x54410007
#define ATAG_VIDEOTEXT		0x54410003
#define ATAG_VIDEOLFB		0x54410008
#define ATAG_NONE			0x00000000

#define SIZE_TAG_HEADER		8
struct tag_header {
	unsigned long size;
	unsigned long type;
};

#define SIZE_TAG_CORE		12
struct tag_core {
	unsigned long flags;
	unsigned long pagesize;
	unsigned long rootdev;
};

#define SIZE_TAG_MEM32		8
struct tag_mem32 {
	unsigned long size;
	unsigned long start;
};

#define SIZE_TAG_RAMDISK	12
struct tag_ramdisk {
	unsigned long flags;
	unsigned long size;
	unsigned long start;
};

#define SIZE_TAG_INITRD		8
struct tag_initrd {
	unsigned long start;
	unsigned long size;
};

#define SIZE_TAG_SERIALNR	8
struct tag_serialnr {
	unsigned long low;
	unsigned long high;
};

#define SIZE_TAG_CMDLINE	1
struct tag_cmdline {
	char *cmdline; 
};

#define SIZE_TAG_ACORN		10
struct tag_acorn {
	unsigned long memc_control_reg;
	unsigned long vram_pages;
	unsigned char sounddefault;
	unsigned char adfsdrives;
};

#define SIZE_TAG_MEMCLK		4
struct tag_memclk {
	unsigned long fmemclk;
};

struct tag {
	struct tag_header hdr;
	union {
		struct tag_core		core;
		struct tag_mem32	mem;
		struct tag_ramdisk	ramdisk;
		struct tag_initrd	initrd;
		struct tag_serialnr	serialnr;
		struct tag_cmdline	cmdline;
		struct tag_acorn	acorn;
		struct tag_memclk	memclk;
	} u;
};

#endif

