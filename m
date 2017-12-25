From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/5] ARM: EXYNOS: Add SPDX license identifier
Date: Mon, 25 Dec 2017 20:54:31 +0100
Message-ID: <1514231675-17582-1-git-send-email-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752403AbdLYTyx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Dec 2017 14:54:53 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Ombredanne <pombredanne@nexb.com>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Simtec Linux Team <linux@simtec.co.uk>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, patches@opensource.cirrus.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Replace GPL license statements with a SPDX license indentifiers (GPL-2.0
and GPL-2.0+).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-exynos/Kconfig            |  4 +---
 arch/arm/mach-exynos/Makefile           |  4 +---
 arch/arm/mach-exynos/common.h           |  5 +----
 arch/arm/mach-exynos/exynos-smc.S       |  5 +----
 arch/arm/mach-exynos/exynos.c           | 16 ++++++----------
 arch/arm/mach-exynos/firmware.c         | 14 +++++---------
 arch/arm/mach-exynos/headsmp.S          |  6 +-----
 arch/arm/mach-exynos/include/mach/map.h |  7 ++-----
 arch/arm/mach-exynos/mcpm-exynos.c      | 17 +++++------------
 arch/arm/mach-exynos/platsmp.c          | 21 ++++++++-------------
 arch/arm/mach-exynos/pm.c               | 24 ++++++++++--------------
 arch/arm/mach-exynos/sleep.S            | 11 +----------
 arch/arm/mach-exynos/smc.h              |  5 +----
 arch/arm/mach-exynos/suspend.c          | 24 ++++++++++--------------
 14 files changed, 53 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 44fa753bd79c..647c319f9f5f 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -1,9 +1,7 @@
-# arch/arm/mach-exynos/Kconfig
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
-#
-# Licensed under GPLv2
 
 # Configuration options for the EXYNOS
 
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 9ea6c54645ad..cd00c82a1add 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -1,9 +1,7 @@
-# arch/arm/mach-exynos/Makefile
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
-#
-# Licensed under GPLv2
 
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
 
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 3f715524c9d6..098f84a149a3 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Common Header for EXYNOS machines
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __ARCH_ARM_MACH_EXYNOS_COMMON_H
diff --git a/arch/arm/mach-exynos/exynos-smc.S b/arch/arm/mach-exynos/exynos-smc.S
index 2e27aa3813fd..d259532ba937 100644
--- a/arch/arm/mach-exynos/exynos-smc.S
+++ b/arch/arm/mach-exynos/exynos-smc.S
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2012 Samsung Electronics.
  *
  * Copied from omap-smc.S Copyright (C) 2010 Texas Instruments, Inc.
- *
- * This program is free software,you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 9a9caac1125a..fbd108ce8745 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -1,13 +1,9 @@
-/*
- * SAMSUNG EXYNOS Flattened Device Tree enabled machine
- *
- * Copyright (c) 2010-2014 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// SAMSUNG EXYNOS Flattened Device Tree enabled machine
+//
+// Copyright (c) 2010-2014 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
 
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 2a51e4603a6f..be1f20fe28f4 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -1,12 +1,8 @@
-/*
- * Copyright (C) 2012 Samsung Electronics.
- * Kyungmin Park <kyungmin.park@samsung.com>
- * Tomasz Figa <t.figa@samsung.com>
- *
- * This program is free software,you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2012 Samsung Electronics.
+// Kyungmin Park <kyungmin.park@samsung.com>
+// Tomasz Figa <t.figa@samsung.com>
 
 #include <linux/kernel.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-exynos/headsmp.S b/arch/arm/mach-exynos/headsmp.S
index d3d24ab351ae..005695c9bf40 100644
--- a/arch/arm/mach-exynos/headsmp.S
+++ b/arch/arm/mach-exynos/headsmp.S
@@ -1,13 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- *
  *  Cloned from linux/arch/arm/mach-realview/headsmp.S
  *
  *  Copyright (c) 2003 ARM Limited
  *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 5fb0040cc6d3..37a5ea5e2602 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * EXYNOS - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_ARCH_MAP_H
 #define __ASM_ARCH_MAP_H __FILE__
diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index b42622562ea7..72bc035bedbe 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -1,15 +1,8 @@
-/*
- * Copyright (c) 2014 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * arch/arm/mach-exynos/mcpm-exynos.c
- *
- * Based on arch/arm/mach-vexpress/dcscb.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2014 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+//
+// Based on arch/arm/mach-vexpress/dcscb.c
 
 #include <linux/arm-cci.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 5a03bffe7226..5156fe70e030 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -1,16 +1,11 @@
- /*
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Cloned from linux/arch/arm/mach-vexpress/platsmp.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+//
+// Cloned from linux/arch/arm/mach-vexpress/platsmp.c
+//
+//  Copyright (C) 2002 ARM Ltd.
+//  All Rights Reserved
 
 #include <linux/init.h>
 #include <linux/errno.h>
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index c9740d96db9e..dc4346ecf16d 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -1,17 +1,13 @@
-/*
- * Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS - Power Management support
- *
- * Based on arch/arm/mach-s3c2410/pm.c
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+//
+// EXYNOS - Power Management support
+//
+// Based on arch/arm/mach-s3c2410/pm.c
+// Copyright (c) 2006 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
 
 #include <linux/init.h>
 #include <linux/suspend.h>
diff --git a/arch/arm/mach-exynos/sleep.S b/arch/arm/mach-exynos/sleep.S
index 4292cae43f3c..2783c3a0c06a 100644
--- a/arch/arm/mach-exynos/sleep.S
+++ b/arch/arm/mach-exynos/sleep.S
@@ -1,18 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Exynos low-level resume code
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
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-exynos/smc.h b/arch/arm/mach-exynos/smc.h
index c2845717bc8f..f355185d4239 100644
--- a/arch/arm/mach-exynos/smc.h
+++ b/arch/arm/mach-exynos/smc.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  Copyright (c) 2012 Samsung Electronics.
  *
  * EXYNOS - SMC Call
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __ASM_ARCH_EXYNOS_SMC_H
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 370d37ded7e7..c2ed997fedef 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -1,17 +1,13 @@
-/*
- * Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS - Suspend support
- *
- * Based on arch/arm/mach-s3c2410/pm.c
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+//
+// EXYNOS - Suspend support
+//
+// Based on arch/arm/mach-s3c2410/pm.c
+// Copyright (c) 2006 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
 
 #include <linux/init.h>
 #include <linux/suspend.h>
-- 
2.7.4
