From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3/8] ARM: imx: move cpuidle drivers to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:15:42 +0200
Message-ID: <1372241747-21083-4-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15431 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3FZKQe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:16:34 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MOZ00I4MWJC8BZ0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 26 Jun 2013 19:16:33 +0900 (KST)
In-reply-to: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

While at it:
- remove needless "cpuidle.h" include from cpuidle-imx6q.c
- fix whitespace issue in cpuidle-imx6q.c

Compile tested only.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-imx/Makefile        |  5 ---
 arch/arm/mach-imx/cpuidle-imx5.c  | 37 -------------------
 arch/arm/mach-imx/cpuidle-imx6q.c | 75 ---------------------------------------
 drivers/cpuidle/Makefile          |  8 +++++
 drivers/cpuidle/cpuidle-imx5.c    | 37 +++++++++++++++++++
 drivers/cpuidle/cpuidle-imx6q.c   | 74 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 119 insertions(+), 117 deletions(-)
 delete mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
 delete mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c
 create mode 100644 drivers/cpuidle/cpuidle-imx5.c
 create mode 100644 drivers/cpuidle/cpuidle-imx6q.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index e20f22d..4affcbb 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -26,11 +26,6 @@ obj-$(CONFIG_MXC_AVIC) += avic.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
-obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
-endif
-
 ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cpuidle-imx5.c
deleted file mode 100644
index 5a47e3c..0000000
--- a/arch/arm/mach-imx/cpuidle-imx5.c
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (C) 2012 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/cpuidle.h>
-#include <linux/module.h>
-#include <asm/system_misc.h>
-
-static int imx5_cpuidle_enter(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv, int index)
-{
-	arm_pm_idle();
-	return index;
-}
-
-static struct cpuidle_driver imx5_cpuidle_driver = {
-	.name             = "imx5_cpuidle",
-	.owner            = THIS_MODULE,
-	.states[0] = {
-		.enter            = imx5_cpuidle_enter,
-		.exit_latency     = 2,
-		.target_residency = 1,
-		.flags            = CPUIDLE_FLAG_TIME_VALID,
-		.name             = "IMX5 SRPG",
-		.desc             = "CPU state retained,powered off",
-	},
-	.state_count = 1,
-};
-
-int __init imx5_cpuidle_init(void)
-{
-	return cpuidle_register(&imx5_cpuidle_driver, NULL);
-}
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
deleted file mode 100644
index 23ddfb6..0000000
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * Copyright (C) 2012 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/cpuidle.h>
-#include <linux/module.h>
-#include <asm/cpuidle.h>
-#include <asm/proc-fns.h>
-
-#include "common.h"
-#include "cpuidle.h"
-
-static atomic_t master = ATOMIC_INIT(0);
-static DEFINE_SPINLOCK(master_lock);
-
-static int imx6q_enter_wait(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv, int index)
-{
-	if (atomic_inc_return(&master) == num_online_cpus()) {
-		/*
-		 * With this lock, we prevent other cpu to exit and enter
-		 * this function again and become the master.
-		 */
-		if (!spin_trylock(&master_lock))
-			goto idle;
-		imx6q_set_lpm(WAIT_UNCLOCKED);
-		cpu_do_idle();
-		imx6q_set_lpm(WAIT_CLOCKED);
-		spin_unlock(&master_lock);
-		goto done;
-	}
-
-idle:
-	cpu_do_idle();
-done:
-	atomic_dec(&master);
-
-	return index;
-}
-
-static struct cpuidle_driver imx6q_cpuidle_driver = {
-	.name = "imx6q_cpuidle",
-	.owner = THIS_MODULE,
-	.states = {
-		/* WFI */
-		ARM_CPUIDLE_WFI_STATE,
-		/* WAIT */
-		{
-			.exit_latency = 50,
-			.target_residency = 75,
-			.flags = CPUIDLE_FLAG_TIME_VALID |
-			         CPUIDLE_FLAG_TIMER_STOP,
-			.enter = imx6q_enter_wait,
-			.name = "WAIT",
-			.desc = "Clock off",
-		},
-	},
-	.state_count = 2,
-	.safe_state_index = 0,
-};
-
-int __init imx6q_cpuidle_init(void)
-{
-	/* Need to enable SCU standby for entering WAIT modes */
-	imx_scu_standby_enable();
-
-	/* Set chicken bit to get a reliable WAIT mode support */
-	imx6q_set_chicken_bit();
-
-	return cpuidle_register(&imx6q_cpuidle_driver, NULL);
-}
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 3bbb828..9bacf85 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -13,4 +13,12 @@ ifeq ($(CONFIG_ARCH_DAVINCI),y)
 	obj-y += cpuidle-davinci.o
 endif
 obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
+ifeq ($(CONFIG_ARCH_MXC),y)
+	ifeq ($(CONFIG_SOC_IMX5),y)
+		obj-y += cpuidle-imx5.o
+	endif
+	ifeq ($(CONFIG_SOC_IMX6Q),y)
+		obj-y += cpuidle-imx6q.o
+	endif
+endif
 obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-imx5.c b/drivers/cpuidle/cpuidle-imx5.c
new file mode 100644
index 0000000..5a47e3c
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-imx5.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <asm/system_misc.h>
+
+static int imx5_cpuidle_enter(struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv, int index)
+{
+	arm_pm_idle();
+	return index;
+}
+
+static struct cpuidle_driver imx5_cpuidle_driver = {
+	.name             = "imx5_cpuidle",
+	.owner            = THIS_MODULE,
+	.states[0] = {
+		.enter            = imx5_cpuidle_enter,
+		.exit_latency     = 2,
+		.target_residency = 1,
+		.flags            = CPUIDLE_FLAG_TIME_VALID,
+		.name             = "IMX5 SRPG",
+		.desc             = "CPU state retained,powered off",
+	},
+	.state_count = 1,
+};
+
+int __init imx5_cpuidle_init(void)
+{
+	return cpuidle_register(&imx5_cpuidle_driver, NULL);
+}
diff --git a/drivers/cpuidle/cpuidle-imx6q.c b/drivers/cpuidle/cpuidle-imx6q.c
new file mode 100644
index 0000000..01b8622
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-imx6q.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+
+#include "../../arch/arm/mach-imx/common.h"
+
+static atomic_t master = ATOMIC_INIT(0);
+static DEFINE_SPINLOCK(master_lock);
+
+static int imx6q_enter_wait(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv, int index)
+{
+	if (atomic_inc_return(&master) == num_online_cpus()) {
+		/*
+		 * With this lock, we prevent other cpu to exit and enter
+		 * this function again and become the master.
+		 */
+		if (!spin_trylock(&master_lock))
+			goto idle;
+		imx6q_set_lpm(WAIT_UNCLOCKED);
+		cpu_do_idle();
+		imx6q_set_lpm(WAIT_CLOCKED);
+		spin_unlock(&master_lock);
+		goto done;
+	}
+
+idle:
+	cpu_do_idle();
+done:
+	atomic_dec(&master);
+
+	return index;
+}
+
+static struct cpuidle_driver imx6q_cpuidle_driver = {
+	.name = "imx6q_cpuidle",
+	.owner = THIS_MODULE,
+	.states = {
+		/* WFI */
+		ARM_CPUIDLE_WFI_STATE,
+		/* WAIT */
+		{
+			.exit_latency = 50,
+			.target_residency = 75,
+			.flags = CPUIDLE_FLAG_TIME_VALID |
+				 CPUIDLE_FLAG_TIMER_STOP,
+			.enter = imx6q_enter_wait,
+			.name = "WAIT",
+			.desc = "Clock off",
+		},
+	},
+	.state_count = 2,
+	.safe_state_index = 0,
+};
+
+int __init imx6q_cpuidle_init(void)
+{
+	/* Need to enable SCU standby for entering WAIT modes */
+	imx_scu_standby_enable();
+
+	/* Set chicken bit to get a reliable WAIT mode support */
+	imx6q_set_chicken_bit();
+
+	return cpuidle_register(&imx6q_cpuidle_driver, NULL);
+}
-- 
1.8.2.3

