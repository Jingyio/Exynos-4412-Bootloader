# Exynos-4412-Bootloader

I wrote these three files **start.S init.S boot.c** to show how to build a simple bootloader for Samsung Exynos 4412 Quad ARM SoC. The function of these codes is to load the Linux kernel on the chip. However, it is just a toy that helps us understand low-level programming better. So don't expect it to work well. :)

### *Block Diagram of Booting Timing Operation*
![image](https://github.com/Juradira/Exynos-4412-Bootloader/blob/master/md/SoC.png)

### *IROM Booting Sequence*
![image](https://github.com/Juradira/Exynos-4412-Bootloader/blob/master/md/boot-order.png)

### *Internal Memory Map*
![image](https://github.com/Juradira/Exynos-4412-Bootloader/blob/master/md/memory-map.png)
