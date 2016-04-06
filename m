From: Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH V1 6/7] MIPS: Loongson1B: Some updates/fixes for LS1B
Date: Wed,  6 Apr 2016 20:34:54 +0800
Message-ID: <1459946095-7637-7-git-send-email-keguang.zhang@gmail.com>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Kelvin Cheung <keguang.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Kelvin Cheung <keguang.zhang@gmail.com>

- Add DMA device
- Add NAND device
- Add GPIO device
- Add LED device
- Update the defconfig and rename it to loongson1b_defconfig
- Fix ioremap size
- Other minor fixes

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/Kconfig                                 |   2 +
 arch/mips/configs/loongson1b_defconfig            | 125 ++++++++++++++++++++++
 arch/mips/configs/ls1b_defconfig                  | 110 -------------------
 arch/mips/include/asm/mach-loongson32/cpufreq.h   |   1 -
 arch/mips/include/asm/mach-loongson32/dma.h       |  25 +++++
 arch/mips/include/asm/mach-loongson32/irq.h       |   1 -
 arch/mips/include/asm/mach-loongson32/loongson1.h |   4 +-
 arch/mips/include/asm/mach-loongson32/nand.h      |  30 ++++++
 arch/mips/include/asm/mach-loongson32/platform.h  |  14 ++-
 arch/mips/include/asm/mach-loongson32/regs-clk.h  |  24 ++---
 arch/mips/include/asm/mach-loongson32/regs-mux.h  |  84 +++++++--------
 arch/mips/include/asm/mach-loongson32/regs-pwm.h  |  12 +--
 arch/mips/loongson32/common/platform.c            | 105 +++++++++++++++++-
 arch/mips/loongson32/common/reset.c               |  13 +--
 arch/mips/loongson32/common/time.c                |  27 ++---
 arch/mips/loongson32/ls1b/board.c                 |  67 +++++++++++-
 16 files changed, 440 insertions(+), 204 deletions(-)
 create mode 100644 arch/mips/configs/loongson1b_defconfig
 delete mode 100644 arch/mips/configs/ls1b_defconfig
 create mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
 create mode 100644 arch/mips/include/asm/mach-loongson32/nand.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35d92a1..53b16e8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1387,6 +1387,8 @@ config CPU_LOONGSON1B
 	bool "Loongson 1B"
 	depends on SYS_HAS_CPU_LOONGSON1B
 	select CPU_LOONGSON1
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select LEDS_GPIO_REGISTER
 	help
 	  The Loongson 1B is a 32-bit SoC, which implements the MIPS32
 	  release 2 instruction set.
diff --git a/arch/mips/configs/loongson1b_defconfig b/arch/mips/configs/loongson1b_defconfig
new file mode 100644
index 0000000..c442f27
--- /dev/null
+++ b/arch/mips/configs/loongson1b_defconfig
@@ -0,0 +1,125 @@
+CONFIG_MACH_LOONGSON32=y
+CONFIG_PREEMPT=y
+# CONFIG_SECCOMP is not set
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_KERNEL_XZ=y
+CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_NAMESPACES=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EXPERT=y
+CONFIG_PERF_EVENTS=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_LOONGSON1=y
+CONFIG_MTD_UBI=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_SCSI=m
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=m
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+CONFIG_STMMAC_ETH=y
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_WLAN is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_LEGACY_PTY_COUNT=8
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_LOONGSON1=y
+# CONFIG_HWMON is not set
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_HID_GENERIC=m
+CONFIG_USB_HID=m
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=m
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_PL2303=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_LOONGSON1=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+# CONFIG_DNOTIFY is not set
+CONFIG_VFAT_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_ADVANCED_COMPR=y
+CONFIG_UBIFS_ATIME_SUPPORT=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=m
+CONFIG_NLS_ISO8859_1=m
+CONFIG_DYNAMIC_DEBUG=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_FTRACE is not set
+# CONFIG_EARLY_PRINTK is not set
+# CONFIG_CRYPTO_ECHAINIV is not set
+# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/configs/ls1b_defconfig b/arch/mips/configs/ls1b_defconfig
deleted file mode 100644
index 1b2cc1f..0000000
--- a/arch/mips/configs/ls1b_defconfig
+++ /dev/null
@@ -1,110 +0,0 @@
-CONFIG_MACH_LOONGSON32=y
-CONFIG_PREEMPT=y
-# CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
-# CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_SYSVIPC=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BSD_PROCESS_ACCT_V3=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=16
-CONFIG_NAMESPACES=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
-CONFIG_EXPERT=y
-CONFIG_PERF_EVENTS=y
-# CONFIG_COMPAT_BRK is not set
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-# CONFIG_LBDAF is not set
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-# CONFIG_SUSPEND is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-# CONFIG_STANDALONE is not set
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_SCSI=m
-# CONFIG_SCSI_PROC_FS is not set
-CONFIG_BLK_DEV_SD=m
-# CONFIG_SCSI_LOWLEVEL is not set
-CONFIG_NETDEVICES=y
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CHELSIO is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-CONFIG_STMMAC_ETH=y
-CONFIG_STMMAC_DA=y
-# CONFIG_NET_VENDOR_WIZNET is not set
-# CONFIG_WLAN is not set
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_LEGACY_PTY_COUNT=8
-# CONFIG_DEVKMEM is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_USB_HID=m
-CONFIG_HID_GENERIC=m
-CONFIG_USB=y
-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_HCD_PLATFORM=y
-# CONFIG_USB_EHCI_TT_NEWSCHED is not set
-CONFIG_USB_STORAGE=m
-CONFIG_USB_SERIAL=m
-CONFIG_USB_SERIAL_PL2303=m
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_LOONGSON1=y
-# CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_DNOTIFY is not set
-CONFIG_VFAT_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-# CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_CODEPAGE_437=m
-CONFIG_NLS_ISO8859_1=m
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_MAGIC_SYSRQ=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_PREEMPT is not set
-# CONFIG_FTRACE is not set
-# CONFIG_EARLY_PRINTK is not set
diff --git a/arch/mips/include/asm/mach-loongson32/cpufreq.h b/arch/mips/include/asm/mach-loongson32/cpufreq.h
index 6843fa1..2f1ecb0 100644
--- a/arch/mips/include/asm/mach-loongson32/cpufreq.h
+++ b/arch/mips/include/asm/mach-loongson32/cpufreq.h
@@ -9,7 +9,6 @@
  * option) any later version.
  */
 
-
 #ifndef __ASM_MACH_LOONGSON32_CPUFREQ_H
 #define __ASM_MACH_LOONGSON32_CPUFREQ_H
 
diff --git a/arch/mips/include/asm/mach-loongson32/dma.h b/arch/mips/include/asm/mach-loongson32/dma.h
new file mode 100644
index 0000000..ad1dec7
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson32/dma.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2015 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * Loongson 1 NAND platform support.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_LOONGSON32_DMA_H
+#define __ASM_MACH_LOONGSON32_DMA_H
+
+#define LS1X_DMA_CHANNEL0	0
+#define LS1X_DMA_CHANNEL1	1
+#define LS1X_DMA_CHANNEL2	2
+
+struct plat_ls1x_dma {
+	int nr_channels;
+};
+
+extern struct plat_ls1x_dma ls1b_dma_pdata;
+
+#endif /* __ASM_MACH_LOONGSON32_DMA_H */
diff --git a/arch/mips/include/asm/mach-loongson32/irq.h b/arch/mips/include/asm/mach-loongson32/irq.h
index 0d35b99..c1c7441 100644
--- a/arch/mips/include/asm/mach-loongson32/irq.h
+++ b/arch/mips/include/asm/mach-loongson32/irq.h
@@ -9,7 +9,6 @@
  * option) any later version.
  */
 
-
 #ifndef __ASM_MACH_LOONGSON32_IRQ_H
 #define __ASM_MACH_LOONGSON32_IRQ_H
 
diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 12aa129..978f6df 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -9,7 +9,6 @@
  * option) any later version.
  */
 
-
 #ifndef __ASM_MACH_LOONGSON32_LOONGSON1_H
 #define __ASM_MACH_LOONGSON32_LOONGSON1_H
 
@@ -18,6 +17,9 @@
 /* Loongson 1 Register Bases */
 #define LS1X_MUX_BASE			0x1fd00420
 #define LS1X_INTC_BASE			0x1fd01040
+#define LS1X_GPIO0_BASE			0x1fd010c0
+#define LS1X_GPIO1_BASE			0x1fd010c4
+#define LS1X_DMAC_BASE			0x1fd01160
 #define LS1X_EHCI_BASE			0x1fe00000
 #define LS1X_OHCI_BASE			0x1fe08000
 #define LS1X_GMAC0_BASE			0x1fe10000
diff --git a/arch/mips/include/asm/mach-loongson32/nand.h b/arch/mips/include/asm/mach-loongson32/nand.h
new file mode 100644
index 0000000..e274912
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson32/nand.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2015 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * Loongson 1 NAND platform support.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_LOONGSON32_NAND_H
+#define __ASM_MACH_LOONGSON32_NAND_H
+
+#include <linux/dmaengine.h>
+#include <linux/mtd/partitions.h>
+
+struct plat_ls1x_nand {
+	struct mtd_partition *parts;
+	unsigned int nr_parts;
+
+	int hold_cycle;
+	int wait_cycle;
+};
+
+extern struct plat_ls1x_nand ls1b_nand_pdata;
+
+bool ls1x_dma_filter_fn(struct dma_chan *chan, void *param);
+
+#endif /* __ASM_MACH_LOONGSON32_NAND_H */
diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index c32f03f..672531a 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -7,20 +7,28 @@
  * option) any later version.
  */
 
-
 #ifndef __ASM_MACH_LOONGSON32_PLATFORM_H
 #define __ASM_MACH_LOONGSON32_PLATFORM_H
 
 #include <linux/platform_device.h>
 
+#include <dma.h>
+#include <nand.h>
+
 extern struct platform_device ls1x_uart_pdev;
 extern struct platform_device ls1x_cpufreq_pdev;
+extern struct platform_device ls1x_dma_pdev;
 extern struct platform_device ls1x_eth0_pdev;
 extern struct platform_device ls1x_eth1_pdev;
 extern struct platform_device ls1x_ehci_pdev;
+extern struct platform_device ls1x_gpio0_pdev;
+extern struct platform_device ls1x_gpio1_pdev;
+extern struct platform_device ls1x_nand_pdev;
 extern struct platform_device ls1x_rtc_pdev;
 
-extern void __init ls1x_clk_init(void);
-extern void __init ls1x_serial_setup(struct platform_device *pdev);
+void __init ls1x_clk_init(void);
+void __init ls1x_dma_set_platdata(struct plat_ls1x_dma *pdata);
+void __init ls1x_nand_set_platdata(struct plat_ls1x_nand *pdata);
+void __init ls1x_serial_set_uartclk(struct platform_device *pdev);
 
 #endif /* __ASM_MACH_LOONGSON32_PLATFORM_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-clk.h b/arch/mips/include/asm/mach-loongson32/regs-clk.h
index 1f5a715..4d56fc3 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-clk.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-clk.h
@@ -19,18 +19,18 @@
 #define LS1X_CLK_PLL_DIV		LS1X_CLK_REG(0x4)
 
 /* Clock PLL Divisor Register Bits */
-#define DIV_DC_EN			(0x1 << 31)
-#define DIV_DC_RST			(0x1 << 30)
-#define DIV_CPU_EN			(0x1 << 25)
-#define DIV_CPU_RST			(0x1 << 24)
-#define DIV_DDR_EN			(0x1 << 19)
-#define DIV_DDR_RST			(0x1 << 18)
-#define RST_DC_EN			(0x1 << 5)
-#define RST_DC				(0x1 << 4)
-#define RST_DDR_EN			(0x1 << 3)
-#define RST_DDR				(0x1 << 2)
-#define RST_CPU_EN			(0x1 << 1)
-#define RST_CPU				0x1
+#define DIV_DC_EN			BIT(31)
+#define DIV_DC_RST			BIT(30)
+#define DIV_CPU_EN			BIT(25)
+#define DIV_CPU_RST			BIT(24)
+#define DIV_DDR_EN			BIT(19)
+#define DIV_DDR_RST			BIT(18)
+#define RST_DC_EN			BIT(5)
+#define RST_DC				BIT(4)
+#define RST_DDR_EN			BIT(3)
+#define RST_DDR				BIT(2)
+#define RST_CPU_EN			BIT(1)
+#define RST_CPU				BIT(0)
 
 #define DIV_DC_SHIFT			26
 #define DIV_CPU_SHIFT			20
diff --git a/arch/mips/include/asm/mach-loongson32/regs-mux.h b/arch/mips/include/asm/mach-loongson32/regs-mux.h
index 8302d92..7c394f9 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-mux.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-mux.h
@@ -19,49 +19,49 @@
 #define LS1X_MUX_CTRL1			LS1X_MUX_REG(0x4)
 
 /* MUX CTRL0 Register Bits */
-#define UART0_USE_PWM23			(0x1 << 28)
-#define UART0_USE_PWM01			(0x1 << 27)
-#define UART1_USE_LCD0_5_6_11		(0x1 << 26)
-#define I2C2_USE_CAN1			(0x1 << 25)
-#define I2C1_USE_CAN0			(0x1 << 24)
-#define NAND3_USE_UART5			(0x1 << 23)
-#define NAND3_USE_UART4			(0x1 << 22)
-#define NAND3_USE_UART1_DAT		(0x1 << 21)
-#define NAND3_USE_UART1_CTS		(0x1 << 20)
-#define NAND3_USE_PWM23			(0x1 << 19)
-#define NAND3_USE_PWM01			(0x1 << 18)
-#define NAND2_USE_UART5			(0x1 << 17)
-#define NAND2_USE_UART4			(0x1 << 16)
-#define NAND2_USE_UART1_DAT		(0x1 << 15)
-#define NAND2_USE_UART1_CTS		(0x1 << 14)
-#define NAND2_USE_PWM23			(0x1 << 13)
-#define NAND2_USE_PWM01			(0x1 << 12)
-#define NAND1_USE_UART5			(0x1 << 11)
-#define NAND1_USE_UART4			(0x1 << 10)
-#define NAND1_USE_UART1_DAT		(0x1 << 9)
-#define NAND1_USE_UART1_CTS		(0x1 << 8)
-#define NAND1_USE_PWM23			(0x1 << 7)
-#define NAND1_USE_PWM01			(0x1 << 6)
-#define GMAC1_USE_UART1			(0x1 << 4)
-#define GMAC1_USE_UART0			(0x1 << 3)
-#define LCD_USE_UART0_DAT		(0x1 << 2)
-#define LCD_USE_UART15			(0x1 << 1)
-#define LCD_USE_UART0			0x1
+#define UART0_USE_PWM23			BIT(28)
+#define UART0_USE_PWM01			BIT(27)
+#define UART1_USE_LCD0_5_6_11		BIT(26)
+#define I2C2_USE_CAN1			BIT(25)
+#define I2C1_USE_CAN0			BIT(24)
+#define NAND3_USE_UART5			BIT(23)
+#define NAND3_USE_UART4			BIT(22)
+#define NAND3_USE_UART1_DAT		BIT(21)
+#define NAND3_USE_UART1_CTS		BIT(20)
+#define NAND3_USE_PWM23			BIT(19)
+#define NAND3_USE_PWM01			BIT(18)
+#define NAND2_USE_UART5			BIT(17)
+#define NAND2_USE_UART4			BIT(16)
+#define NAND2_USE_UART1_DAT		BIT(15)
+#define NAND2_USE_UART1_CTS		BIT(14)
+#define NAND2_USE_PWM23			BIT(13)
+#define NAND2_USE_PWM01			BIT(12)
+#define NAND1_USE_UART5			BIT(11)
+#define NAND1_USE_UART4			BIT(10)
+#define NAND1_USE_UART1_DAT		BIT(9)
+#define NAND1_USE_UART1_CTS		BIT(8)
+#define NAND1_USE_PWM23			BIT(7)
+#define NAND1_USE_PWM01			BIT(6)
+#define GMAC1_USE_UART1			BIT(4)
+#define GMAC1_USE_UART0			BIT(3)
+#define LCD_USE_UART0_DAT		BIT(2)
+#define LCD_USE_UART15			BIT(1)
+#define LCD_USE_UART0			BIT(0)
 
 /* MUX CTRL1 Register Bits */
-#define USB_RESET			(0x1 << 31)
-#define SPI1_CS_USE_PWM01		(0x1 << 24)
-#define SPI1_USE_CAN			(0x1 << 23)
-#define DISABLE_DDR_CONFSPACE		(0x1 << 20)
-#define DDR32TO16EN			(0x1 << 16)
-#define GMAC1_SHUT			(0x1 << 13)
-#define GMAC0_SHUT			(0x1 << 12)
-#define USB_SHUT			(0x1 << 11)
-#define UART1_3_USE_CAN1		(0x1 << 5)
-#define UART1_2_USE_CAN0		(0x1 << 4)
-#define GMAC1_USE_TXCLK			(0x1 << 3)
-#define GMAC0_USE_TXCLK			(0x1 << 2)
-#define GMAC1_USE_PWM23			(0x1 << 1)
-#define GMAC0_USE_PWM01			0x1
+#define USB_RESET			BIT(31)
+#define SPI1_CS_USE_PWM01		BIT(24)
+#define SPI1_USE_CAN			BIT(23)
+#define DISABLE_DDR_CONFSPACE		BIT(20)
+#define DDR32TO16EN			BIT(16)
+#define GMAC1_SHUT			BIT(13)
+#define GMAC0_SHUT			BIT(12)
+#define USB_SHUT			BIT(11)
+#define UART1_3_USE_CAN1		BIT(5)
+#define UART1_2_USE_CAN0		BIT(4)
+#define GMAC1_USE_TXCLK			BIT(3)
+#define GMAC0_USE_TXCLK			BIT(2)
+#define GMAC1_USE_PWM23			BIT(1)
+#define GMAC0_USE_PWM01			BIT(0)
 
 #endif /* __ASM_MACH_LOONGSON32_REGS_MUX_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-pwm.h b/arch/mips/include/asm/mach-loongson32/regs-pwm.h
index 69f174e..4119600 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-pwm.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-pwm.h
@@ -19,11 +19,11 @@
 #define PWM_CTRL		0xc
 
 /* PWM Control Register Bits */
-#define CNT_RST			(0x1 << 7)
-#define INT_SR			(0x1 << 6)
-#define INT_EN			(0x1 << 5)
-#define PWM_SINGLE		(0x1 << 4)
-#define PWM_OE			(0x1 << 3)
-#define CNT_EN			0x1
+#define CNT_RST			BIT(7)
+#define INT_SR			BIT(6)
+#define INT_EN			BIT(5)
+#define PWM_SINGLE		BIT(4)
+#define PWM_OE			BIT(3)
+#define CNT_EN			BIT(0)
 
 #endif /* __ASM_MACH_LOONGSON32_REGS_PWM_H */
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index ddf1d4c..f2c714d 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2011-2016 Zhang, Keguang <keguang.zhang@gmail.com>
  *
  * This program is free software; you can redistribute	it and/or modify it
  * under  the terms of	the GNU General	 Public License as published by the
@@ -10,14 +10,17 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
+#include <linux/mtd/partitions.h>
+#include <linux/sizes.h>
 #include <linux/phy.h>
 #include <linux/serial_8250.h>
 #include <linux/stmmac.h>
 #include <linux/usb/ehci_pdriver.h>
-#include <asm-generic/sizes.h>
 
-#include <cpufreq.h>
 #include <loongson1.h>
+#include <cpufreq.h>
+#include <dma.h>
+#include <nand.h>
 
 /* 8250/16550 compatible UART */
 #define LS1X_UART(_id)						\
@@ -45,7 +48,7 @@ struct platform_device ls1x_uart_pdev = {
 	},
 };
 
-void __init ls1x_serial_setup(struct platform_device *pdev)
+void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
 {
 	struct clk *clk;
 	struct plat_serial8250_port *p;
@@ -77,6 +80,42 @@ struct platform_device ls1x_cpufreq_pdev = {
 	},
 };
 
+/* DMA */
+static struct resource ls1x_dma_resources[] = {
+	[0] = {
+		.start = LS1X_DMAC_BASE,
+		.end = LS1X_DMAC_BASE + SZ_4 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = LS1X_DMA0_IRQ,
+		.end = LS1X_DMA0_IRQ,
+		.flags = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start = LS1X_DMA1_IRQ,
+		.end = LS1X_DMA1_IRQ,
+		.flags = IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start = LS1X_DMA2_IRQ,
+		.end = LS1X_DMA2_IRQ,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ls1x_dma_pdev = {
+	.name		= "ls1x-dma",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_dma_resources),
+	.resource	= ls1x_dma_resources,
+};
+
+void __init ls1x_dma_set_platdata(struct plat_ls1x_dma *pdata)
+{
+	ls1x_dma_pdev.dev.platform_data = pdata;
+}
+
 /* Synopsys Ethernet GMAC */
 static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
 	.phy_mask	= 0,
@@ -198,6 +237,64 @@ struct platform_device ls1x_eth1_pdev = {
 	},
 };
 
+/* GPIO */
+static struct resource ls1x_gpio0_resources[] = {
+	[0] = {
+		.start	= LS1X_GPIO0_BASE,
+		.end	= LS1X_GPIO0_BASE + SZ_4 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device ls1x_gpio0_pdev = {
+	.name		= "ls1x-gpio",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ls1x_gpio0_resources),
+	.resource	= ls1x_gpio0_resources,
+};
+
+static struct resource ls1x_gpio1_resources[] = {
+	[0] = {
+		.start	= LS1X_GPIO1_BASE,
+		.end	= LS1X_GPIO1_BASE + SZ_4 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device ls1x_gpio1_pdev = {
+	.name		= "ls1x-gpio",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(ls1x_gpio1_resources),
+	.resource	= ls1x_gpio1_resources,
+};
+
+/* NAND Flash */
+static struct resource ls1x_nand_resources[] = {
+	[0] = {
+		.start	= LS1X_NAND_BASE,
+		.end	= LS1X_NAND_BASE + SZ_32 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* DMA channel 0 is dedicated to NAND */
+		.start	= LS1X_DMA_CHANNEL0,
+		.end	= LS1X_DMA_CHANNEL0,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct platform_device ls1x_nand_pdev = {
+	.name		= "ls1x-nand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_nand_resources),
+	.resource	= ls1x_nand_resources,
+};
+
+void __init ls1x_nand_set_platdata(struct plat_ls1x_nand *pdata)
+{
+	ls1x_nand_pdev.dev.platform_data = pdata;
+}
+
 /* USB EHCI */
 static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
 
diff --git a/arch/mips/loongson32/common/reset.c b/arch/mips/loongson32/common/reset.c
index c41e4ca..8a1d9cc 100644
--- a/arch/mips/loongson32/common/reset.c
+++ b/arch/mips/loongson32/common/reset.c
@@ -9,12 +9,13 @@
 
 #include <linux/io.h>
 #include <linux/pm.h>
+#include <linux/sizes.h>
 #include <asm/idle.h>
 #include <asm/reboot.h>
 
 #include <loongson1.h>
 
-static void __iomem *wdt_base;
+static void __iomem *wdt_reg_base;
 
 static void ls1x_halt(void)
 {
@@ -26,9 +27,9 @@ static void ls1x_halt(void)
 
 static void ls1x_restart(char *command)
 {
-	__raw_writel(0x1, wdt_base + WDT_EN);
-	__raw_writel(0x1, wdt_base + WDT_TIMER);
-	__raw_writel(0x1, wdt_base + WDT_SET);
+	__raw_writel(0x1, wdt_reg_base + WDT_EN);
+	__raw_writel(0x1, wdt_reg_base + WDT_TIMER);
+	__raw_writel(0x1, wdt_reg_base + WDT_SET);
 
 	ls1x_halt();
 }
@@ -40,8 +41,8 @@ static void ls1x_power_off(void)
 
 static int __init ls1x_reboot_setup(void)
 {
-	wdt_base = ioremap_nocache(LS1X_WDT_BASE, 0x0f);
-	if (!wdt_base)
+	wdt_reg_base = ioremap_nocache(LS1X_WDT_BASE, (SZ_4 + SZ_8));
+	if (!wdt_reg_base)
 		panic("Failed to remap watchdog registers");
 
 	_machine_restart = ls1x_restart;
diff --git a/arch/mips/loongson32/common/time.c b/arch/mips/loongson32/common/time.c
index 0996b02..ff224f0 100644
--- a/arch/mips/loongson32/common/time.c
+++ b/arch/mips/loongson32/common/time.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/interrupt.h>
+#include <linux/sizes.h>
 #include <asm/time.h>
 
 #include <loongson1.h>
@@ -35,25 +36,25 @@
 
 DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
 
-static void __iomem *timer_base;
+static void __iomem *timer_reg_base;
 static uint32_t ls1x_jiffies_per_tick;
 
 static inline void ls1x_pwmtimer_set_period(uint32_t period)
 {
-	__raw_writel(period, timer_base + PWM_HRC);
-	__raw_writel(period, timer_base + PWM_LRC);
+	__raw_writel(period, timer_reg_base + PWM_HRC);
+	__raw_writel(period, timer_reg_base + PWM_LRC);
 }
 
 static inline void ls1x_pwmtimer_restart(void)
 {
-	__raw_writel(0x0, timer_base + PWM_CNT);
-	__raw_writel(INT_EN | CNT_EN, timer_base + PWM_CTRL);
+	__raw_writel(0x0, timer_reg_base + PWM_CNT);
+	__raw_writel(INT_EN | CNT_EN, timer_reg_base + PWM_CTRL);
 }
 
 void __init ls1x_pwmtimer_init(void)
 {
-	timer_base = ioremap(LS1X_TIMER_BASE, 0xf);
-	if (!timer_base)
+	timer_reg_base = ioremap_nocache(LS1X_TIMER_BASE, SZ_16);
+	if (!timer_reg_base)
 		panic("Failed to remap timer registers");
 
 	ls1x_jiffies_per_tick = DIV_ROUND_CLOSEST(mips_hpt_frequency, HZ);
@@ -86,7 +87,7 @@ static cycle_t ls1x_clocksource_read(struct clocksource *cs)
 	 */
 	jifs = jiffies;
 	/* read the count */
-	count = __raw_readl(timer_base + PWM_CNT);
+	count = __raw_readl(timer_reg_base + PWM_CNT);
 
 	/*
 	 * It's possible for count to appear to go the wrong way for this
@@ -131,7 +132,7 @@ static int ls1x_clockevent_set_state_periodic(struct clock_event_device *cd)
 	raw_spin_lock(&ls1x_timer_lock);
 	ls1x_pwmtimer_set_period(ls1x_jiffies_per_tick);
 	ls1x_pwmtimer_restart();
-	__raw_writel(INT_EN | CNT_EN, timer_base + PWM_CTRL);
+	__raw_writel(INT_EN | CNT_EN, timer_reg_base + PWM_CTRL);
 	raw_spin_unlock(&ls1x_timer_lock);
 
 	return 0;
@@ -140,7 +141,7 @@ static int ls1x_clockevent_set_state_periodic(struct clock_event_device *cd)
 static int ls1x_clockevent_tick_resume(struct clock_event_device *cd)
 {
 	raw_spin_lock(&ls1x_timer_lock);
-	__raw_writel(INT_EN | CNT_EN, timer_base + PWM_CTRL);
+	__raw_writel(INT_EN | CNT_EN, timer_reg_base + PWM_CTRL);
 	raw_spin_unlock(&ls1x_timer_lock);
 
 	return 0;
@@ -149,8 +150,8 @@ static int ls1x_clockevent_tick_resume(struct clock_event_device *cd)
 static int ls1x_clockevent_set_state_shutdown(struct clock_event_device *cd)
 {
 	raw_spin_lock(&ls1x_timer_lock);
-	__raw_writel(__raw_readl(timer_base + PWM_CTRL) & ~CNT_EN,
-		     timer_base + PWM_CTRL);
+	__raw_writel(__raw_readl(timer_reg_base + PWM_CTRL) & ~CNT_EN,
+		     timer_reg_base + PWM_CTRL);
 	raw_spin_unlock(&ls1x_timer_lock);
 
 	return 0;
@@ -220,7 +221,7 @@ void __init plat_time_init(void)
 
 #ifdef CONFIG_CEVT_CSRC_LS1X
 	/* setup LS1X PWM timer */
-	clk = clk_get(NULL, "ls1x_pwmtimer");
+	clk = clk_get(NULL, "ls1x-pwmtimer");
 	if (IS_ERR(clk))
 		panic("unable to get timer clock, err=%ld", PTR_ERR(clk));
 
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index 58daeea..38a1d40 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2011-2016 Zhang, Keguang <keguang.zhang@gmail.com>
  *
  * This program is free software; you can redistribute	it and/or modify it
  * under  the terms of	the GNU General	 Public License as published by the
@@ -7,26 +7,83 @@
  * option) any later version.
  */
 
+#include <linux/leds.h>
+#include <linux/mtd/partitions.h>
+#include <linux/sizes.h>
+
+#include <loongson1.h>
+#include <dma.h>
+#include <nand.h>
 #include <platform.h>
 
+struct plat_ls1x_dma ls1x_dma_pdata = {
+	.nr_channels	= 3,
+};
+
+static struct mtd_partition ls1x_nand_parts[] = {
+	{
+		.name        = "kernel",
+		.offset      = 0,
+		.size        = SZ_16M,
+	},
+	{
+		.name        = "rootfs",
+		.offset      = MTDPART_OFS_APPEND,
+		.size        = MTDPART_SIZ_FULL,
+	},
+};
+
+struct plat_ls1x_nand ls1x_nand_pdata = {
+	.parts		= ls1x_nand_parts,
+	.nr_parts	= ARRAY_SIZE(ls1x_nand_parts),
+	.hold_cycle	= 0x2,
+	.wait_cycle	= 0xc,
+};
+
+static const struct gpio_led ls1x_gpio_leds[] __initconst = {
+	{
+		.name			= "LED9",
+		.default_trigger	= "heartbeat",
+		.gpio			= 38,
+		.active_low		= 1,
+		.default_state		= LEDS_GPIO_DEFSTATE_OFF,
+	}, {
+		.name			= "LED6",
+		.default_trigger	= "nand-disk",
+		.gpio			= 39,
+		.active_low		= 1,
+		.default_state		= LEDS_GPIO_DEFSTATE_OFF,
+	},
+};
+
+static const struct gpio_led_platform_data ls1x_led_pdata __initconst = {
+	.num_leds	= ARRAY_SIZE(ls1x_gpio_leds),
+	.leds		= ls1x_gpio_leds,
+};
+
 static struct platform_device *ls1b_platform_devices[] __initdata = {
 	&ls1x_uart_pdev,
 	&ls1x_cpufreq_pdev,
+	&ls1x_dma_pdev,
 	&ls1x_eth0_pdev,
 	&ls1x_eth1_pdev,
 	&ls1x_ehci_pdev,
+	&ls1x_gpio0_pdev,
+	&ls1x_gpio1_pdev,
+	&ls1x_nand_pdev,
 	&ls1x_rtc_pdev,
 };
 
 static int __init ls1b_platform_init(void)
 {
-	int err;
+	ls1x_serial_set_uartclk(&ls1x_uart_pdev);
+	ls1x_dma_set_platdata(&ls1x_dma_pdata);
+	ls1x_nand_set_platdata(&ls1x_nand_pdata);
 
-	ls1x_serial_setup(&ls1x_uart_pdev);
+	gpio_led_register_device(-1, &ls1x_led_pdata);
 
-	err = platform_add_devices(ls1b_platform_devices,
+	return platform_add_devices(ls1b_platform_devices,
 				   ARRAY_SIZE(ls1b_platform_devices));
-	return err;
 }
 
 arch_initcall(ls1b_platform_init);
-- 
1.9.1

