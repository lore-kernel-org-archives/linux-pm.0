From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/5] ARM: SAMSUNG: Add SPDX license identifier
Date: Mon, 25 Dec 2017 20:54:35 +0100
Message-ID: <1514231675-17582-5-git-send-email-krzk@kernel.org>
References: <1514231675-17582-1-git-send-email-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514231675-17582-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Ombredanne <pombredanne@nexb.com>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Simtec Linux Team <linux@simtec.co.uk>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, patches@opensource.cirrus.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Replace GPL license statements with a SPDX license indentifiers
(GPL-1.0+, GPL-2.0 and GPL-2.0+).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/plat-samsung/Kconfig                      |  4 +---
 arch/arm/plat-samsung/Makefile                     |  4 +---
 arch/arm/plat-samsung/adc.c                        | 19 ++++++----------
 arch/arm/plat-samsung/cpu.c                        | 17 +++++---------
 arch/arm/plat-samsung/dev-uart.c                   | 21 +++++++----------
 arch/arm/plat-samsung/devs.c                       | 17 +++++---------
 arch/arm/plat-samsung/gpio-samsung.c               | 26 +++++++++-------------
 arch/arm/plat-samsung/include/plat/adc-core.h      | 10 +++------
 arch/arm/plat-samsung/include/plat/adc.h           | 10 +++------
 arch/arm/plat-samsung/include/plat/cpu-freq-core.h | 10 +++------
 arch/arm/plat-samsung/include/plat/cpu-freq.h      | 10 +++------
 arch/arm/plat-samsung/include/plat/cpu.h           | 10 +++------
 arch/arm/plat-samsung/include/plat/devs.h          | 10 +++------
 arch/arm/plat-samsung/include/plat/fb-s3c2410.h    |  8 ++-----
 arch/arm/plat-samsung/include/plat/fb.h            | 10 +++------
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   | 10 +++------
 arch/arm/plat-samsung/include/plat/gpio-cfg.h      | 10 +++------
 arch/arm/plat-samsung/include/plat/gpio-core.h     | 10 +++------
 arch/arm/plat-samsung/include/plat/iic-core.h      | 10 +++------
 arch/arm/plat-samsung/include/plat/keypad.h        |  6 +----
 arch/arm/plat-samsung/include/plat/map-base.h      | 10 +++------
 arch/arm/plat-samsung/include/plat/map-s3c.h       | 10 +++------
 arch/arm/plat-samsung/include/plat/map-s5p.h       | 10 +++------
 arch/arm/plat-samsung/include/plat/pm-common.h     |  7 ++----
 arch/arm/plat-samsung/include/plat/pm.h            | 10 +++------
 arch/arm/plat-samsung/include/plat/pwm-core.h      |  5 +----
 arch/arm/plat-samsung/include/plat/regs-adc.h      | 10 +++------
 arch/arm/plat-samsung/include/plat/regs-irqtype.h  |  8 ++-----
 arch/arm/plat-samsung/include/plat/regs-spi.h      | 10 +++------
 arch/arm/plat-samsung/include/plat/regs-udc.h      | 11 +++------
 arch/arm/plat-samsung/include/plat/samsung-time.h  | 10 +++------
 arch/arm/plat-samsung/include/plat/sdhci.h         | 10 +++------
 arch/arm/plat-samsung/include/plat/usb-phy.h       |  6 +----
 arch/arm/plat-samsung/include/plat/wakeup-mask.h   | 11 +++------
 arch/arm/plat-samsung/init.c                       | 19 ++++++----------
 arch/arm/plat-samsung/platformdata.c               | 15 +++++--------
 arch/arm/plat-samsung/pm-check.c                   | 22 ++++++++----------
 arch/arm/plat-samsung/pm-common.c                  | 24 +++++++++-----------
 arch/arm/plat-samsung/pm-debug.c                   | 24 +++++++++-----------
 arch/arm/plat-samsung/pm-gpio.c                    | 22 +++++++-----------
 arch/arm/plat-samsung/pm.c                         | 21 +++++++----------
 arch/arm/plat-samsung/wakeup-mask.c                | 15 +++++--------
 arch/arm/plat-samsung/watchdog-reset.c             | 21 +++++++----------
 43 files changed, 182 insertions(+), 361 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 8d4a64cc644c..b600e38364eb 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -1,8 +1,6 @@
-# arch/arm/plat-samsung/Kconfig
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright 2009 Simtec Electronics
-#
-# Licensed under GPLv2
 
 config PLAT_SAMSUNG
 	bool
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index be172efec15c..3db9d2c38258 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -1,8 +1,6 @@
-# arch/arm/plat-samsung/Makefile
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright 2009 Simtec Electronics
-#
-# Licensed under GPLv2
 
 ccflags-$(CONFIG_ARCH_S3C64XX) := -I$(srctree)/arch/arm/mach-s3c64xx/include
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index e9de9e92ce01..42bac8d5ab5d 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -1,15 +1,10 @@
-/* arch/arm/plat-samsung/adc.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
- *
- * Samsung ADC device core
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License.
-*/
+// SPDX-License-Identifier: GPL-1.0+
+//
+// Copyright (c) 2008 Simtec Electronics
+//	http://armlinux.simtec.co.uk/
+//	Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
+//
+// Samsung ADC device core
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
index a107b3a0b095..e1ba88ba31d8 100644
--- a/arch/arm/plat-samsung/cpu.c
+++ b/arch/arm/plat-samsung/cpu.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/plat-samsung/cpu.c
- *
- * Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Samsung CPU Support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+//
+// Samsung CPU Support
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/plat-samsung/dev-uart.c b/arch/arm/plat-samsung/dev-uart.c
index 5928105490fa..7476a5dbae77 100644
--- a/arch/arm/plat-samsung/dev-uart.c
+++ b/arch/arm/plat-samsung/dev-uart.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/plat-samsung/dev-uart.c
- *	originally from arch/arm/plat-s3c24xx/devs.c
- *x
- * Copyright (c) 2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Base S3C24XX platform device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+//	originally from arch/arm/plat-s3c24xx/devs.c
+//
+// Copyright (c) 2004 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// Base S3C24XX platform device definitions
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 5668e4eb03df..1d1fa068d228 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1,14 +1,9 @@
-/* linux/arch/arm/plat-samsung/devs.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Base SAMSUNG platform device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+//
+// Base SAMSUNG platform device definitions
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/plat-samsung/gpio-samsung.c b/arch/arm/plat-samsung/gpio-samsung.c
index 7861488f7ca0..f66c820cd82b 100644
--- a/arch/arm/plat-samsung/gpio-samsung.c
+++ b/arch/arm/plat-samsung/gpio-samsung.c
@@ -1,18 +1,14 @@
-/*
- * Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * SAMSUNG - GPIOlib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com/
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//      Ben Dooks <ben@simtec.co.uk>
+//      http://armlinux.simtec.co.uk/
+//
+// SAMSUNG - GPIOlib support
 
 #include <linux/kernel.h>
 #include <linux/irq.h>
diff --git a/arch/arm/plat-samsung/include/plat/adc-core.h b/arch/arm/plat-samsung/include/plat/adc-core.h
index a927bee55359..039f6862b6a7 100644
--- a/arch/arm/plat-samsung/include/plat/adc-core.h
+++ b/arch/arm/plat-samsung/include/plat/adc-core.h
@@ -1,14 +1,10 @@
-/* linux/arch/arm/plat-samsung/include/plat/adc-core.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * Samsung ADC Controller core functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_PLAT_ADC_CORE_H
 #define __ASM_PLAT_ADC_CORE_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/adc.h b/arch/arm/plat-samsung/include/plat/adc.h
index 2fc89315553f..74d1a46408c1 100644
--- a/arch/arm/plat-samsung/include/plat/adc.h
+++ b/arch/arm/plat-samsung/include/plat/adc.h
@@ -1,15 +1,11 @@
-/* arch/arm/plat-samsung/include/plat/adc.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/	
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C ADC driver information
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_PLAT_ADC_H
 #define __ASM_PLAT_ADC_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h b/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
index 37cf20e04aff..2c7cf2665634 100644
--- a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
+++ b/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
@@ -1,15 +1,11 @@
-/* arch/arm/plat-samsung/include/plat/cpu-freq-core.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2006-2009 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C CPU frequency scaling support - core support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <plat/cpu-freq.h>
 
diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq.h b/arch/arm/plat-samsung/include/plat/cpu-freq.h
index 85517ab962ae..558892bcf9b6 100644
--- a/arch/arm/plat-samsung/include/plat/cpu-freq.h
+++ b/arch/arm/plat-samsung/include/plat/cpu-freq.h
@@ -1,15 +1,11 @@
-/* arch/arm/plat-samsung/include/plat/cpu-freq.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2006-2007 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C CPU frequency scaling support - driver and board
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <linux/cpufreq.h>
 
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index b7b702a72cac..fadcddbea064 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -1,5 +1,5 @@
-/* linux/arch/arm/plat-samsung/include/plat/cpu.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
@@ -7,11 +7,7 @@
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * Header file for Samsung CPU support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /* todo - fix when rmk changes iodescs to use `void __iomem *` */
 
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index e23fed311e5f..02b0c5750572 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -1,5 +1,5 @@
-/* arch/arm/plat-samsung/include/plat/devs.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
@@ -7,11 +7,7 @@
  * Ben Dooks <ben@simtec.co.uk>
  *
  * Header file for s3c2410 standard platform devices
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __PLAT_DEVS_H
 #define __PLAT_DEVS_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/fb-s3c2410.h b/arch/arm/plat-samsung/include/plat/fb-s3c2410.h
index 1f2972a74e9f..614240d768b4 100644
--- a/arch/arm/plat-samsung/include/plat/fb-s3c2410.h
+++ b/arch/arm/plat-samsung/include/plat/fb-s3c2410.h
@@ -1,12 +1,8 @@
-/* arch/arm/plat-samsung/include/plat/fb-s3c2410.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2004 Arnaud Patard <arnaud.patard@rtp-net.org>
  *
  * Inspired by pxafb.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
 */
 
 #ifndef __ASM_PLAT_FB_S3C2410_H
diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index b89f8f208515..615d381ae32e 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -1,16 +1,12 @@
-/* arch/arm/plat-samsung/include/plat/fb.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C - FB platform data definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __PLAT_S3C_FB_H
 #define __PLAT_S3C_FB_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
index a181d7ce81cf..db0c56f5ca15 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
@@ -1,16 +1,12 @@
-/* linux/arch/arm/plat-samsung/include/plat/gpio-cfg-helper.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * Samsung Platform - GPIO pin configuration helper definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /* This is meant for core cpu support, machine or other driver files
  * should not be including this header.
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index e55d1f597db8..469c220e092b 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -1,16 +1,12 @@
-/* linux/arch/arm/plat-s3c/include/plat/gpio-cfg.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C Platform - GPIO pin configuration
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /* This file contains the necessary definitions to get the basic gpio
  * pin configuration done such as setting a pin to input or output or
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index 6ce11bfdc37e..51e721f5e491 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -1,15 +1,11 @@
-/* linux/arch/arm/plat-s3c/include/plat/gpio-core.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C Platform - GPIO core
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __PLAT_SAMSUNG_GPIO_CORE_H
 #define __PLAT_SAMSUNG_GPIO_CORE_H
diff --git a/arch/arm/plat-samsung/include/plat/iic-core.h b/arch/arm/plat-samsung/include/plat/iic-core.h
index f182669b8e8e..c5cfd5af3874 100644
--- a/arch/arm/plat-samsung/include/plat/iic-core.h
+++ b/arch/arm/plat-samsung/include/plat/iic-core.h
@@ -1,15 +1,11 @@
-/* arch/arm/mach-s3c2410/include/mach/iic-core.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C - I2C Controller core functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_ARCH_IIC_CORE_H
 #define __ASM_ARCH_IIC_CORE_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/keypad.h b/arch/arm/plat-samsung/include/plat/keypad.h
index c81ace332a1e..9754b9a29945 100644
--- a/arch/arm/plat-samsung/include/plat/keypad.h
+++ b/arch/arm/plat-samsung/include/plat/keypad.h
@@ -1,13 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Samsung Platform - Keypad platform data definitions
  *
  * Copyright (C) 2010 Samsung Electronics Co.Ltd
  * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #ifndef __PLAT_SAMSUNG_KEYPAD_H
diff --git a/arch/arm/plat-samsung/include/plat/map-base.h b/arch/arm/plat-samsung/include/plat/map-base.h
index 3ffac4d2e4f0..34b39ded0e2e 100644
--- a/arch/arm/plat-samsung/include/plat/map-base.h
+++ b/arch/arm/plat-samsung/include/plat/map-base.h
@@ -1,15 +1,11 @@
-/* linux/include/asm-arm/plat-s3c/map.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2003, 2007 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C - Memory map definitions (virtual addresses)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_PLAT_MAP_H
 #define __ASM_PLAT_MAP_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/map-s3c.h b/arch/arm/plat-samsung/include/plat/map-s3c.h
index 33104911862e..4244acbf4b65 100644
--- a/arch/arm/plat-samsung/include/plat/map-s3c.h
+++ b/arch/arm/plat-samsung/include/plat/map-s3c.h
@@ -1,14 +1,10 @@
-/* linux/arch/arm/plat-samsung/include/plat/map-s3c.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2008 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C24XX - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_PLAT_MAP_S3C_H
 #define __ASM_PLAT_MAP_S3C_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index 0fe2828f9354..f5769e93544a 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -1,14 +1,10 @@
-/* linux/arch/arm/plat-samsung/include/plat/map-s5p.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * S5P - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_PLAT_MAP_S5P_H
 #define __ASM_PLAT_MAP_S5P_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/pm-common.h b/arch/arm/plat-samsung/include/plat/pm-common.h
index 8705f9e0e288..1268bae04234 100644
--- a/arch/arm/plat-samsung/include/plat/pm-common.h
+++ b/arch/arm/plat-samsung/include/plat/pm-common.h
@@ -1,14 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2013 Samsung Electronics Co., Ltd.
  *	Tomasz Figa <t.figa@samsung.com>
  * Copyright (c) 2004 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Written by Ben Dooks, <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __PLAT_SAMSUNG_PM_COMMON_H
 #define __PLAT_SAMSUNG_PM_COMMON_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 9dd562ab0841..2746137f9794 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -1,13 +1,9 @@
-/* arch/arm/plat-samsung/include/plat/pm.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2004 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Written by Ben Dooks, <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /* s3c_pm_init
  *
diff --git a/arch/arm/plat-samsung/include/plat/pwm-core.h b/arch/arm/plat-samsung/include/plat/pwm-core.h
index 5bff1facb672..05e3448642a1 100644
--- a/arch/arm/plat-samsung/include/plat/pwm-core.h
+++ b/arch/arm/plat-samsung/include/plat/pwm-core.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2013 Tomasz Figa <tomasz.figa@gmail.com>
  *
  * Samsung PWM controller platform data helpers.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __ASM_ARCH_PWM_CORE_H
diff --git a/arch/arm/plat-samsung/include/plat/regs-adc.h b/arch/arm/plat-samsung/include/plat/regs-adc.h
index 70612100120f..58953c7381dd 100644
--- a/arch/arm/plat-samsung/include/plat/regs-adc.h
+++ b/arch/arm/plat-samsung/include/plat/regs-adc.h
@@ -1,13 +1,9 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-adc.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2004 Shannon Holland <holland@loser.net>
  *
- * This program is free software; yosu can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * S3C2410 ADC registers
-*/
+ */
 
 #ifndef __ASM_ARCH_REGS_ADC_H
 #define __ASM_ARCH_REGS_ADC_H "regs-adc.h"
diff --git a/arch/arm/plat-samsung/include/plat/regs-irqtype.h b/arch/arm/plat-samsung/include/plat/regs-irqtype.h
index c63cd3fc5ad3..ec5c4c5fdd8f 100644
--- a/arch/arm/plat-samsung/include/plat/regs-irqtype.h
+++ b/arch/arm/plat-samsung/include/plat/regs-irqtype.h
@@ -1,14 +1,10 @@
-/* arch/arm/plat-s3c/include/plat/regs-irqtype.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2008 Simtec Electronics
  *      Ben Dooks <ben@simtec.co.uk>
  *      http://armlinux.simtec.co.uk/
  *
  * S3C - IRQ detection types.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /* values for S3C2410_EXTINT0/1/2 and other cpus in the series, including
diff --git a/arch/arm/plat-samsung/include/plat/regs-spi.h b/arch/arm/plat-samsung/include/plat/regs-spi.h
index 552fe7cfe281..607844311566 100644
--- a/arch/arm/plat-samsung/include/plat/regs-spi.h
+++ b/arch/arm/plat-samsung/include/plat/regs-spi.h
@@ -1,13 +1,9 @@
-/* arch/arm/plat-samsung/include/plat/regs-spi.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2004 Fetron GmbH
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * S3C2410 SPI register definition
-*/
+ */
 
 #ifndef __ASM_ARCH_REGS_SPI_H
 #define __ASM_ARCH_REGS_SPI_H
diff --git a/arch/arm/plat-samsung/include/plat/regs-udc.h b/arch/arm/plat-samsung/include/plat/regs-udc.h
index 4003d3dab4e7..d8d2eeaca088 100644
--- a/arch/arm/plat-samsung/include/plat/regs-udc.h
+++ b/arch/arm/plat-samsung/include/plat/regs-udc.h
@@ -1,12 +1,7 @@
-/* arch/arm/plat-samsung/include/plat/regs-udc.h
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2004 Herbert Poetzl <herbert@13thfloor.at>
- *
- * This include file is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
-*/
+ */
 
 #ifndef __ASM_ARCH_REGS_UDC_H
 #define __ASM_ARCH_REGS_UDC_H
diff --git a/arch/arm/plat-samsung/include/plat/samsung-time.h b/arch/arm/plat-samsung/include/plat/samsung-time.h
index 209464adef97..d16eefe9ae78 100644
--- a/arch/arm/plat-samsung/include/plat/samsung-time.h
+++ b/arch/arm/plat-samsung/include/plat/samsung-time.h
@@ -1,14 +1,10 @@
-/* linux/arch/arm/plat-samsung/include/plat/samsung-time.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * Header file for samsung s3c and s5p time support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_PLAT_SAMSUNG_TIME_H
 #define __ASM_PLAT_SAMSUNG_TIME_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 2787553c3ae2..5731e42ea208 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -1,5 +1,5 @@
-/* linux/arch/arm/plat-samsung/include/plat/sdhci.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
@@ -9,11 +9,7 @@
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C Platform - SDHCI (HSMMC) platform data definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __PLAT_S3C_SDHCI_H
 #define __PLAT_S3C_SDHCI_H __FILE__
diff --git a/arch/arm/plat-samsung/include/plat/usb-phy.h b/arch/arm/plat-samsung/include/plat/usb-phy.h
index ab34dfadb7f9..6d0c788beb9d 100644
--- a/arch/arm/plat-samsung/include/plat/usb-phy.h
+++ b/arch/arm/plat-samsung/include/plat/usb-phy.h
@@ -1,11 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2011 Samsung Electronics Co.Ltd
  * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #ifndef __PLAT_SAMSUNG_USB_PHY_H
diff --git a/arch/arm/plat-samsung/include/plat/wakeup-mask.h b/arch/arm/plat-samsung/include/plat/wakeup-mask.h
index bbfa84b0505a..630909e6630b 100644
--- a/arch/arm/plat-samsung/include/plat/wakeup-mask.h
+++ b/arch/arm/plat-samsung/include/plat/wakeup-mask.h
@@ -1,14 +1,9 @@
-/* arch/arm/plat-samsung/include/plat/wakeup-mask.h
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
  *
  * Support for wakeup mask interrupts on newer SoCs
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
+ */
 
 #ifndef __PLAT_WAKEUP_MASK_H
 #define __PLAT_WAKEUP_MASK_H __file__
diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
index 3776f7e752f0..e9acf02ef3c3 100644
--- a/arch/arm/plat-samsung/init.c
+++ b/arch/arm/plat-samsung/init.c
@@ -1,15 +1,10 @@
-/* linux/arch/arm/plat-s3c/init.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series CPU initialisation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// S3C series CPU initialisation
 
 /*
  * NOTE: Code in this file is not used on S3C64xx when booting with
diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-samsung/platformdata.c
index 6cf52ee7eeec..cbc3b4b45c74 100644
--- a/arch/arm/plat-samsung/platformdata.c
+++ b/arch/arm/plat-samsung/platformdata.c
@@ -1,13 +1,8 @@
-/* linux/arch/arm/plat-samsung/platformdata.c
- *
- * Copyright 2010 Ben Dooks <ben-linux <at> fluff.org>
- *
- * Helper for platform data setting
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2010 Ben Dooks <ben-linux <at> fluff.org>
+//
+// Helper for platform data setting
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/arch/arm/plat-samsung/pm-check.c b/arch/arm/plat-samsung/pm-check.c
index d63516374f7c..cd2c02c68bc3 100644
--- a/arch/arm/plat-samsung/pm-check.c
+++ b/arch/arm/plat-samsung/pm-check.c
@@ -1,16 +1,12 @@
-/* linux/arch/arm/plat-s3c/pm-check.c
- *  originally in linux/arch/arm/plat-s3c24xx/pm.c
- *
- * Copyright (c) 2004-2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C Power Mangament - suspend/resume memory corruption check.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// originally in linux/arch/arm/plat-s3c24xx/pm.c
+//
+// Copyright (c) 2004-2008 Simtec Electronics
+//	http://armlinux.simtec.co.uk
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// S3C Power Mangament - suspend/resume memory corruption check.
 
 #include <linux/kernel.h>
 #include <linux/suspend.h>
diff --git a/arch/arm/plat-samsung/pm-common.c b/arch/arm/plat-samsung/pm-common.c
index 6534c3ff9fe2..59a10c6dcba1 100644
--- a/arch/arm/plat-samsung/pm-common.c
+++ b/arch/arm/plat-samsung/pm-common.c
@@ -1,17 +1,13 @@
-/*
- * Copyright (C) 2013 Samsung Electronics Co., Ltd.
- *	Tomasz Figa <t.figa@samsung.com>
- * Copyright (C) 2008 Openmoko, Inc.
- * Copyright (C) 2004-2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Samsung common power management helper functions.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2013 Samsung Electronics Co., Ltd.
+//	Tomasz Figa <t.figa@samsung.com>
+// Copyright (C) 2008 Openmoko, Inc.
+// Copyright (C) 2004-2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// Samsung common power management helper functions.
 
 #include <linux/io.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/plat-samsung/pm-debug.c b/arch/arm/plat-samsung/pm-debug.c
index 64e15da33b42..b76b1e9ba4ae 100644
--- a/arch/arm/plat-samsung/pm-debug.c
+++ b/arch/arm/plat-samsung/pm-debug.c
@@ -1,17 +1,13 @@
-/*
- * Copyright (C) 2013 Samsung Electronics Co., Ltd.
- *	Tomasz Figa <t.figa@samsung.com>
- * Copyright (C) 2008 Openmoko, Inc.
- * Copyright (C) 2004-2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Samsung common power management (suspend to RAM) debug support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2013 Samsung Electronics Co., Ltd.
+//	Tomasz Figa <t.figa@samsung.com>
+// Copyright (C) 2008 Openmoko, Inc.
+// Copyright (C) 2004-2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// Samsung common power management (suspend to RAM) debug support
 
 #include <linux/serial_core.h>
 #include <linux/serial_s3c.h>
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index f9a09262f2fa..cb2e3bc79336 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -1,17 +1,11 @@
-
-/* linux/arch/arm/plat-s3c/pm-gpio.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series GPIO PM code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// S3C series GPIO PM code
 
 #include <linux/kernel.h>
 #include <linux/device.h>
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index d7803b434732..d6bfd66592b0 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -1,16 +1,11 @@
-/* linux/arch/arm/plat-s3c/pm.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2004-2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C common power management (suspend to ram) support.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2008 Openmoko, Inc.
+// Copyright 2004-2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//	http://armlinux.simtec.co.uk/
+//
+// S3C common power management (suspend to ram) support.
 
 #include <linux/init.h>
 #include <linux/suspend.h>
diff --git a/arch/arm/plat-samsung/wakeup-mask.c b/arch/arm/plat-samsung/wakeup-mask.c
index b9de6b543330..24f96fb80738 100644
--- a/arch/arm/plat-samsung/wakeup-mask.c
+++ b/arch/arm/plat-samsung/wakeup-mask.c
@@ -1,13 +1,8 @@
-/* arch/arm/plat-samsung/wakeup-mask.c
- *
- * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
- *
- * Support for wakeup mask interrupts on newer SoCs
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2010 Ben Dooks <ben-linux@fluff.org>
+//
+// Support for wakeup mask interrupts on newer SoCs
 
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
diff --git a/arch/arm/plat-samsung/watchdog-reset.c b/arch/arm/plat-samsung/watchdog-reset.c
index 307d8ad96a78..ce42cc640a61 100644
--- a/arch/arm/plat-samsung/watchdog-reset.c
+++ b/arch/arm/plat-samsung/watchdog-reset.c
@@ -1,16 +1,11 @@
-/* arch/arm/plat-samsung/watchdog-reset.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
- *
- * Watchdog reset support for Samsung SoCs.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2008 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
+//
+// Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+//
+// Watchdog reset support for Samsung SoCs.
 
 #include <linux/clk.h>
 #include <linux/err.h>
-- 
2.7.4
