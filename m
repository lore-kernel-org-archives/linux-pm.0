From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V3 patch 19/19] ARM: imx: cpuidle: use init/exit common routine
Date: Fri, 12 Apr 2013 14:36:05 +0200
Message-ID: <1365770165-27096-20-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:42013 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682Ab3DLMhL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 08:37:11 -0400
Received: by mail-we0-f172.google.com with SMTP id r3so1977924wey.31
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2013 05:37:10 -0700 (PDT)
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

The code intializes the cpuidle driver at different places.
The cpuidle driver for :
  * imx5 : is in the pm-imx5.c, the init function is in cpuidle.c
  * imx6 : is in cpuidle-imx6q.c, the init function is in cpuidle.c
           and cpuidle-imx6q.c

Instead of having the cpuidle code spread across different files,
let's create a driver for each SoC and use the common register function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-imx/Makefile        |    2 +-
 arch/arm/mach-imx/cpuidle-imx5.c  |   40 +++++++++++++++++++
 arch/arm/mach-imx/cpuidle-imx6q.c |    2 +-
 arch/arm/mach-imx/cpuidle.c       |   80 -------------------------------------
 arch/arm/mach-imx/cpuidle.h       |   10 ++---
 arch/arm/mach-imx/pm-imx5.c       |   29 +-------------
 6 files changed, 47 insertions(+), 116 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
 delete mode 100644 arch/arm/mach-imx/cpuidle.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index c4ce090..cb70961 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
 
 ifeq ($(CONFIG_CPU_IDLE),y)
-obj-y += cpuidle.o
+obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
 endif
 
diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cpuidle-imx5.c
new file mode 100644
index 0000000..ba4565f
--- /dev/null
+++ b/arch/arm/mach-imx/cpuidle-imx5.c
@@ -0,0 +1,40 @@
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
+#include <asm/proc-fns.h>
+
+#include "hardware.h"
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
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index e2739ad..23ddfb6 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -71,5 +71,5 @@ int __init imx6q_cpuidle_init(void)
 	/* Set chicken bit to get a reliable WAIT mode support */
 	imx6q_set_chicken_bit();
 
-	return imx_cpuidle_init(&imx6q_cpuidle_driver);
+	return cpuidle_register(&imx6q_cpuidle_driver, NULL);
 }
diff --git a/arch/arm/mach-imx/cpuidle.c b/arch/arm/mach-imx/cpuidle.c
deleted file mode 100644
index d4cb511..0000000
--- a/arch/arm/mach-imx/cpuidle.c
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#include <linux/cpuidle.h>
-#include <linux/err.h>
-#include <linux/hrtimer.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-
-static struct cpuidle_device __percpu * imx_cpuidle_devices;
-
-static void __init imx_cpuidle_devices_uninit(void)
-{
-	int cpu_id;
-	struct cpuidle_device *dev;
-
-	for_each_possible_cpu(cpu_id) {
-		dev = per_cpu_ptr(imx_cpuidle_devices, cpu_id);
-		cpuidle_unregister_device(dev);
-	}
-
-	free_percpu(imx_cpuidle_devices);
-}
-
-int __init imx_cpuidle_init(struct cpuidle_driver *drv)
-{
-	struct cpuidle_device *dev;
-	int cpu_id, ret;
-
-	if (drv->state_count > CPUIDLE_STATE_MAX) {
-		pr_err("%s: state_count exceeds maximum\n", __func__);
-		return -EINVAL;
-	}
-
-	ret = cpuidle_register_driver(drv);
-	if (ret) {
-		pr_err("%s: Failed to register cpuidle driver with error: %d\n",
-			 __func__, ret);
-		return ret;
-	}
-
-	imx_cpuidle_devices = alloc_percpu(struct cpuidle_device);
-	if (imx_cpuidle_devices == NULL) {
-		ret = -ENOMEM;
-		goto unregister_drv;
-	}
-
-	/* initialize state data for each cpuidle_device */
-	for_each_possible_cpu(cpu_id) {
-		dev = per_cpu_ptr(imx_cpuidle_devices, cpu_id);
-		dev->cpu = cpu_id;
-		dev->state_count = drv->state_count;
-
-		ret = cpuidle_register_device(dev);
-		if (ret) {
-			pr_err("%s: Failed to register cpu %u, error: %d\n",
-				__func__, cpu_id, ret);
-			goto uninit;
-		}
-	}
-
-	return 0;
-
-uninit:
-	imx_cpuidle_devices_uninit();
-
-unregister_drv:
-	cpuidle_unregister_driver(drv);
-	return ret;
-}
diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
index e092d13..786f98e 100644
--- a/arch/arm/mach-imx/cpuidle.h
+++ b/arch/arm/mach-imx/cpuidle.h
@@ -10,18 +10,16 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include <linux/cpuidle.h>
-
 #ifdef CONFIG_CPU_IDLE
-extern int imx_cpuidle_init(struct cpuidle_driver *drv);
+extern int imx5_cpuidle_init(void);
 extern int imx6q_cpuidle_init(void);
 #else
-static inline int imx_cpuidle_init(struct cpuidle_driver *drv)
+static inline int imx5_cpuidle_init(void)
 {
-	return -ENODEV;
+	return 0;
 }
 static inline int imx6q_cpuidle_init(void)
 {
-	return -ENODEV;
+	return 0;
 }
 #endif
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index 4b52b3e..82e79c6 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -149,32 +149,6 @@ static void imx5_pm_idle(void)
 	imx5_cpu_do_idle();
 }
 
-static int imx5_cpuidle_enter(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int idx)
-{
-	int ret;
-
-	ret = imx5_cpu_do_idle();
-	if (ret < 0)
-		return ret;
-
-	return idx;
-}
-
-static struct cpuidle_driver imx5_cpuidle_driver = {
-	.name			= "imx5_cpuidle",
-	.owner			= THIS_MODULE,
-	.states[0]	= {
-		.enter			= imx5_cpuidle_enter,
-		.exit_latency		= 2,
-		.target_residency	= 1,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "IMX5 SRPG",
-		.desc			= "CPU state retained,powered off",
-	},
-	.state_count		= 1,
-};
-
 static int __init imx5_pm_common_init(void)
 {
 	int ret;
@@ -192,8 +166,7 @@ static int __init imx5_pm_common_init(void)
 	/* Set the registers to the default cpu idle state. */
 	mx5_cpu_lp_set(IMX5_DEFAULT_CPU_IDLE_STATE);
 
-	imx_cpuidle_init(&imx5_cpuidle_driver);
-	return 0;
+	return imx5_cpuidle_init();
 }
 
 void __init imx51_pm_init(void)
-- 
1.7.9.5

