From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5/8] ARM: S3C64XX: move cpuidle driver to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:15:44 +0200
Message-ID: <1372241747-21083-6-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:56353 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab3FZKQu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:16:50 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MOZ00DLAWK0TXW0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 26 Jun 2013 19:16:48 +0900 (KST)
In-reply-to: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

While at it:
- remove file path from comment

Compile tested only.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-s3c64xx/Makefile    |  1 -
 arch/arm/mach-s3c64xx/cpuidle.c   | 63 ---------------------------------------
 drivers/cpuidle/Makefile          |  3 ++
 drivers/cpuidle/cpuidle-s3c64xx.c | 62 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 64 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-s3c64xx.c

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 31d0c91..e7a3ee7 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
 # PM
 
 obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 # DMA support
 
diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
deleted file mode 100644
index 3c8ab07..0000000
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ /dev/null
@@ -1,63 +0,0 @@
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
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/cpuidle.h>
-#include <linux/io.h>
-#include <linux/export.h>
-#include <linux/time.h>
-
-#include <asm/proc-fns.h>
-
-#include <mach/map.h>
-
-#include "regs-sys.h"
-#include "regs-syscon-power.h"
-
-static int s3c64xx_enter_idle(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv,
-			      int index)
-{
-	unsigned long tmp;
-
-	/* Setup PWRCFG to enter idle mode */
-	tmp = __raw_readl(S3C64XX_PWR_CFG);
-	tmp &= ~S3C64XX_PWRCFG_CFG_WFI_MASK;
-	tmp |= S3C64XX_PWRCFG_CFG_WFI_IDLE;
-	__raw_writel(tmp, S3C64XX_PWR_CFG);
-
-	cpu_do_idle();
-
-	return index;
-}
-
-static struct cpuidle_driver s3c64xx_cpuidle_driver = {
-	.name	= "s3c64xx_cpuidle",
-	.owner  = THIS_MODULE,
-	.states = {
-		{
-			.enter            = s3c64xx_enter_idle,
-			.exit_latency     = 1,
-			.target_residency = 1,
-			.flags            = CPUIDLE_FLAG_TIME_VALID,
-			.name             = "IDLE",
-			.desc             = "System active, ARM gated",
-		},
-	},
-	.state_count = 1,
-};
-
-static int __init s3c64xx_init_cpuidle(void)
-{
-	return cpuidle_register(&s3c64xx_cpuidle_driver, NULL);
-}
-device_initcall(s3c64xx_init_cpuidle);
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 6436c67..eed221e 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -31,4 +31,7 @@ ifeq ($(CONFIG_ARCH_OMAP4),y)
 	ccflags-y += -I$(srctree)/arch/arm/mach-omap2/include
 	obj-y += cpuidle-omap44xx.o
 endif
+ifeq ($(CONFIG_ARCH_S3C64XX),y)
+	obj-y += cpuidle-s3c64xx.o
+endif
 obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-s3c64xx.c b/drivers/cpuidle/cpuidle-s3c64xx.c
new file mode 100644
index 0000000..c18d075
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-s3c64xx.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2011 Wolfson Microelectronics, plc
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/cpuidle.h>
+#include <linux/io.h>
+#include <linux/export.h>
+#include <linux/time.h>
+
+#include <asm/proc-fns.h>
+
+#include <mach/map.h>
+
+#include "../../arch/arm/mach-s3c64xx/regs-sys.h"
+#include "../../arch/arm/mach-s3c64xx/regs-syscon-power.h"
+
+static int s3c64xx_enter_idle(struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv,
+			      int index)
+{
+	unsigned long tmp;
+
+	/* Setup PWRCFG to enter idle mode */
+	tmp = __raw_readl(S3C64XX_PWR_CFG);
+	tmp &= ~S3C64XX_PWRCFG_CFG_WFI_MASK;
+	tmp |= S3C64XX_PWRCFG_CFG_WFI_IDLE;
+	__raw_writel(tmp, S3C64XX_PWR_CFG);
+
+	cpu_do_idle();
+
+	return index;
+}
+
+static struct cpuidle_driver s3c64xx_cpuidle_driver = {
+	.name	= "s3c64xx_cpuidle",
+	.owner  = THIS_MODULE,
+	.states = {
+		{
+			.enter            = s3c64xx_enter_idle,
+			.exit_latency     = 1,
+			.target_residency = 1,
+			.flags            = CPUIDLE_FLAG_TIME_VALID,
+			.name             = "IDLE",
+			.desc             = "System active, ARM gated",
+		},
+	},
+	.state_count = 1,
+};
+
+static int __init s3c64xx_init_cpuidle(void)
+{
+	return cpuidle_register(&s3c64xx_cpuidle_driver, NULL);
+}
+device_initcall(s3c64xx_init_cpuidle);
-- 
1.8.2.3

