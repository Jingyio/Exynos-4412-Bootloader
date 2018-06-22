//----------------------------------------------------watch dog
#define WTBASE					0x10060000
#define WTCON					0x10060000

//----------------------------------------------------gpio for uart
#define GPA1CON					0x11400020
#define GPA0CON					0x11400000


//----------------------------------------------------clock
#define MPLL_CON0				0x10040108
#define EPLL_CON0				0x1003C110
#define VPLL_CON0				0x1003C120
#define APLL_CON0				0x10044100


#define CLK_SRC_PERIL0			0x1003C250
#define CLK_DIV_PERIL0			0x1003C550

//----------------------------------------------------uart3
#define UART3BASE				0x13830000
#define ULCON3					0x13830000
#define UCON3					0x13830004
#define UFCON3					0x13830008
#define UMCON3					0x1383000C
#define UTRSTAT3				0x13830010
#define UTXH3					0x13830020
#define URXH3					0x13830024
#define UBRDIV3					0x13830028
#define UFRACVAL3				0x1383002C
//----------------------------------------------------uart2
#define UART2BASE				0x13820000
#define ULCON2					0x13820000
#define UCON2					0x13820004
#define UFCON2					0x13820008
#define UMCON2					0x1382000C
#define UTRSTAT2				0x13820010
#define UTXH2					0x13820020
#define URXH2					0x13820024
#define UBRDIV2					0x13820028
#define UFRACVAL2				0x1382002C
//----------------------------------------------------uart0
#define UART0BASE				0x13800000
#define ULCON0					0x13800000
#define UCON0					0x13800004
#define UFCON0					0x13800008
#define UMCON0					0x1380000C
#define UTRSTAT0				0x13800010
#define UTXH0					0x13800020
#define URXH0					0x13800024
#define UBRDIV0					0x13800028
#define UFRACVAL0				0x1380002C



//----------------------------------------------------led
#define GPLBASE					0x11000000
#define GPL2CON					0x11000100
#define GPL2DAT					0x11000104
#define GPL2PUD					0x11000108
#define GPL2DRV					0x1100010C
#define GPL2CONPDN				0x11000110
#define GPL2PUDPDN				0x11000114

//----------------------------------------------------power
#define PS_HOLD_CONTROL			0x1002330C
#define GPX0PUD					0x11000C08

//----------------------------------------------------clock
#define ELFIN_CLOCK_BASE		0x10030000
#define CLK_DIV_DMC0_OFFSET		0x10500
#define CLK_DIV_DMC1_OFFSET		0x10504

//----------------------------------------------------DMC
#define DMC_0_BASE				0x10600000
#define DMC_1_BASE				0x10610000

#define DMC_CONCONTROL 			0x00
#define DMC_MEMCONTROL 			0x04
#define DMC_MEMCONFIG0 			0x08
#define DMC_MEMCONFIG1 			0x0C
#define DMC_DIRECTCMD 			0x10
#define DMC_PRECHCONFIG 		0x14
#define DMC_PHYCONTROL0 		0x18
#define DMC_PHYCONTROL1 		0x1C
#define DMC_PHYCONTROL2 		0x20
#define DMC_PWRDNCONFIG 		0x28
#define DMC_TIMINGAREF 			0x30
#define DMC_TIMINGROW 			0x34
#define DMC_TIMINGDATA 			0x38
#define DMC_TIMINGPOWER 		0x3C
#define DMC_PHYSTATUS 			0x40
#define DMC_PHYZQCONTROL 		0x44
#define DMC_CHIP0STATUS 		0x48
#define DMC_CHIP1STATUS 		0x4C
#define DMC_AREFSTATUS 			0x50
#define DMC_MRSTATUS 			0x54
#define DMC_PHYTEST0 			0x58
#define DMC_PHYTEST1 			0x5C
#define DMC_QOSCONTROL0 		0x60
#define DMC_QOSCONFIG0 			0x64
#define DMC_QOSCONTROL1 		0x68
#define DMC_QOSCONFIG1 			0x6C
#define DMC_QOSCONTROL2 		0x70
#define DMC_QOSCONFIG2 			0x74
#define DMC_QOSCONTROL3 		0x78
#define DMC_QOSCONFIG3 			0x7C
#define DMC_QOSCONTROL4 		0x80
#define DMC_QOSCONFIG4 			0x84
#define DMC_QOSCONTROL5 		0x88
#define DMC_QOSCONFIG5 			0x8C
#define DMC_QOSCONTROL6 		0x90
#define DMC_QOSCONFIG6 			0x94
#define DMC_QOSCONTROL7 		0x98
#define DMC_QOSCONFIG7 			0x9C
#define DMC_QOSCONTROL8 		0xA0
#define DMC_QOSCONFIG8 			0xA4
#define DMC_QOSCONTROL9 		0xA8
#define DMC_QOSCONFIG9 			0xAC
#define DMC_QOSCONTROL10 		0xB0
#define DMC_QOSCONFIG10 		0xB4
#define DMC_QOSCONTROL11 		0xB8
#define DMC_QOSCONFIG11 		0xBC
#define DMC_QOSCONTROL12 		0xC0
#define DMC_QOSCONFIG12 		0xC4
#define DMC_QOSCONTROL13 		0xC8
#define DMC_QOSCONFIG13 		0xCC
#define DMC_QOSCONTROL14 		0xD0
#define DMC_QOSCONFIG14 		0xD4
#define DMC_QOSCONTROL15 		0xD8
#define DMC_QOSCONFIG15 		0xDC
#define DMC_IVCONTROL	 		0xF0

