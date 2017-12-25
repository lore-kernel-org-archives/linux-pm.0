From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/5] ARM: S3C64XX: Add SPDX license identifier
Date: Mon, 25 Dec 2017 20:54:33 +0100
Message-ID: <1514231675-17582-3-git-send-email-krzk@kernel.org>
References: <1514231675-17582-1-git-send-email-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753034AbdLYTzA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Dec 2017 14:55:00 -0500
In-Reply-To: <1514231675-17582-1-git-send-email-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Ombredanne <pombredanne@nexb.com>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Simtec Linux Team <linux@simtec.co.uk>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, patches@opensource.cirrus.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Replace GPL license statements with a SPDX license indentifiers (GPL-2.0
and GPL-2.0+).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c64xx/Kconfig                     |  5 +++--
 arch/arm/mach-s3c64xx/Makefile                    |  4 +---
 arch/arm/mach-s3c64xx/ata-core.h                  |  7 ++----
 arch/arm/mach-s3c64xx/backlight.h                 |  5 +----
 arch/arm/mach-s3c64xx/common.c                    | 26 ++++++++++-------------
 arch/arm/mach-s3c64xx/common.h                    |  5 +----
 arch/arm/mach-s3c64xx/cpuidle.c                   | 15 +++++--------
 arch/arm/mach-s3c64xx/crag6410.h                  |  5 +----
 arch/arm/mach-s3c64xx/dev-audio.c                 | 13 ++++--------
 arch/arm/mach-s3c64xx/dev-backlight.c             | 16 ++++++--------
 arch/arm/mach-s3c64xx/dev-uart.c                  | 22 +++++++------------
 arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h |  7 ++----
 arch/arm/mach-s3c64xx/include/mach/hardware.h     |  1 +
 arch/arm/mach-s3c64xx/include/mach/map.h          | 10 +++------
 arch/arm/mach-s3c64xx/include/mach/pm-core.h      |  8 ++-----
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h   | 10 +++------
 arch/arm/mach-s3c64xx/include/mach/regs-irq.h     | 10 +++------
 arch/arm/mach-s3c64xx/irq-pm.c                    | 21 +++++++-----------
 arch/arm/mach-s3c64xx/irq-uart.h                  |  7 ++----
 arch/arm/mach-s3c64xx/mach-anw6410.c              | 22 +++++++------------
 arch/arm/mach-s3c64xx/mach-crag6410-module.c      | 15 ++++++-------
 arch/arm/mach-s3c64xx/mach-crag6410.c             | 19 ++++++-----------
 arch/arm/mach-s3c64xx/mach-hmt.c                  | 14 +++++-------
 arch/arm/mach-s3c64xx/mach-mini6410.c             | 20 ++++++-----------
 arch/arm/mach-s3c64xx/mach-ncp.c                  | 13 +++---------
 arch/arm/mach-s3c64xx/mach-real6410.c             | 20 ++++++-----------
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c           | 14 +++++-------
 arch/arm/mach-s3c64xx/mach-smartq.c               | 13 +++---------
 arch/arm/mach-s3c64xx/mach-smartq.h               |  6 +-----
 arch/arm/mach-s3c64xx/mach-smartq5.c              | 13 +++---------
 arch/arm/mach-s3c64xx/mach-smartq7.c              | 13 +++---------
 arch/arm/mach-s3c64xx/mach-smdk6400.c             | 15 +++++--------
 arch/arm/mach-s3c64xx/mach-smdk6410.c             | 18 ++++++----------
 arch/arm/mach-s3c64xx/onenand-core.h              |  7 ++----
 arch/arm/mach-s3c64xx/pl080.c                     | 14 +++++-------
 arch/arm/mach-s3c64xx/pm.c                        | 21 +++++++-----------
 arch/arm/mach-s3c64xx/regs-modem.h                |  7 ++----
 arch/arm/mach-s3c64xx/regs-srom.h                 |  7 ++----
 arch/arm/mach-s3c64xx/s3c6400.c                   | 15 +++++--------
 arch/arm/mach-s3c64xx/s3c6410.c                   | 17 ++++++---------
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c            | 21 +++++++-----------
 arch/arm/mach-s3c64xx/setup-i2c0.c                | 21 +++++++-----------
 arch/arm/mach-s3c64xx/setup-i2c1.c                | 21 +++++++-----------
 arch/arm/mach-s3c64xx/setup-ide.c                 | 17 ++++++---------
 arch/arm/mach-s3c64xx/setup-keypad.c              | 17 ++++++---------
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c          | 19 ++++++-----------
 arch/arm/mach-s3c64xx/setup-spi.c                 | 13 ++++--------
 arch/arm/mach-s3c64xx/setup-usb-phy.c             | 14 ++++--------
 arch/arm/mach-s3c64xx/sleep.S                     |  7 ++----
 arch/arm/mach-s3c64xx/watchdog-reset.h            |  7 ++----
 50 files changed, 221 insertions(+), 436 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index afd1f20be49e..5700822e3c74 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -1,7 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
 # Copyright 2008 Openmoko, Inc.
 #	Simtec Electronics, Ben Dooks <ben@simtec.co.uk>
-#
-# Licensed under GPLv2
+
 menuconfig ARCH_S3C64XX
 	bool "Samsung S3C64XX"
 	depends on ARCH_MULTI_V6
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 256cd5b40c60..8caeb4ad17e9 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -1,9 +1,7 @@
-# arch/arm/mach-s3c64xx/Makefile
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright 2008 Openmoko, Inc.
 # Copyright 2008 Simtec Electronics
-#
-# Licensed under GPLv2
 
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
 asflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
diff --git a/arch/arm/mach-s3c64xx/ata-core.h b/arch/arm/mach-s3c64xx/ata-core.h
index 5951f24a9ec8..6d9a81f759e6 100644
--- a/arch/arm/mach-s3c64xx/ata-core.h
+++ b/arch/arm/mach-s3c64xx/ata-core.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Samsung CF-ATA Controller core functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_PLAT_ATA_CORE_H
 #define __ASM_PLAT_ATA_CORE_H __FILE__
diff --git a/arch/arm/mach-s3c64xx/backlight.h b/arch/arm/mach-s3c64xx/backlight.h
index 8dcacac523a2..028663f1cacc 100644
--- a/arch/arm/mach-s3c64xx/backlight.h
+++ b/arch/arm/mach-s3c64xx/backlight.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *              http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __ASM_PLAT_BACKLIGHT_H
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 9843eb4dd04e..13e91074308a 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -1,18 +1,14 @@
-/*
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Common Codes for S3C64XX machines
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// Common Codes for S3C64XX machines
 
 /*
  * NOTE: Code in this file is not used when booting with Device Tree support.
diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
index 4f204668f00e..03670887a764 100644
--- a/arch/arm/mach-s3c64xx/common.h
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -8,10 +9,6 @@
  *	http://armlinux.simtec.co.uk/
  *
  * Common Header for S3C64XX machines
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __ARCH_ARM_MACH_S3C64XX_COMMON_H
diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index 5322db51150e..0bac6f6413b0 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -1,13 +1,8 @@
-/* linux/arch/arm/mach-s3c64xx/cpuidle.c
- *
- * Copyright (c) 2011 Wolfson Microelectronics, plc
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011 Wolfson Microelectronics, plc
+// Copyright (c) 2011 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-s3c64xx/crag6410.h b/arch/arm/mach-s3c64xx/crag6410.h
index dcbe17f5e5f8..00d9aa114aa7 100644
--- a/arch/arm/mach-s3c64xx/crag6410.h
+++ b/arch/arm/mach-s3c64xx/crag6410.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Cragganmore 6410 shared definitions
  *
  * Copyright 2011 Wolfson Microelectronics plc
  *	Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef MACH_CRAG6410_H
diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index cb953e238b2a..e3c49b5d1355 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -1,12 +1,7 @@
-/* linux/arch/arm/plat-s3c/dev-audio.c
- *
- * Copyright 2009 Wolfson Microelectronics
- *      Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2009 Wolfson Microelectronics
+//      Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/kernel.h>
 #include <linux/string.h>
diff --git a/arch/arm/mach-s3c64xx/dev-backlight.c b/arch/arm/mach-s3c64xx/dev-backlight.c
index 7ef8b9019344..799cfdf0606b 100644
--- a/arch/arm/mach-s3c64xx/dev-backlight.c
+++ b/arch/arm/mach-s3c64xx/dev-backlight.c
@@ -1,13 +1,9 @@
-/*
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *              http://www.samsung.com
- *
- * Common infrastructure for PWM Backlight for Samsung boards
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011 Samsung Electronics Co., Ltd.
+//              http://www.samsung.com
+//
+// Common infrastructure for PWM Backlight for Samsung boards
 
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-s3c64xx/dev-uart.c b/arch/arm/mach-s3c64xx/dev-uart.c
index a0b4f0329811..5fb59ad30008 100644
--- a/arch/arm/mach-s3c64xx/dev-uart.c
+++ b/arch/arm/mach-s3c64xx/dev-uart.c
@@ -1,17 +1,11 @@
-/* linux/arch/arm/plat-s3c64xx/dev-uart.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Base S3C64XX UART resource and device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// Base S3C64XX UART resource and device definitions
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h
index 1d3636512e33..8ed144a0d474 100644
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
@@ -5,11 +6,7 @@
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C6400 - GPIO lib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef GPIO_SAMSUNG_S3C64XX_H
 #define GPIO_SAMSUNG_S3C64XX_H
diff --git a/arch/arm/mach-s3c64xx/include/mach/hardware.h b/arch/arm/mach-s3c64xx/include/mach/hardware.h
index 862d033e57a4..c4ed359474de 100644
--- a/arch/arm/mach-s3c64xx/include/mach/hardware.h
+++ b/arch/arm/mach-s3c64xx/include/mach/hardware.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* linux/arch/arm/mach-s3c6400/include/mach/hardware.h
  *
  * Copyright 2008 Openmoko, Inc.
diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
index d51873e8f63f..9372a535b7ba 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -1,16 +1,12 @@
-/* linux/arch/arm/mach-s3c6400/include/mach/map.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C64XX - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_ARCH_MAP_H
 #define __ASM_ARCH_MAP_H __FILE__
diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
index 4a285e97afff..bbf79ed28583 100644
--- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
@@ -1,15 +1,11 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/pm-core.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *      Ben Dooks <ben@simtec.co.uk>
  *      http://armlinux.simtec.co.uk/
  *
  * S3C64XX - PM core support for arch/arm/plat-s3c/pm.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __MACH_S3C64XX_PM_CORE_H
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
index 4f44aac77092..35a68767b318 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
@@ -1,16 +1,12 @@
-/* arch/arm/plat-s3c64xx/include/plat/regs-clock.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *	http://armlinux.simtec.co.uk/
  *
  * S3C64XX clock register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __PLAT_REGS_CLOCK_H
 #define __PLAT_REGS_CLOCK_H __FILE__
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-irq.h b/arch/arm/mach-s3c64xx/include/mach/regs-irq.h
index 6a1127891c87..b18c7bcb61c5 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-irq.h
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-irq.h
@@ -1,16 +1,12 @@
-/* linux/arch/arm/mach-s3c6400/include/mach/regs-irq.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C64XX - IRQ register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_ARCH_REGS_IRQ_H
 #define __ASM_ARCH_REGS_IRQ_H __FILE__
diff --git a/arch/arm/mach-s3c64xx/irq-pm.c b/arch/arm/mach-s3c64xx/irq-pm.c
index 0bbf1faaee42..31b221190479 100644
--- a/arch/arm/mach-s3c64xx/irq-pm.c
+++ b/arch/arm/mach-s3c64xx/irq-pm.c
@@ -1,16 +1,11 @@
-/* arch/arm/plat-s3c64xx/irq-pm.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C64XX - Interrupt handling Power Management
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//      Ben Dooks <ben@simtec.co.uk>
+//      http://armlinux.simtec.co.uk/
+//
+// S3C64XX - Interrupt handling Power Management
 
 /*
  * NOTE: Code in this file is not used when booting with Device Tree support.
diff --git a/arch/arm/mach-s3c64xx/irq-uart.h b/arch/arm/mach-s3c64xx/irq-uart.h
index 4b296132962f..78eccdce95a7 100644
--- a/arch/arm/mach-s3c64xx/irq-uart.h
+++ b/arch/arm/mach-s3c64xx/irq-uart.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2010 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * Header file for Samsung SoC UART IRQ demux for S3C64XX and later
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 struct s3c_uart_irq {
 	void __iomem	*regs;
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 347ce6009a8c..0d3d5befb806 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -1,17 +1,11 @@
-/* linux/arch/arm/mach-s3c64xx/mach-anw6410.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- * Copyright 2009 Kwangwoo Lee
- * 	Kwangwoo Lee <kwangwoo.lee@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+// Copyright 2009 Kwangwoo Lee
+//	Kwangwoo Lee <kwangwoo.lee@gmail.com>
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index ea5f2169c850..29ed7b7bafb6 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -1,12 +1,9 @@
-/* Speyside modules for Cragganmore - board data probing
- *
- * Copyright 2011 Wolfson Microelectronics plc
- *	Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+//Speyside modules for Cragganmore - board data probing
+//
+// Copyright 2011 Wolfson Microelectronics plc
+//	Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/export.h>
 #include <linux/interrupt.h>
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index d9d0440aed78..f04650297487 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -1,15 +1,10 @@
-/* linux/arch/arm/mach-s3c64xx/mach-crag6410.c
- *
- * Copyright 2011 Wolfson Microelectronics plc
- *	Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * Copyright 2011 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2011 Wolfson Microelectronics plc
+//	Mark Brown <broonie@opensource.wolfsonmicro.com>
+//
+// Copyright 2011 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
 
 #include <linux/kernel.h>
 #include <linux/list.h>
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 59b5531f1987..bfe9881d12cc 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -1,12 +1,8 @@
-/* mach-hmt.c - Platform code for Airgoo HMT
- *
- * Copyright 2009 Peter Korsgaard <jacmet@sunsite.dk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// mach-hmt.c - Platform code for Airgoo HMT
+//
+// Copyright 2009 Peter Korsgaard <jacmet@sunsite.dk>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index a3e3e25728b4..0dd36ae49e6a 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -1,16 +1,10 @@
-/* linux/arch/arm/mach-s3c64xx/mach-mini6410.c
- *
- * Copyright 2010 Darius Augulis <augulis.darius@gmail.com>
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2010 Darius Augulis <augulis.darius@gmail.com>
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 23baaa04318c..13fea5c86ca3 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -1,13 +1,6 @@
-/*
- * linux/arch/arm/mach-s3c64xx/mach-ncp.c
- *
- * Copyright (C) 2008-2009 Samsung Electronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2008-2009 Samsung Electronics
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index d6b3ffd7704b..0ff88b6859c4 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -1,16 +1,10 @@
-/* linux/arch/arm/mach-s3c64xx/mach-real6410.c
- *
- * Copyright 2010 Darius Augulis <augulis.darius@gmail.com>
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2010 Darius Augulis <augulis.darius@gmail.com>
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
index 5bf9afae752d..1724f5ea5c46 100644
--- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
+++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
@@ -1,12 +1,8 @@
-/*
- * Samsung's S3C64XX flattened device tree enabled machine
- *
- * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Samsung's S3C64XX flattened device tree enabled machine
+//
+// Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index e0e1a729ef98..5655fe968b1f 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -1,13 +1,6 @@
-/*
- * linux/arch/arm/mach-s3c64xx/mach-smartq.c
- *
- * Copyright (C) 2010 Maurus Cuelenaere
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2010 Maurus Cuelenaere
 
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.h b/arch/arm/mach-s3c64xx/mach-smartq.h
index 8e8b693db3af..f98132f4f430 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.h
+++ b/arch/arm/mach-s3c64xx/mach-smartq.h
@@ -1,12 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * linux/arch/arm/mach-s3c64xx/mach-smartq.h
  *
  * Copyright (C) 2010 Maurus Cuelenaere
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #ifndef __MACH_SMARTQ_H
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 0972b6ce0ef6..44e9edb144fa 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -1,13 +1,6 @@
-/*
- * linux/arch/arm/mach-s3c64xx/mach-smartq5.c
- *
- * Copyright (C) 2010 Maurus Cuelenaere
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2010 Maurus Cuelenaere
 
 #include <linux/fb.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 51ac1c6c654a..815ee7d0b5e3 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -1,13 +1,6 @@
-/*
- * linux/arch/arm/mach-s3c64xx/mach-smartq7.c
- *
- * Copyright (C) 2010 Maurus Cuelenaere
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2010 Maurus Cuelenaere
 
 #include <linux/fb.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 7d8a74fd8915..cbd16843c7d1 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -1,13 +1,8 @@
-/* linux/arch/arm/mach-s3c64xx/mach-smdk6400.c
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 92ec8c3b42b9..c46fa5dfd2e0 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -1,15 +1,9 @@
-/* linux/arch/arm/mach-s3c64xx/mach-smdk6410.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c64xx/onenand-core.h b/arch/arm/mach-s3c64xx/onenand-core.h
index 925eb13bbb60..0cf6b5e76b24 100644
--- a/arch/arm/mach-s3c64xx/onenand-core.h
+++ b/arch/arm/mach-s3c64xx/onenand-core.h
@@ -1,14 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  Copyright (c) 2010 Samsung Electronics
  *  Kyungmin Park <kyungmin.park@samsung.com>
  *  Marek Szyprowski <m.szyprowski@samsung.com>
  *
  * Samsung OneNAD Controller core functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_ARCH_ONENAND_CORE_H
 #define __ASM_ARCH_ONENAND_CORE_H __FILE__
diff --git a/arch/arm/mach-s3c64xx/pl080.c b/arch/arm/mach-s3c64xx/pl080.c
index 66fc774b70ec..152edbeea0c7 100644
--- a/arch/arm/mach-s3c64xx/pl080.c
+++ b/arch/arm/mach-s3c64xx/pl080.c
@@ -1,12 +1,8 @@
-/*
- * Samsung's S3C64XX generic DMA support using amba-pl08x driver.
- *
- * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Samsung's S3C64XX generic DMA support using amba-pl08x driver.
+//
+// Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
 
 #include <linux/kernel.h>
 #include <linux/amba/bus.h>
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 2f579be8fe67..fd6dbb263ed5 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/plat-s3c64xx/pm.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C64XX CPU PM support.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// S3C64XX CPU PM support.
 
 #include <linux/init.h>
 #include <linux/suspend.h>
diff --git a/arch/arm/mach-s3c64xx/regs-modem.h b/arch/arm/mach-s3c64xx/regs-modem.h
index 073cdd3a03be..136ad44291bf 100644
--- a/arch/arm/mach-s3c64xx/regs-modem.h
+++ b/arch/arm/mach-s3c64xx/regs-modem.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
@@ -5,11 +6,7 @@
  *      Ben Dooks <ben@simtec.co.uk>
  *
  * S3C64XX - modem block registers
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __MACH_S3C64XX_REGS_MODEM_H
 #define __MACH_S3C64XX_REGS_MODEM_H __FILE__
diff --git a/arch/arm/mach-s3c64xx/regs-srom.h b/arch/arm/mach-s3c64xx/regs-srom.h
index d56f3386eb00..2b37988bdf94 100644
--- a/arch/arm/mach-s3c64xx/regs-srom.h
+++ b/arch/arm/mach-s3c64xx/regs-srom.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2009 Andy Green <andy@warmcat.com>
  *
  * S3C64XX SROM definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __MACH_S3C64XX_REGS_SROM_H
 #define __MACH_S3C64XX_REGS_SROM_H __FILE__
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 5ea82accc773..545eea716db8 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -1,13 +1,8 @@
-/* linux/arch/arm/mach-s3c64xx/cpu.c
- *
- * Copyright 2009 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2009 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
 
 /*
  * NOTE: Code in this file is not used when booting with Device Tree support.
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 92bb927c4478..47e04e019624 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c64xx/s3c6410.c
- *
- * Copyright 2008 Simtec Electronics
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Simtec Electronics
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
 
 /*
  * NOTE: Code in this file is not used when booting with Device Tree support.
diff --git a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
index 9d17bff12d4d..2c7178b26ebb 100644
--- a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
+++ b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/plat-s3c64xx/setup-fb-24bpp.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Base S3C64XX setup information for 24bpp LCD framebuffer
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// Base S3C64XX setup information for 24bpp LCD framebuffer
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c64xx/setup-i2c0.c b/arch/arm/mach-s3c64xx/setup-i2c0.c
index 4b8c1cfdd1fc..552eb50da38c 100644
--- a/arch/arm/mach-s3c64xx/setup-i2c0.c
+++ b/arch/arm/mach-s3c64xx/setup-i2c0.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/plat-s3c64xx/setup-i2c0.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Base S3C64XX I2C bus 0 gpio configuration
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// Base S3C64XX I2C bus 0 gpio configuration
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c64xx/setup-i2c1.c b/arch/arm/mach-s3c64xx/setup-i2c1.c
index cd1df71ee13b..d231f0fc508d 100644
--- a/arch/arm/mach-s3c64xx/setup-i2c1.c
+++ b/arch/arm/mach-s3c64xx/setup-i2c1.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/plat-s3c64xx/setup-i2c1.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Base S3C64XX I2C bus 1 gpio configuration
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// Base S3C64XX I2C bus 1 gpio configuration
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c64xx/setup-ide.c b/arch/arm/mach-s3c64xx/setup-ide.c
index 689fb72e715c..810139a807ce 100644
--- a/arch/arm/mach-s3c64xx/setup-ide.c
+++ b/arch/arm/mach-s3c64xx/setup-ide.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c64xx/setup-ide.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S3C64XX setup information for IDE
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2010 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com/
+//
+// S3C64XX setup information for IDE
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-s3c64xx/setup-keypad.c b/arch/arm/mach-s3c64xx/setup-keypad.c
index 6ad9a89dfddf..351961025273 100644
--- a/arch/arm/mach-s3c64xx/setup-keypad.c
+++ b/arch/arm/mach-s3c64xx/setup-keypad.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c64xx/setup-keypad.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * GPIO configuration for S3C64XX KeyPad device
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2010 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com/
+//
+// GPIO configuration for S3C64XX KeyPad device
 
 #include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
index f426b7a16c16..138455af4937 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
@@ -1,15 +1,10 @@
-/* linux/arch/arm/plat-s3c64xx/setup-sdhci-gpio.c
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C64XX - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// S3C64XX - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c64xx/setup-spi.c b/arch/arm/mach-s3c64xx/setup-spi.c
index 5fd1a315c901..39dfae1f46e7 100644
--- a/arch/arm/mach-s3c64xx/setup-spi.c
+++ b/arch/arm/mach-s3c64xx/setup-spi.c
@@ -1,12 +1,7 @@
-/* linux/arch/arm/mach-s3c64xx/setup-spi.c
- *
- * Copyright (C) 2011 Samsung Electronics Ltd.
- *		http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2011 Samsung Electronics Ltd.
+//		http://www.samsung.com/
 
 #include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c b/arch/arm/mach-s3c64xx/setup-usb-phy.c
index 2b17b7f5152f..46a9e955607f 100644
--- a/arch/arm/mach-s3c64xx/setup-usb-phy.c
+++ b/arch/arm/mach-s3c64xx/setup-usb-phy.c
@@ -1,13 +1,7 @@
-/*
- * Copyright (C) 2011 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2011 Samsung Electronics Co.Ltd
+// Author: Joonyoung Shim <jy0922.shim@samsung.com>
 
 #include <linux/clk.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-s3c64xx/sleep.S b/arch/arm/mach-s3c64xx/sleep.S
index 34313f9c8792..39e16a07a5e4 100644
--- a/arch/arm/mach-s3c64xx/sleep.S
+++ b/arch/arm/mach-s3c64xx/sleep.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* linux/arch/arm/plat-s3c64xx/sleep.S
  *
  * Copyright 2008 Openmoko, Inc.
@@ -6,11 +7,7 @@
  *	http://armlinux.simtec.co.uk/
  *
  * S3C64XX CPU sleep code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
diff --git a/arch/arm/mach-s3c64xx/watchdog-reset.h b/arch/arm/mach-s3c64xx/watchdog-reset.h
index 42707dfbda9c..1042d6c463dc 100644
--- a/arch/arm/mach-s3c64xx/watchdog-reset.h
+++ b/arch/arm/mach-s3c64xx/watchdog-reset.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2008 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C2410 - System define for arch_reset() function
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __PLAT_SAMSUNG_WATCHDOG_RESET_H
 #define __PLAT_SAMSUNG_WATCHDOG_RESET_H
-- 
2.7.4
