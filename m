From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/5] ARM: S3C24XX: Add SPDX license identifier
Date: Mon, 25 Dec 2017 20:54:32 +0100
Message-ID: <1514231675-17582-2-git-send-email-krzk@kernel.org>
References: <1514231675-17582-1-git-send-email-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514231675-17582-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Ombredanne <pombredanne@nexb.com>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Simtec Linux Team <linux@simtec.co.uk>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, patches@opensource.cirrus.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Replace GPL license statements with a SPDX license indentifiers (GPL-2.0
and GPL-2.0+).  The h1940-bluetooth.c was licensed under GPL-1.0.  This
also adds GPL-2.0 to few files lacking license statement.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/Kconfig                      |  4 +--
 arch/arm/mach-s3c24xx/Makefile                     |  4 +--
 arch/arm/mach-s3c24xx/Makefile.boot                |  2 ++
 arch/arm/mach-s3c24xx/anubis.h                     |  7 ++--
 arch/arm/mach-s3c24xx/bast-ide.c                   | 17 ++++------
 arch/arm/mach-s3c24xx/bast-irq.c                   | 28 ++++------------
 arch/arm/mach-s3c24xx/bast.h                       |  7 ++--
 arch/arm/mach-s3c24xx/common-smdk.c                | 21 +++++-------
 arch/arm/mach-s3c24xx/common-smdk.h                |  7 ++--
 arch/arm/mach-s3c24xx/common.c                     | 29 ++++------------
 arch/arm/mach-s3c24xx/common.h                     |  5 +--
 arch/arm/mach-s3c24xx/cpufreq-utils.c              | 18 ++++------
 arch/arm/mach-s3c24xx/fb-core.h                    |  5 +--
 arch/arm/mach-s3c24xx/gta02.h                      |  7 ++--
 arch/arm/mach-s3c24xx/h1940-bluetooth.c            | 16 +++------
 arch/arm/mach-s3c24xx/h1940.h                      |  7 ++--
 arch/arm/mach-s3c24xx/include/mach/dma.h           | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/fb.h            |  1 +
 arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h  |  7 ++--
 arch/arm/mach-s3c24xx/include/mach/hardware.h      |  7 ++--
 arch/arm/mach-s3c24xx/include/mach/irqs.h          | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/map.h           | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/pm-core.h       |  9 ++---
 arch/arm/mach-s3c24xx/include/mach/regs-clock.h    | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h     | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/regs-irq.h      | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/regs-lcd.h      | 11 ++----
 .../mach-s3c24xx/include/mach/regs-s3c2443-clock.h | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/rtc-core.h      |  7 ++--
 arch/arm/mach-s3c24xx/include/mach/s3c2412.h       |  5 +--
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c           | 18 ++++------
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c           | 18 ++++------
 arch/arm/mach-s3c24xx/irq-pm.c                     | 19 ++++-------
 arch/arm/mach-s3c24xx/mach-amlm5900.c              | 35 +++++--------------
 arch/arm/mach-s3c24xx/mach-anubis.c                | 15 +++------
 arch/arm/mach-s3c24xx/mach-at2440evb.c             | 21 +++++-------
 arch/arm/mach-s3c24xx/mach-bast.c                  | 17 ++++------
 arch/arm/mach-s3c24xx/mach-gta02.c                 | 33 +++++-------------
 arch/arm/mach-s3c24xx/mach-h1940.c                 | 17 ++++------
 arch/arm/mach-s3c24xx/mach-jive.c                  | 17 ++++------
 arch/arm/mach-s3c24xx/mach-mini2440.c              | 23 +++++--------
 arch/arm/mach-s3c24xx/mach-n30.c                   | 27 +++++++--------
 arch/arm/mach-s3c24xx/mach-nexcoder.c              | 22 +++++-------
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            | 19 ++++-------
 arch/arm/mach-s3c24xx/mach-osiris.c                | 14 +++-----
 arch/arm/mach-s3c24xx/mach-otom.c                  | 13 +++-----
 arch/arm/mach-s3c24xx/mach-qt2410.c                | 27 +++------------
 arch/arm/mach-s3c24xx/mach-rx1950.c                | 17 ++++------
 arch/arm/mach-s3c24xx/mach-rx3715.c                | 18 ++++------
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            | 28 +++++++---------
 arch/arm/mach-s3c24xx/mach-smdk2410.c              | 39 ++++++----------------
 arch/arm/mach-s3c24xx/mach-smdk2413.c              | 19 ++++-------
 arch/arm/mach-s3c24xx/mach-smdk2416.c              | 18 ++++------
 arch/arm/mach-s3c24xx/mach-smdk2440.c              | 23 +++++--------
 arch/arm/mach-s3c24xx/mach-smdk2443.c              | 22 +++++-------
 arch/arm/mach-s3c24xx/mach-tct_hammer.c            | 33 +++++-------------
 arch/arm/mach-s3c24xx/mach-vr1000.c                | 19 ++++-------
 arch/arm/mach-s3c24xx/mach-vstms.c                 | 15 +++------
 arch/arm/mach-s3c24xx/nand-core.h                  |  7 ++--
 arch/arm/mach-s3c24xx/osiris.h                     |  7 ++--
 arch/arm/mach-s3c24xx/otom.h                       |  7 ++--
 arch/arm/mach-s3c24xx/pll-s3c2410.c                | 30 +++++------------
 arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c       | 20 +++++------
 arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c       | 20 +++++------
 arch/arm/mach-s3c24xx/pm-h1940.S                   | 19 ++---------
 arch/arm/mach-s3c24xx/pm-s3c2410.c                 | 27 ++++-----------
 arch/arm/mach-s3c24xx/pm-s3c2412.c                 | 17 ++++------
 arch/arm/mach-s3c24xx/pm-s3c2416.c                 | 17 ++++------
 arch/arm/mach-s3c24xx/pm.c                         | 39 +++++++---------------
 arch/arm/mach-s3c24xx/regs-dsc.h                   |  7 ++--
 arch/arm/mach-s3c24xx/regs-mem.h                   |  5 +--
 arch/arm/mach-s3c24xx/s3c2410.c                    | 17 ++++------
 arch/arm/mach-s3c24xx/s3c2412-power.h              |  5 +--
 arch/arm/mach-s3c24xx/s3c2412.c                    | 16 ++++-----
 arch/arm/mach-s3c24xx/s3c2416.c                    | 31 +++++------------
 arch/arm/mach-s3c24xx/s3c2440.c                    | 17 ++++------
 arch/arm/mach-s3c24xx/s3c2442.c                    | 29 ++++------------
 arch/arm/mach-s3c24xx/s3c2443.c                    | 17 ++++------
 arch/arm/mach-s3c24xx/s3c244x.c                    | 17 ++++------
 arch/arm/mach-s3c24xx/setup-camif.c                | 14 +++-----
 arch/arm/mach-s3c24xx/setup-i2c.c                  | 17 ++++------
 arch/arm/mach-s3c24xx/setup-sdhci-gpio.c           | 21 +++++-------
 arch/arm/mach-s3c24xx/setup-spi.c                  | 16 ++++-----
 arch/arm/mach-s3c24xx/setup-ts.c                   | 17 ++++------
 arch/arm/mach-s3c24xx/simtec-audio.c               | 19 ++++-------
 arch/arm/mach-s3c24xx/simtec-nor.c                 | 19 ++++-------
 arch/arm/mach-s3c24xx/simtec-pm.c                  | 21 +++++-------
 arch/arm/mach-s3c24xx/simtec-usb.c                 | 21 +++++-------
 arch/arm/mach-s3c24xx/simtec.h                     | 10 ++----
 arch/arm/mach-s3c24xx/sleep-s3c2410.S              | 20 ++---------
 arch/arm/mach-s3c24xx/sleep-s3c2412.S              | 20 ++---------
 arch/arm/mach-s3c24xx/sleep.S                      | 20 ++---------
 arch/arm/mach-s3c24xx/spi-core.h                   |  5 +--
 arch/arm/mach-s3c24xx/vr1000.h                     | 11 ++----
 94 files changed, 483 insertions(+), 1046 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index b198be7d32b6..686f0bbde998 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -1,11 +1,9 @@
-# arch/arm/mach-s3c24xx/Kconfig
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (c) 2012 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
 #
 # Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
 
 if ARCH_S3C24XX
 
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 8ac2f58a3480..6692f2de71b2 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -1,11 +1,9 @@
-# arch/arm/mach-s3c24xx/Makefile
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (c) 2012 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
 #
 # Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
 
 # core
 
diff --git a/arch/arm/mach-s3c24xx/Makefile.boot b/arch/arm/mach-s3c24xx/Makefile.boot
index 4457605ba04a..7f19e226035e 100644
--- a/arch/arm/mach-s3c24xx/Makefile.boot
+++ b/arch/arm/mach-s3c24xx/Makefile.boot
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 ifeq ($(CONFIG_PM_H1940),y)
 	zreladdr-y	+= 0x30108000
 	params_phys-y	:= 0x30100100
diff --git a/arch/arm/mach-s3c24xx/anubis.h b/arch/arm/mach-s3c24xx/anubis.h
index 2691665f27d9..13847292e6c7 100644
--- a/arch/arm/mach-s3c24xx/anubis.h
+++ b/arch/arm/mach-s3c24xx/anubis.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2005 Simtec Electronics
  *	http://www.simtec.co.uk/products/
@@ -6,11 +7,7 @@
  * ANUBIS - CPLD control constants
  * ANUBIS - IRQ Number definitions
  * ANUBIS - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __MACH_S3C24XX_ANUBIS_H
 #define __MACH_S3C24XX_ANUBIS_H __FILE__
diff --git a/arch/arm/mach-s3c24xx/bast-ide.c b/arch/arm/mach-s3c24xx/bast-ide.c
index 3f0288f2f542..067944398f46 100644
--- a/arch/arm/mach-s3c24xx/bast-ide.c
+++ b/arch/arm/mach-s3c24xx/bast-ide.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c2410/bast-ide.c
- *
- * Copyright 2007 Simtec Electronics
- *	http://www.simtec.co.uk/products/EB2410ITX/
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2007 Simtec Electronics
+//	http://www.simtec.co.uk/products/EB2410ITX/
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/bast-irq.c b/arch/arm/mach-s3c24xx/bast-irq.c
index ad8f4cd7c327..03728058d58d 100644
--- a/arch/arm/mach-s3c24xx/bast-irq.c
+++ b/arch/arm/mach-s3c24xx/bast-irq.c
@@ -1,25 +1,9 @@
-/* linux/arch/arm/mach-s3c2410/bast-irq.c
- *
- * Copyright 2003-2005 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * http://www.simtec.co.uk/products/EB2410ITX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
-
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2003-2005 Simtec Electronics
+//   Ben Dooks <ben@simtec.co.uk>
+//
+// http://www.simtec.co.uk/products/EB2410ITX/
 
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/arch/arm/mach-s3c24xx/bast.h b/arch/arm/mach-s3c24xx/bast.h
index 5c7534bae92d..a7726f93f5eb 100644
--- a/arch/arm/mach-s3c24xx/bast.h
+++ b/arch/arm/mach-s3c24xx/bast.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2003-2004 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
@@ -5,11 +6,7 @@
  * BAST - CPLD control constants
  * BAST - IRQ Number definitions
  * BAST - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __MACH_S3C24XX_BAST_H
 #define __MACH_S3C24XX_BAST_H __FILE__
diff --git a/arch/arm/mach-s3c24xx/common-smdk.c b/arch/arm/mach-s3c24xx/common-smdk.c
index 0e116c92bf01..58e30cad386c 100644
--- a/arch/arm/mach-s3c24xx/common-smdk.c
+++ b/arch/arm/mach-s3c24xx/common-smdk.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/plat-s3c24xx/common-smdk.c
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Common code for SMDK2410 and SMDK2440 boards
- *
- * http://www.fluff.org/ben/smdk2440/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2006 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// Common code for SMDK2410 and SMDK2440 boards
+//
+// http://www.fluff.org/ben/smdk2440/
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/common-smdk.h b/arch/arm/mach-s3c24xx/common-smdk.h
index 98f733e1cb42..c0352b06e435 100644
--- a/arch/arm/mach-s3c24xx/common-smdk.h
+++ b/arch/arm/mach-s3c24xx/common-smdk.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2006 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
@@ -5,10 +6,6 @@
  * Common code for SMDK2410 and SMDK2440 boards
  *
  * http://www.fluff.org/ben/smdk2440/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 extern void smdk_machine_init(void);
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 5b6b94ef41e2..3dc029c2d2cb 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -1,25 +1,10 @@
-/* linux/arch/arm/plat-s3c24xx/cpu.c
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	http://www.simtec.co.uk/products/SWLINUX/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Common code for S3C24XX machines
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2004-2005 Simtec Electronics
+//	http://www.simtec.co.uk/products/SWLINUX/
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// Common code for S3C24XX machines
 
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index c7ac7e61a22e..d087b20e8857 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Common Header for S3C24XX SoCs
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __ARCH_ARM_MACH_S3C24XX_COMMON_H
diff --git a/arch/arm/mach-s3c24xx/cpufreq-utils.c b/arch/arm/mach-s3c24xx/cpufreq-utils.c
index d4d9514335f4..1a7f38d085dd 100644
--- a/arch/arm/mach-s3c24xx/cpufreq-utils.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-utils.c
@@ -1,14 +1,10 @@
-/*
- * Copyright (c) 2009 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX CPU Frequency scaling - utils for S3C2410/S3C2440/S3C2442
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2009 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// S3C24XX CPU Frequency scaling - utils for S3C2410/S3C2440/S3C2442
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
diff --git a/arch/arm/mach-s3c24xx/fb-core.h b/arch/arm/mach-s3c24xx/fb-core.h
index 103bdbaddd55..1821e820262c 100644
--- a/arch/arm/mach-s3c24xx/fb-core.h
+++ b/arch/arm/mach-s3c24xx/fb-core.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2010 Samsung Electronics Co., Ltd.
  *	Pawel Osciak <p.osciak@samsung.com>
  *
  * Samsung framebuffer driver core functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef __ASM_PLAT_FB_CORE_H
 #define __ASM_PLAT_FB_CORE_H __FILE__
diff --git a/arch/arm/mach-s3c24xx/gta02.h b/arch/arm/mach-s3c24xx/gta02.h
index 9430a71e9184..d5610ba829a4 100644
--- a/arch/arm/mach-s3c24xx/gta02.h
+++ b/arch/arm/mach-s3c24xx/gta02.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * GTA02 header
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __MACH_S3C24XX_GTA02_H
 #define __MACH_S3C24XX_GTA02_H __FILE__
diff --git a/arch/arm/mach-s3c24xx/h1940-bluetooth.c b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
index 9c8b1279a4ba..46ad20ea87d1 100644
--- a/arch/arm/mach-s3c24xx/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
@@ -1,14 +1,8 @@
-/*
- * arch/arm/mach-s3c2410/h1940-bluetooth.c
- * Copyright (c) Arnaud Patard <arnaud.patard@rtp-net.org>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive for
- * more details.
- *
- *	    S3C2410 bluetooth "driver"
- *
- */
+// SPDX-License-Identifier: GPL-1.0
+//
+// Copyright (c) Arnaud Patard <arnaud.patard@rtp-net.org>
+//
+//	    S3C2410 bluetooth "driver"
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-s3c24xx/h1940.h b/arch/arm/mach-s3c24xx/h1940.h
index 596d9f64c5b6..5dfe9d10cd15 100644
--- a/arch/arm/mach-s3c24xx/h1940.h
+++ b/arch/arm/mach-s3c24xx/h1940.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2006 Ben Dooks <ben-linux@fluff.org>
  *
@@ -6,11 +7,7 @@
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * iPAQ H1940 series definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __MACH_S3C24XX_H1940_H
 #define __MACH_S3C24XX_H1940_H __FILE__
diff --git a/arch/arm/mach-s3c24xx/include/mach/dma.h b/arch/arm/mach-s3c24xx/include/mach/dma.h
index 9e8117198e0c..25fc9c258fc1 100644
--- a/arch/arm/mach-s3c24xx/include/mach/dma.h
+++ b/arch/arm/mach-s3c24xx/include/mach/dma.h
@@ -1,14 +1,10 @@
-/* arch/arm/mach-s3c2410/include/mach/dma.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2003-2006 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * Samsung S3C24XX DMA support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H __FILE__
diff --git a/arch/arm/mach-s3c24xx/include/mach/fb.h b/arch/arm/mach-s3c24xx/include/mach/fb.h
index a957bc8ed44f..4e539cb8b884 100644
--- a/arch/arm/mach-s3c24xx/include/mach/fb.h
+++ b/arch/arm/mach-s3c24xx/include/mach/fb.h
@@ -1 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #include <plat/fb-s3c2410.h>
diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
index 528fcdc4f63e..2ad22b2d459b 100644
--- a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
+++ b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
@@ -1,14 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C2410 - GPIO lib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /* some boards require extra gpio capacity to support external
  * devices that need GPIO.
diff --git a/arch/arm/mach-s3c24xx/include/mach/hardware.h b/arch/arm/mach-s3c24xx/include/mach/hardware.h
index dedd3837c193..1b2975708e3f 100644
--- a/arch/arm/mach-s3c24xx/include/mach/hardware.h
+++ b/arch/arm/mach-s3c24xx/include/mach/hardware.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2003 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C2410 - hardware
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H
diff --git a/arch/arm/mach-s3c24xx/include/mach/irqs.h b/arch/arm/mach-s3c24xx/include/mach/irqs.h
index b6dd4cb5a2ec..aaf3bae08b52 100644
--- a/arch/arm/mach-s3c24xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c24xx/include/mach/irqs.h
@@ -1,12 +1,8 @@
-/* arch/arm/mach-s3c2410/include/mach/irqs.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2003-2005 Simtec Electronics
  *   Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 
 #ifndef __ASM_ARCH_IRQS_H
diff --git a/arch/arm/mach-s3c24xx/include/mach/map.h b/arch/arm/mach-s3c24xx/include/mach/map.h
index adc39043aa21..bca93112f57d 100644
--- a/arch/arm/mach-s3c24xx/include/mach/map.h
+++ b/arch/arm/mach-s3c24xx/include/mach/map.h
@@ -1,14 +1,10 @@
-/* arch/arm/mach-s3c2410/include/mach/map.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2003 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C2410 - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_ARCH_MAP_H
 #define __ASM_ARCH_MAP_H
diff --git a/arch/arm/mach-s3c24xx/include/mach/pm-core.h b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
index 712333fec589..5e4ce89d0158 100644
--- a/arch/arm/mach-s3c24xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
@@ -1,15 +1,12 @@
-/* linux/arch/arm/mach-s3c2410/include/pm-core.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Simtec Electronics
  *      Ben Dooks <ben@simtec.co.uk>
  *      http://armlinux.simtec.co.uk/
  *
  * S3C24xx - PM core support for arch/arm/plat-s3c/pm.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
+
 #include <linux/delay.h>
 #include <linux/io.h>
 
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
index ae4a3e0f3ba2..7ca3dd4f13c0 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
@@ -1,14 +1,10 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-clock.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2003-2006 Simtec Electronics <linux@simtec.co.uk>
  *	http://armlinux.simtec.co.uk/
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * S3C2410 clock register definitions
-*/
+ */
 
 #ifndef __ASM_ARM_REGS_CLOCK
 #define __ASM_ARM_REGS_CLOCK
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
index 0d622f3b57a5..594e967c0673 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
@@ -1,14 +1,10 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-gpio.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2003-2004 Simtec Electronics <linux@simtec.co.uk>
  *	http://www.simtec.co.uk/products/SWLINUX/
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * S3C2410 GPIO register definitions
-*/
+ */
 
 
 #ifndef __ASM_ARCH_REGS_GPIO_H
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-irq.h b/arch/arm/mach-s3c24xx/include/mach/regs-irq.h
index 0f07ba30b1fb..8d8e669e3903 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-irq.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-irq.h
@@ -1,12 +1,8 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-irq.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
  *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 
 #ifndef ___ASM_ARCH_REGS_IRQ_H
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-lcd.h b/arch/arm/mach-s3c24xx/include/mach/regs-lcd.h
index ee8f040aff5f..4c3434f261bb 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-lcd.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-lcd.h
@@ -1,13 +1,8 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-lcd.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
  *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
+ */
 
 #ifndef ___ASM_ARCH_REGS_LCD_H
 #define ___ASM_ARCH_REGS_LCD_H
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
index ffe37bdb9f59..6bf924612b06 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
@@ -1,15 +1,11 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2007 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *	http://armlinux.simtec.co.uk/
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * S3C2443 clock register definitions
-*/
+ */
 
 #ifndef __ASM_ARM_REGS_S3C2443_CLOCK
 #define __ASM_ARM_REGS_S3C2443_CLOCK
diff --git a/arch/arm/mach-s3c24xx/include/mach/rtc-core.h b/arch/arm/mach-s3c24xx/include/mach/rtc-core.h
index 4d5f5768f700..88510333b96b 100644
--- a/arch/arm/mach-s3c24xx/include/mach/rtc-core.h
+++ b/arch/arm/mach-s3c24xx/include/mach/rtc-core.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2011 Heiko Stuebner <heiko@sntech.de>
  *
  * Samsung RTC Controller core functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __RTC_CORE_H
 #define __RTC_CORE_H __FILE__
diff --git a/arch/arm/mach-s3c24xx/include/mach/s3c2412.h b/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
index 548ced42cbb7..b6b32724ace8 100644
--- a/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
+++ b/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2008 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __ARCH_ARM_MACH_S3C24XX_S3C2412_H
diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
index d5f1f06e4811..9f90aaf70bf3 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
@@ -1,14 +1,10 @@
-/*
- * Copyright (c) 2006-2009 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX CPU Frequency scaling - IO timing for S3C2410/S3C2440/S3C2442
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2006-2009 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// S3C24XX CPU Frequency scaling - IO timing for S3C2410/S3C2440/S3C2442
 
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
index c5b12f6b02b5..59356d10fbcf 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
@@ -1,14 +1,10 @@
-/*
- * Copyright (c) 2006-2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2412/S3C2443 (PL093 based) IO timing support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2006-2008 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// S3C2412/S3C2443 (PL093 based) IO timing support
 
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/arch/arm/mach-s3c24xx/irq-pm.c b/arch/arm/mach-s3c24xx/irq-pm.c
index 417b7a20c2d1..e0131b16a4af 100644
--- a/arch/arm/mach-s3c24xx/irq-pm.c
+++ b/arch/arm/mach-s3c24xx/irq-pm.c
@@ -1,15 +1,10 @@
-/* linux/arch/arm/plat-s3c24xx/irq-om.c
- *
- * Copyright (c) 2003-2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C24XX - IRQ PM code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2003-2004 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// S3C24XX - IRQ PM code
 
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
index 3e63777a109f..9a9daf526d0c 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
@@ -1,30 +1,11 @@
-/* linux/arch/arm/mach-s3c2410/mach-amlm5900.c
- *
- * linux/arch/arm/mach-s3c2410/mach-amlm5900.c
- *
- * Copyright (c) 2006 American Microsystems Limited
- *	David Anders <danders@amltd.com>
-
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- *
- * @History:
- * derived from linux/arch/arm/mach-s3c2410/mach-bast.c, written by
- * Ben Dooks <ben@simtec.co.uk>
- *
- ***********************************************************************/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2006 American Microsystems Limited
+//	David Anders <danders@amltd.com>
+//
+// @History:
+// derived from linux/arch/arm/mach-s3c2410/mach-bast.c, written by
+// Ben Dooks <ben@simtec.co.uk>
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index c14cab361922..072966dcad78 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -1,13 +1,8 @@
-/* linux/arch/arm/mach-s3c2440/mach-anubis.c
- *
- * Copyright 2003-2009 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2003-2009 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index ebdbafb9382a..68a4fa94257a 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/mach-s3c2440/mach-at2440evb.c
- *
- * Copyright (c) 2008 Ramax Lo <ramaxlo@gmail.com>
- *      Based on mach-anubis.c by Ben Dooks <ben@simtec.co.uk>
- *      and modifications by SBZ <sbz@spgui.org> and
- *      Weibing <http://weibing.blogbus.com>
- *
- * For product information, visit http://www.arm.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2008 Ramax Lo <ramaxlo@gmail.com>
+//      Based on mach-anubis.c by Ben Dooks <ben@simtec.co.uk>
+//      and modifications by SBZ <sbz@spgui.org> and
+//      Weibing <http://weibing.blogbus.com>
+//
+// For product information, visit http://www.arm.com/
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 704dc84b3480..a7c3955ae8f6 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c2410/mach-bast.c
- *
- * Copyright 2003-2008 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * http://www.simtec.co.uk/products/EB2410ITX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2003-2008 Simtec Electronics
+//   Ben Dooks <ben@simtec.co.uk>
+//
+// http://www.simtec.co.uk/products/EB2410ITX/
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index afe18baf0c84..9d5595c4ad99 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -1,27 +1,12 @@
-/*
- * S3C2442 Machine Support for Openmoko GTA02 / FreeRunner.
- *
- * Copyright (C) 2006-2009 by Openmoko, Inc.
- * Authors: Harald Welte <laforge@openmoko.org>
- *          Andy Green <andy@openmoko.org>
- *          Werner Almesberger <werner@openmoko.org>
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// S3C2442 Machine Support for Openmoko GTA02 / FreeRunner.
+//
+// Copyright (C) 2006-2009 by Openmoko, Inc.
+// Authors: Harald Welte <laforge@openmoko.org>
+//          Andy Green <andy@openmoko.org>
+//          Werner Almesberger <werner@openmoko.org>
+// All rights reserved.
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 7ed78619217c..e064c73a57d3 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -1,14 +1,9 @@
-/*
- * Copyright (c) 2003-2005 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * http://www.handhelds.org/projects/h1940.html
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2003-2005 Simtec Electronics
+//   Ben Dooks <ben@simtec.co.uk>
+//
+// http://www.handhelds.org/projects/h1940.html
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 17821976f769..a3ddbbbd6d92 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c2410/mach-jive.c
- *
- * Copyright 2007 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2007 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// http://armlinux.simtec.co.uk/
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 04c9f488c498..95753e0bc073 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -1,17 +1,12 @@
-/* linux/arch/arm/mach-s3c2440/mach-mini2440.c
- *
- * Copyright (c) 2008 Ramax Lo <ramaxlo@gmail.com>
- *      Based on mach-anubis.c by Ben Dooks <ben@simtec.co.uk>
- *      and modifications by SBZ <sbz@spgui.org> and
- *      Weibing <http://weibing.blogbus.com> and
- *      Michel Pollet <buserror@gmail.com>
- *
- * For product information, visit http://code.google.com/p/mini2440/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2008 Ramax Lo <ramaxlo@gmail.com>
+//      Based on mach-anubis.c by Ben Dooks <ben@simtec.co.uk>
+//      and modifications by SBZ <sbz@spgui.org> and
+//      Weibing <http://weibing.blogbus.com> and
+//      Michel Pollet <buserror@gmail.com>
+//
+// For product information, visit http://code.google.com/p/mini2440/
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 070a0d0714a5..eec51fadb14a 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -1,18 +1,15 @@
-/* Machine specific code for the Acer n30, Acer N35, Navman PiN 570,
- * Yakumo AlphaX and Airis NC05 PDAs.
- *
- * Copyright (c) 2003-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Copyright (c) 2005-2008 Christer Weinigel <christer@weinigel.se>
- *
- * There is a wiki with more information about the n30 port at
- * http://handhelds.org/moin/moin.cgi/AcerN30Documentation .
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Machine specific code for the Acer n30, Acer N35, Navman PiN 570,
+// Yakumo AlphaX and Airis NC05 PDAs.
+//
+// Copyright (c) 2003-2005 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// Copyright (c) 2005-2008 Christer Weinigel <christer@weinigel.se>
+//
+// There is a wiki with more information about the n30 port at
+// http://handhelds.org/moin/moin.cgi/AcerN30Documentation .
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index 2a61d13dcd6c..c2f34758ccb6 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -1,16 +1,12 @@
-/* linux/arch/arm/mach-s3c2440/mach-nexcoder.c
- *
- * Copyright (c) 2004 Nex Vision
- *   Guillaume GOURAT <guillaume.gourat@nexvision.tv>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Modifications:
- *     15-10-2004 GG  Created initial version
- *     12-03-2005 BJD Updated for release
- */
+// SPDX-License-Identifier: GPL-2.0
+// linux/arch/arm/mach-s3c2440/mach-nexcoder.c
+//
+// Copyright (c) 2004 Nex Vision
+//   Guillaume GOURAT <guillaume.gourat@nexvision.tv>
+//
+// Modifications:
+//     15-10-2004 GG  Created initial version
+//     12-03-2005 BJD Updated for release
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index 6cac7da15e2b..058ce73137e8 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -1,15 +1,10 @@
-/* linux/arch/arm/mach-s3c2440/mach-osiris-dvs.c
- *
- * Copyright (c) 2009 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Simtec Osiris Dynamic Voltage Scaling support.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2009 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// Simtec Osiris Dynamic Voltage Scaling support.
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index ed3b22ceef06..ee3630cb236a 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -1,12 +1,8 @@
-/*
- * Copyright (c) 2005-2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2005-2008 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
index 345a484b93cc..4e24d89e870b 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c24xx/mach-otom.c
@@ -1,12 +1,7 @@
-/*
- *
- * Copyright (c) 2004 Nex Vision
- *   Guillaume GOURAT <guillaume.gourat@nexvision.fr>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2004 Nex Vision
+//   Guillaume GOURAT <guillaume.gourat@nexvision.fr>
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 84e3a9c53184..9c8373b8d9c3 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -1,25 +1,8 @@
-/* linux/arch/arm/mach-s3c2410/mach-qt2410.c
- *
- * Copyright (C) 2006 by OpenMoko, Inc.
- * Author: Harald Welte <laforge@openmoko.org>
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2006 by OpenMoko, Inc.
+// Author: Harald Welte <laforge@openmoko.org>
+// All rights reserved.
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index e86ad6a68a0b..7f5a18fa305b 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -1,14 +1,9 @@
-/*
- * Copyright (c) 2006-2009 Victor Chukhantsev, Denis Grigoriev,
- * Copyright (c) 2007-2010 Vasily Khoruzhick
- *
- * based on smdk2440 written by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2006-2009 Victor Chukhantsev, Denis Grigoriev,
+// Copyright (c) 2007-2010 Vasily Khoruzhick
+//
+// based on smdk2440 written by Ben Dooks
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index b5ba615cf9dd..529c6faf862f 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -1,15 +1,9 @@
-/* linux/arch/arm/mach-s3c2440/mach-rx3715.c
- *
- * Copyright (c) 2003-2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * http://www.handhelds.org/projects/rx3715.html
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2003-2004 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// http://www.handhelds.org/projects/rx3715.html
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
index c83c076578dd..aa7102713b37 100644
--- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
+++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
@@ -1,19 +1,15 @@
-/*
- * Samsung's S3C2416 flattened device tree enabled machine
- *
- * Copyright (c) 2012 Heiko Stuebner <heiko@sntech.de>
- *
- * based on mach-exynos/mach-exynos4-dt.c
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- * Copyright (c) 2010-2011 Linaro Ltd.
- *		www.linaro.org
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Samsung's S3C2416 flattened device tree enabled machine
+//
+// Copyright (c) 2012 Heiko Stuebner <heiko@sntech.de>
+//
+// based on mach-exynos/mach-exynos4-dt.c
+//
+// Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+// Copyright (c) 2010-2011 Linaro Ltd.
+//		www.linaro.org
 
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2410.c b/arch/arm/mach-s3c24xx/mach-smdk2410.c
index 27dd6605e395..18dfef52c8bf 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2410.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2410.c
@@ -1,32 +1,13 @@
-/* linux/arch/arm/mach-s3c2410/mach-smdk2410.c
- *
- * linux/arch/arm/mach-s3c2410/mach-smdk2410.c
- *
- * Copyright (C) 2004 by FS Forth-Systeme GmbH
- * All rights reserved.
- *
- * @Author: Jonas Dietsche
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- *
- * @History:
- * derived from linux/arch/arm/mach-s3c2410/mach-bast.c, written by
- * Ben Dooks <ben@simtec.co.uk>
- *
- ***********************************************************************/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2004 by FS Forth-Systeme GmbH
+// All rights reserved.
+//
+// @Author: Jonas Dietsche
+//
+// @History:
+// derived from linux/arch/arm/mach-s3c2410/mach-bast.c, written by
+// Ben Dooks <ben@simtec.co.uk>
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index 586e4a3b8d5d..ca80167f268d 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -1,15 +1,10 @@
-/* linux/arch/arm/mach-s3c2412/mach-smdk2413.c
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Thanks to Dimity Andric (TomTom) and Steven Ryu (Samsung) for the
- * loans of SMDK2413 to work with.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2006 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// Thanks to Dimity Andric (TomTom) and Steven Ryu (Samsung) for the
+// loans of SMDK2413 to work with.
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index 86394f72d29e..61c3e45898d3 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -1,15 +1,9 @@
-/* linux/arch/arm/mach-s3c2416/mach-hanlin_v3c.c
- *
- * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
- *	as part of OpenInkpot project
- * Copyright (c) 2009 Promwad Innovation Company
- *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
+//	as part of OpenInkpot project
+// Copyright (c) 2009 Promwad Innovation Company
+//	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index 9bb96bfbb420..7bafcd8ea104 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2440.c
@@ -1,17 +1,12 @@
-/* linux/arch/arm/mach-s3c2440/mach-smdk2440.c
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * http://www.fluff.org/ben/smdk2440/
- *
- * Thanks to Dimity Andric and TomTom for the loan of an SMDK2440.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+// linux/arch/arm/mach-s3c2440/mach-smdk2440.c
+//
+// Copyright (c) 2004-2005 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// http://www.fluff.org/ben/smdk2440/
+//
+// Thanks to Dimity Andric and TomTom for the loan of an SMDK2440.
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index 474cd81aa8ad..2358ed5ed7be 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -1,17 +1,11 @@
-/* linux/arch/arm/mach-s3c2443/mach-smdk2443.c
- *
- * Copyright (c) 2007 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * http://www.fluff.org/ben/smdk2443/
- *
- * Thanks to Samsung for the loan of an SMDK2443
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2007 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// http://www.fluff.org/ben/smdk2443/
+//
+// Thanks to Samsung for the loan of an SMDK2443
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-tct_hammer.c b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
index 2deb62f92fb2..8d8ddd6ea305 100644
--- a/arch/arm/mach-s3c24xx/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
@@ -1,28 +1,11 @@
-/* linux/arch/arm/mach-s3c2410/mach-tct_hammer.c
- *
- * Copyright (c) 2007 TinCanTools
- *	David Anders <danders@amltd.com>
-
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- *
- * @History:
- * derived from linux/arch/arm/mach-s3c2410/mach-bast.c, written by
- * Ben Dooks <ben@simtec.co.uk>
- *
- ***********************************************************************/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2007 TinCanTools
+//	David Anders <danders@amltd.com>
+//
+// @History:
+// derived from linux/arch/arm/mach-s3c2410/mach-bast.c, written by
+// Ben Dooks <ben@simtec.co.uk>
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 89f32bd3f01b..853e74f9b8b5 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -1,15 +1,10 @@
-/*
- * Copyright (c) 2003-2008 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * Machine support for Thorcom VR1000 board. Designed for Thorcom by
- * Simtec Electronics, http://www.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2003-2008 Simtec Electronics
+//   Ben Dooks <ben@simtec.co.uk>
+//
+// Machine support for Thorcom VR1000 board. Designed for Thorcom by
+// Simtec Electronics, http://www.simtec.co.uk/
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index 1adc957edf0f..d76b28b65e65 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -1,13 +1,8 @@
-/* linux/arch/arm/mach-s3c2412/mach-vstms.c
- *
- * (C) 2006 Thomas Gleixner <tglx@linutronix.de>
- *
- * Derived from mach-smdk2413.c - (C) 2006 Simtec Electronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// (C) 2006 Thomas Gleixner <tglx@linutronix.de>
+//
+// Derived from mach-smdk2413.c - (C) 2006 Simtec Electronics
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/nand-core.h b/arch/arm/mach-s3c24xx/nand-core.h
index 7e811fe1cf41..8de633d416ae 100644
--- a/arch/arm/mach-s3c24xx/nand-core.h
+++ b/arch/arm/mach-s3c24xx/nand-core.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * S3C -  Nand Controller core functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_ARCH_NAND_CORE_H
 #define __ASM_ARCH_NAND_CORE_H __FILE__
diff --git a/arch/arm/mach-s3c24xx/osiris.h b/arch/arm/mach-s3c24xx/osiris.h
index b8d56074abac..b6c9c5ed2ba7 100644
--- a/arch/arm/mach-s3c24xx/osiris.h
+++ b/arch/arm/mach-s3c24xx/osiris.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2005 Simtec Electronics
  *	http://www.simtec.co.uk/products/
@@ -5,11 +6,7 @@
  *
  * OSIRIS - CPLD control constants
  * OSIRIS - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __MACH_S3C24XX_OSIRIS_H
 #define __MACH_S3C24XX_OSIRIS_H __FILE__
diff --git a/arch/arm/mach-s3c24xx/otom.h b/arch/arm/mach-s3c24xx/otom.h
index 321b7be1c0f7..c800f67d03d4 100644
--- a/arch/arm/mach-s3c24xx/otom.h
+++ b/arch/arm/mach-s3c24xx/otom.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * (c) 2005 Guillaume GOURAT / NexVision
  *          guillaume.gourat@nexvision.fr
  *
  * NexVision OTOM board memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /*
  * ok, we've used up to 0x01300000, now we need to find space for the
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2410.c b/arch/arm/mach-s3c24xx/pll-s3c2410.c
index 7ee4924a543d..0561f79ddce8 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2410.c
@@ -1,25 +1,11 @@
-/*
- * Copyright (c) 2006-2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *	Vincent Sanders <vince@arm.linux.org.uk>
- *
- * S3C2410 CPU PLL tables
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2006-2007 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
+//	Vincent Sanders <vince@arm.linux.org.uk>
+//
+// S3C2410 CPU PLL tables
 
 #include <linux/types.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
index a3fbfed75e28..2ec3a2f9a6a5 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
@@ -1,15 +1,11 @@
-/*
- * Copyright (c) 2006-2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *	Vincent Sanders <vince@arm.linux.org.uk>
- *
- * S3C2440/S3C2442 CPU PLL tables (12MHz Crystal)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2006-2007 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
+//	Vincent Sanders <vince@arm.linux.org.uk>
+//
+// S3C2440/S3C2442 CPU PLL tables (12MHz Crystal)
 
 #include <linux/types.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
index bcff89fd9871..4b3d9e36c6bb 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
@@ -1,15 +1,11 @@
-/*
- * Copyright (c) 2006-2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *	Vincent Sanders <vince@arm.linux.org.uk>
- *
- * S3C2440/S3C2442 CPU PLL tables (16.93444MHz Crystal)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2006-2008 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
+//	Vincent Sanders <vince@arm.linux.org.uk>
+//
+// S3C2440/S3C2442 CPU PLL tables (16.93444MHz Crystal)
 
 #include <linux/types.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-s3c24xx/pm-h1940.S b/arch/arm/mach-s3c24xx/pm-h1940.S
index 6183a688012b..a7bbe336ac6b 100644
--- a/arch/arm/mach-s3c24xx/pm-h1940.S
+++ b/arch/arm/mach-s3c24xx/pm-h1940.S
@@ -1,22 +1,9 @@
-/* linux/arch/arm/mach-s3c2410/pm-h1940.S
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (c) 2006 Ben Dooks <ben-linux@fluff.org>
  *
  * H1940 Suspend to RAM
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+ */
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2410.c b/arch/arm/mach-s3c24xx/pm-s3c2410.c
index a4588daeddb0..2d8ea701380a 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2410.c
@@ -1,24 +1,9 @@
-/* linux/arch/arm/mach-s3c2410/pm.c
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 (and compatible) Power Manager (Suspend-To-RAM) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2006 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// S3C2410 (and compatible) Power Manager (Suspend-To-RAM) support
 
 #include <linux/init.h>
 #include <linux/suspend.h>
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2412.c b/arch/arm/mach-s3c24xx/pm-s3c2412.c
index 0ae4d47a4663..2dfdaab0aa1f 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2412.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c2412/pm.c
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * http://armlinux.simtec.co.uk/.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2006 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// http://armlinux.simtec.co.uk/.
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2416.c b/arch/arm/mach-s3c24xx/pm-s3c2416.c
index b5bbf0d5985c..9a2f05e279d4 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2416.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2416.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c2416/pm.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * S3C2416 - PM support (Based on Ben Dooks' S3C2412 PM support)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2010 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+//
+// S3C2416 - PM support (Based on Ben Dooks' S3C2412 PM support)
 
 #include <linux/device.h>
 #include <linux/syscore_ops.h>
diff --git a/arch/arm/mach-s3c24xx/pm.c b/arch/arm/mach-s3c24xx/pm.c
index 5d510bca0844..adcb90645460 100644
--- a/arch/arm/mach-s3c24xx/pm.c
+++ b/arch/arm/mach-s3c24xx/pm.c
@@ -1,30 +1,15 @@
-/* linux/arch/arm/plat-s3c24xx/pm.c
- *
- * Copyright (c) 2004-2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX Power Manager (Suspend-To-RAM) support
- *
- * See Documentation/arm/Samsung-S3C24XX/Suspend.txt for more information
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- * Parts based on arch/arm/mach-pxa/pm.c
- *
- * Thanks to Dimitry Andric for debugging
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2004-2006 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// S3C24XX Power Manager (Suspend-To-RAM) support
+//
+// See Documentation/arm/Samsung-S3C24XX/Suspend.txt for more information
+//
+// Parts based on arch/arm/mach-pxa/pm.c
+//
+// Thanks to Dimitry Andric for debugging
 
 #include <linux/init.h>
 #include <linux/suspend.h>
diff --git a/arch/arm/mach-s3c24xx/regs-dsc.h b/arch/arm/mach-s3c24xx/regs-dsc.h
index 61b3d1387d76..b500636276f2 100644
--- a/arch/arm/mach-s3c24xx/regs-dsc.h
+++ b/arch/arm/mach-s3c24xx/regs-dsc.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2004 Simtec Electronics <linux@simtec.co.uk>
  *		      http://www.simtec.co.uk/products/SWLINUX/
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * S3C2440/S3C2412 Signal Drive Strength Control
-*/
+ */
 
 
 #ifndef __ASM_ARCH_REGS_DSC_H
diff --git a/arch/arm/mach-s3c24xx/regs-mem.h b/arch/arm/mach-s3c24xx/regs-mem.h
index 86b1258368c2..2f3bc48b5890 100644
--- a/arch/arm/mach-s3c24xx/regs-mem.h
+++ b/arch/arm/mach-s3c24xx/regs-mem.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2004 Simtec Electronics <linux@simtec.co.uk>
  *		http://www.simtec.co.uk/products/SWLINUX/
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * S3C2410 Memory Control register definitions
  */
 
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index 5061d66ca10c..21fd5404bc98 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c2410/s3c2410.c
- *
- * Copyright (c) 2003-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * http://www.simtec.co.uk/products/EB2410ITX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2003-2005 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// http://www.simtec.co.uk/products/EB2410ITX/
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2412-power.h b/arch/arm/mach-s3c24xx/s3c2412-power.h
index 1b02c5ddb31b..0031cfaa1d76 100644
--- a/arch/arm/mach-s3c24xx/s3c2412-power.h
+++ b/arch/arm/mach-s3c24xx/s3c2412-power.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2003-2006 Simtec Electronics <linux@simtec.co.uk>
  *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __ARCH_ARM_MACH_S3C24XX_S3C2412_POWER_H
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index fb5ee8d38913..8fe4d4670dcb 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -1,13 +1,9 @@
-/*
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * http://armlinux.simtec.co.uk/.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2006 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// http://armlinux.simtec.co.uk/.
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
index 621b8648a7ef..1cdb7bd3e713 100644
--- a/arch/arm/mach-s3c24xx/s3c2416.c
+++ b/arch/arm/mach-s3c24xx/s3c2416.c
@@ -1,26 +1,11 @@
-/* linux/arch/arm/mach-s3c2416/s3c2416.c
- *
- * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
- *	as part of OpenInkpot project
- * Copyright (c) 2009 Promwad Innovation Company
- *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
- *
- * Samsung S3C2416 Mobile CPU support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
+//	as part of OpenInkpot project
+// Copyright (c) 2009 Promwad Innovation Company
+//	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
+//
+// Samsung S3C2416 Mobile CPU support
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2440.c b/arch/arm/mach-s3c24xx/s3c2440.c
index eb733555fab5..451d9851b0a7 100644
--- a/arch/arm/mach-s3c24xx/s3c2440.c
+++ b/arch/arm/mach-s3c24xx/s3c2440.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c2440/s3c2440.c
- *
- * Copyright (c) 2004-2006 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * Samsung S3C2440 Mobile CPU support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2004-2006 Simtec Electronics
+//   Ben Dooks <ben@simtec.co.uk>
+//
+// Samsung S3C2440 Mobile CPU support
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2442.c b/arch/arm/mach-s3c24xx/s3c2442.c
index 893998ede022..432d68325c9d 100644
--- a/arch/arm/mach-s3c24xx/s3c2442.c
+++ b/arch/arm/mach-s3c24xx/s3c2442.c
@@ -1,25 +1,10 @@
-/* linux/arch/arm/mach-s3c2442/s3c2442.c
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2442 core and lock support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2004-2005 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// S3C2442 core and lock support
 
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
index b559d378cf43..313e369c3ddd 100644
--- a/arch/arm/mach-s3c24xx/s3c2443.c
+++ b/arch/arm/mach-s3c24xx/s3c2443.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/mach-s3c2443/s3c2443.c
- *
- * Copyright (c) 2007 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * Samsung S3C2443 Mobile CPU support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2007 Simtec Electronics
+//   Ben Dooks <ben@simtec.co.uk>
+//
+// Samsung S3C2443 Mobile CPU support
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index 31fd273269c2..a75f588b9d45 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/plat-s3c24xx/s3c244x.c
- *
- * Copyright (c) 2004-2006 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * Samsung S3C2440 and S3C2442 Mobile CPU support (not S3C2443)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2004-2006 Simtec Electronics
+//   Ben Dooks <ben@simtec.co.uk>
+//
+// Samsung S3C2440 and S3C2442 Mobile CPU support (not S3C2443)
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/setup-camif.c b/arch/arm/mach-s3c24xx/setup-camif.c
index 72d8edb8927a..2b262fae3f61 100644
--- a/arch/arm/mach-s3c24xx/setup-camif.c
+++ b/arch/arm/mach-s3c24xx/setup-camif.c
@@ -1,12 +1,8 @@
-/*
- * Copyright (C) 2012 Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
- *
- * Helper functions for S3C24XX/S3C64XX SoC series CAMIF driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2012 Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
+//
+// Helper functions for S3C24XX/S3C64XX SoC series CAMIF driver
 
 #include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c24xx/setup-i2c.c b/arch/arm/mach-s3c24xx/setup-i2c.c
index 1852696ca16e..1a01d44b5910 100644
--- a/arch/arm/mach-s3c24xx/setup-i2c.c
+++ b/arch/arm/mach-s3c24xx/setup-i2c.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/plat-s3c24xx/setup-i2c.c
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX Base setup for i2c device
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// S3C24XX Base setup for i2c device
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
index c99b0f664db7..218346a36d1e 100644
--- a/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/plat-s3c2416/setup-sdhci-gpio.c
- *
- * Copyright 2010 Promwad Innovation Company
- *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
- *
- * S3C2416 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
- *
- * Based on mach-s3c64xx/setup-sdhci-gpio.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2010 Promwad Innovation Company
+//	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
+//
+// S3C2416 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
+//
+// Based on mach-s3c64xx/setup-sdhci-gpio.c
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/setup-spi.c b/arch/arm/mach-s3c24xx/setup-spi.c
index 3d47e023ce94..6c2b96a82da5 100644
--- a/arch/arm/mach-s3c24xx/setup-spi.c
+++ b/arch/arm/mach-s3c24xx/setup-spi.c
@@ -1,13 +1,9 @@
-/*
- * HS-SPI device setup for S3C2443/S3C2416
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
+// HS-SPI device setup for S3C2443/S3C2416
+//
+// Copyright (C) 2011 Samsung Electronics Ltd.
+//		http://www.samsung.com/
 
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-s3c24xx/setup-ts.c b/arch/arm/mach-s3c24xx/setup-ts.c
index 46466d20257e..53a14d4f4852 100644
--- a/arch/arm/mach-s3c24xx/setup-ts.c
+++ b/arch/arm/mach-s3c24xx/setup-ts.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/plat-s3c24xx/setup-ts.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *                     http://www.samsung.com/
- *
- * Based on S3C24XX setup for i2c device
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2010 Samsung Electronics Co., Ltd.
+//                     http://www.samsung.com/
+//
+// Based on S3C24XX setup for i2c device
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-s3c24xx/simtec-audio.c b/arch/arm/mach-s3c24xx/simtec-audio.c
index 67cb5120dfeb..12e17f82dae3 100644
--- a/arch/arm/mach-s3c24xx/simtec-audio.c
+++ b/arch/arm/mach-s3c24xx/simtec-audio.c
@@ -1,15 +1,10 @@
-/* linux/arch/arm/plat-s3c24xx/simtec-audio.c
- *
- * Copyright (c) 2009 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Audio setup for various Simtec S3C24XX implementations
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2009 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// Audio setup for various Simtec S3C24XX implementations
 
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
diff --git a/arch/arm/mach-s3c24xx/simtec-nor.c b/arch/arm/mach-s3c24xx/simtec-nor.c
index 8884bffa619a..26b18497e959 100644
--- a/arch/arm/mach-s3c24xx/simtec-nor.c
+++ b/arch/arm/mach-s3c24xx/simtec-nor.c
@@ -1,15 +1,10 @@
-/* linux/arch/arm/mach-s3c2410/nor-simtec.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Simtec NOR mapping
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2008 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// Simtec NOR mapping
 
 #include <linux/module.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/simtec-pm.c b/arch/arm/mach-s3c24xx/simtec-pm.c
index 38a2f1fdebab..c19074d81389 100644
--- a/arch/arm/mach-s3c24xx/simtec-pm.c
+++ b/arch/arm/mach-s3c24xx/simtec-pm.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/plat-s3c24xx/pm-simtec.c
- *
- * Copyright 2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * http://armlinux.simtec.co.uk/
- *
- * Power Management helpers for Simtec S3C24XX implementations
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2004 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// http://armlinux.simtec.co.uk/
+//
+// Power Management helpers for Simtec S3C24XX implementations
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/simtec-usb.c b/arch/arm/mach-s3c24xx/simtec-usb.c
index b70aa66efebe..dc1016ffed94 100644
--- a/arch/arm/mach-s3c24xx/simtec-usb.c
+++ b/arch/arm/mach-s3c24xx/simtec-usb.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/mach-s3c2410/usb-simtec.c
- *
- * Copyright 2004-2005 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * http://www.simtec.co.uk/products/EB2410ITX/
- *
- * Simtec BAST and Thorcom VR1000 USB port support functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2004-2005 Simtec Electronics
+//   Ben Dooks <ben@simtec.co.uk>
+//
+// http://www.simtec.co.uk/products/EB2410ITX/
+//
+// Simtec BAST and Thorcom VR1000 USB port support functions
 
 #define DEBUG
 
diff --git a/arch/arm/mach-s3c24xx/simtec.h b/arch/arm/mach-s3c24xx/simtec.h
index ae8f4f9ad2ee..d96bd60872b8 100644
--- a/arch/arm/mach-s3c24xx/simtec.h
+++ b/arch/arm/mach-s3c24xx/simtec.h
@@ -1,15 +1,11 @@
-/* linux/arch/arm/mach-s3c2410/nor-simtec.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * Simtec common functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 struct s3c24xx_audio_simtec_pdata;
 
diff --git a/arch/arm/mach-s3c24xx/sleep-s3c2410.S b/arch/arm/mach-s3c24xx/sleep-s3c2410.S
index 875ba8911127..659f9eff9de2 100644
--- a/arch/arm/mach-s3c24xx/sleep-s3c2410.S
+++ b/arch/arm/mach-s3c24xx/sleep-s3c2410.S
@@ -1,5 +1,5 @@
-/* linux/arch/arm/mach-s3c2410/sleep.S
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (c) 2004 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
@@ -8,21 +8,7 @@
  * Based on PXA/SA1100 sleep code by:
  *	Nicolas Pitre, (c) 2002 Monta Vista Software Inc
  *	Cliff Brake, (c) 2001
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+ */
 
 #include <linux/linkage.h>
 #include <linux/serial_s3c.h>
diff --git a/arch/arm/mach-s3c24xx/sleep-s3c2412.S b/arch/arm/mach-s3c24xx/sleep-s3c2412.S
index 6bf5b4d8743c..c373f1ca862b 100644
--- a/arch/arm/mach-s3c24xx/sleep-s3c2412.S
+++ b/arch/arm/mach-s3c24xx/sleep-s3c2412.S
@@ -1,24 +1,10 @@
-/* linux/arch/arm/mach-s3c2412/sleep.S
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (c) 2007 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C2412 Power Manager low-level sleep support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+ */
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
diff --git a/arch/arm/mach-s3c24xx/sleep.S b/arch/arm/mach-s3c24xx/sleep.S
index b859268fa8da..f0f11ad60c52 100644
--- a/arch/arm/mach-s3c24xx/sleep.S
+++ b/arch/arm/mach-s3c24xx/sleep.S
@@ -1,5 +1,5 @@
-/* linux/arch/arm/plat-s3c24xx/sleep.S
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (c) 2004 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
@@ -8,21 +8,7 @@
  * Based on PXA/SA1100 sleep code by:
  *	Nicolas Pitre, (c) 2002 Monta Vista Software Inc
  *	Cliff Brake, (c) 2001
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+ */
 
 #include <linux/linkage.h>
 #include <linux/serial_s3c.h>
diff --git a/arch/arm/mach-s3c24xx/spi-core.h b/arch/arm/mach-s3c24xx/spi-core.h
index 0b9428ab3fc3..bb555ccbe057 100644
--- a/arch/arm/mach-s3c24xx/spi-core.h
+++ b/arch/arm/mach-s3c24xx/spi-core.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2012 Heiko Stuebner <heiko@sntech.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __PLAT_S3C_SPI_CORE_H
diff --git a/arch/arm/mach-s3c24xx/vr1000.h b/arch/arm/mach-s3c24xx/vr1000.h
index 7fcd2c2f183c..3cfa296bec2a 100644
--- a/arch/arm/mach-s3c24xx/vr1000.h
+++ b/arch/arm/mach-s3c24xx/vr1000.h
@@ -1,17 +1,12 @@
-
-/* arch/arm/mach-s3c2410/include/mach/vr1000-cpld.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2003 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * VR1000 - CPLD control constants
  * Machine VR1000 - IRQ Number definitions
  * Machine VR1000 - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __MACH_S3C24XX_VR1000_H
 #define __MACH_S3C24XX_VR1000_H __FILE__
-- 
2.7.4
