From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 08/11] cpuidle / imx : use common ARM cpuidle driver
Date: Fri, 15 Mar 2013 15:27:07 +0100
Message-ID: <1363357630-22214-9-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:50100 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901Ab3COO1f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:35 -0400
Received: by mail-wg0-f52.google.com with SMTP id 15so2143398wgd.7
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:34 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-imx/Makefile        |    1 -
 arch/arm/mach-imx/cpuidle-imx6q.c |   18 +--------
 arch/arm/mach-imx/cpuidle.c       |   80 -------------------------------------
 arch/arm/mach-imx/cpuidle.h       |    6 +--
 arch/arm/mach-imx/pm-imx5.c       |    3 +-
 5 files changed, 4 insertions(+), 104 deletions(-)
 delete mode 100644 arch/arm/mach-imx/cpuidle.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index c4ce090..9933955 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -30,7 +30,6 @@ obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
 
 ifeq ($(CONFIG_CPU_IDLE),y)
-obj-y += cpuidle.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
 endif
 
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index d533e26..f2d71f8 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -48,17 +48,6 @@ done:
 	return index;
 }
 
-/*
- * For each cpu, setup the broadcast timer because local timer
- * stops for the states other than WFI.
- */
-static void imx6q_setup_broadcast_timer(void *arg)
-{
-	int cpu = smp_processor_id();
-
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
-}
-
 static struct cpuidle_driver imx6q_cpuidle_driver = {
 	.name = "imx6q_cpuidle",
 	.owner = THIS_MODULE,
@@ -70,7 +59,7 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
 		{
 			.exit_latency = 50,
 			.target_residency = 75,
-			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TIMER_STOP,
 			.enter = imx6q_enter_wait,
 			.name = "WAIT",
 			.desc = "Clock off",
@@ -88,8 +77,5 @@ int __init imx6q_cpuidle_init(void)
 	/* Set chicken bit to get a reliable WAIT mode support */
 	imx6q_set_chicken_bit();
 
-	/* Configure the broadcast timer on each cpu */
-	on_each_cpu(imx6q_setup_broadcast_timer, NULL, 1);
-
-	return imx_cpuidle_init(&imx6q_cpuidle_driver);
+	return arm_idle_init(&imx6q_cpuidle_driver);
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
index e092d13..a15248c 100644
--- a/arch/arm/mach-imx/cpuidle.h
+++ b/arch/arm/mach-imx/cpuidle.h
@@ -11,15 +11,11 @@
  */
 
 #include <linux/cpuidle.h>
+#include <asm/cpuidle.h>
 
 #ifdef CONFIG_CPU_IDLE
-extern int imx_cpuidle_init(struct cpuidle_driver *drv);
 extern int imx6q_cpuidle_init(void);
 #else
-static inline int imx_cpuidle_init(struct cpuidle_driver *drv)
-{
-	return -ENODEV;
-}
 static inline int imx6q_cpuidle_init(void)
 {
 	return -ENODEV;
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index f67fd7e..b2d231c 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -193,8 +193,7 @@ static int __init imx5_pm_common_init(void)
 	/* Set the registers to the default cpu idle state. */
 	mx5_cpu_lp_set(IMX5_DEFAULT_CPU_IDLE_STATE);
 
-	imx_cpuidle_init(&imx5_cpuidle_driver);
-	return 0;
+	return arm_idle_init(&imx5_cpuidle_driver);
 }
 
 void __init imx51_pm_init(void)
-- 
1.7.9.5

