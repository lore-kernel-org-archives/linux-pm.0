From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/5] ARM: S5PV210: Add SPDX license identifier
Date: Mon, 25 Dec 2017 20:54:34 +0100
Message-ID: <1514231675-17582-4-git-send-email-krzk@kernel.org>
References: <1514231675-17582-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1514231675-17582-1-git-send-email-krzk@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philippe Ombredanne <pombredanne@nexb.com>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Simtec Linux Team <linux@simtec.co.uk>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, patches@opensource.cirrus.com
Cc: Olof Johansson <olof@lixom.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Replace GPL license statements with a SPDX license indentifiers (GPL-2.0
and GPL-2.0+).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s5pv210/Kconfig      |  4 +---
 arch/arm/mach-s5pv210/Makefile     |  4 +---
 arch/arm/mach-s5pv210/common.h     |  5 +----
 arch/arm/mach-s5pv210/pm.c         | 25 ++++++++++---------------
 arch/arm/mach-s5pv210/regs-clock.h |  7 ++-----
 arch/arm/mach-s5pv210/s5pv210.c    | 18 +++++++-----------
 arch/arm/mach-s5pv210/sleep.S      |  6 +-----
 7 files changed, 23 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 4cec11cf5e6f..03984a791879 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -1,9 +1,7 @@
-# arch/arm/mach-s5pv210/Kconfig
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (c) 2010 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
-#
-# Licensed under GPLv2
 
 # Configuration options for the S5PV210/S5PC110
 
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index fa7fb716e388..e7b551e18e5c 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -1,9 +1,7 @@
-# arch/arm/mach-s5pv210/Makefile
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (c) 2010 Samsung Electronics Co., Ltd.
 # 		http://www.samsung.com/
-#
-# Licensed under GPLv2
 
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/arch/arm/plat-samsung/include
 
diff --git a/arch/arm/mach-s5pv210/common.h b/arch/arm/mach-s5pv210/common.h
index 2ad387c1ecf0..0a188134deae 100644
--- a/arch/arm/mach-s5pv210/common.h
+++ b/arch/arm/mach-s5pv210/common.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Common Header for S5PV210 machines
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __ARCH_ARM_MACH_S5PV210_COMMON_H
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index 07cee14a363b..f491249ab658 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -1,18 +1,13 @@
-/* linux/arch/arm/mach-s5pv210/pm.c
- *
- * Copyright (c) 2010-2014 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * S5PV210 - Power Management support
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
+// Copyright (c) 2010-2014 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+//
+// S5PV210 - Power Management support
+//
+// Based on arch/arm/mach-s3c2410/pm.c
+// Copyright (c) 2006 Simtec Electronics
+//	Ben Dooks <ben@simtec.co.uk>
 
 #include <linux/init.h>
 #include <linux/suspend.h>
diff --git a/arch/arm/mach-s5pv210/regs-clock.h b/arch/arm/mach-s5pv210/regs-clock.h
index fb3eb77412db..2a35c831a9b0 100644
--- a/arch/arm/mach-s5pv210/regs-clock.h
+++ b/arch/arm/mach-s5pv210/regs-clock.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * S5PV210 - Clock register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __ASM_ARCH_REGS_CLOCK_H
 #define __ASM_ARCH_REGS_CLOCK_H __FILE__
diff --git a/arch/arm/mach-s5pv210/s5pv210.c b/arch/arm/mach-s5pv210/s5pv210.c
index 83e656ea95ae..868f9c20419d 100644
--- a/arch/arm/mach-s5pv210/s5pv210.c
+++ b/arch/arm/mach-s5pv210/s5pv210.c
@@ -1,14 +1,10 @@
-/*
- * Samsung's S5PC110/S5PV210 flattened device tree enabled machine.
- *
- * Copyright (c) 2013-2014 Samsung Electronics Co., Ltd.
- * Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
- * Tomasz Figa <t.figa@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Samsung's S5PC110/S5PV210 flattened device tree enabled machine.
+//
+// Copyright (c) 2013-2014 Samsung Electronics Co., Ltd.
+// Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
+// Tomasz Figa <t.figa@samsung.com>
 
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
diff --git a/arch/arm/mach-s5pv210/sleep.S b/arch/arm/mach-s5pv210/sleep.S
index dfbfc0f7f8b8..81568767f30a 100644
--- a/arch/arm/mach-s5pv210/sleep.S
+++ b/arch/arm/mach-s5pv210/sleep.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -5,11 +6,6 @@
  * S5PV210 Sleep Code
  * Based on S3C64XX sleep code by:
  *	Ben Dooks, (c) 2008 Simtec Electronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/linkage.h>
-- 
2.7.4
