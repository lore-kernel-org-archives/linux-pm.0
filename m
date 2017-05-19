From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] ARM: cpuidle: Support asymmetric idle definition
Date: Fri, 19 May 2017 18:45:43 +0200
Message-ID: <1495212343-24873-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34198 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbdESQrA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2017 12:47:00 -0400
Received: by mail-wr0-f174.google.com with SMTP id l9so20334162wre.1
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2017 09:46:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lorenzo.pieralisi@arm.com
Cc: leo.yan@linaro.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Some hardware have clusters with different idle states. The current code does
not support this and fails as it expects all the idle states to be identical.

Because of this, the Mediatek mtk8173 had to create the same idle state for a
big.Little system and now the Hisilicon 960 is facing the same situation.

Solve this by simply assuming the multiple driver will be needed for all the
platforms using the ARM generic cpuidle driver which makes sense because of the
different topologies we can support with a single kernel for ARM32 or ARM64.

Tested on:
 - 96boards: Hikey 620
 - 96boards: Hikey 960
 - 96boards: dragonboard410c
 - Mediatek 8173

Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig.arm   |  1 +
 drivers/cpuidle/cpuidle-arm.c | 55 +++++++++++++++++++++++++++++--------------
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 21340e0..f521448 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -4,6 +4,7 @@
 config ARM_CPUIDLE
         bool "Generic ARM/ARM64 CPU idle Driver"
         select DT_IDLE_STATES
+	select CPU_IDLE_MULTIPLE_DRIVERS
         help
           Select this to enable generic cpuidle driver for ARM.
           It provides a generic idle driver whose idle states are configured
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index f440d38..bec31d5 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/topology.h>
 
 #include <asm/cpuidle.h>
 
@@ -44,7 +45,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, idx);
 }
 
-static struct cpuidle_driver arm_idle_driver = {
+static struct cpuidle_driver arm_idle_driver __initdata = {
 	.name = "arm_idle",
 	.owner = THIS_MODULE,
 	/*
@@ -80,23 +81,40 @@ static const struct of_device_id arm_idle_state_match[] __initconst = {
 static int __init arm_idle_init(void)
 {
 	int cpu, ret;
-	struct cpuidle_driver *drv = &arm_idle_driver;
+	struct cpuidle_driver *drv = NULL;
 	struct cpuidle_device *dev;
 
-	/*
-	 * Initialize idle states data, starting at index 1.
-	 * This driver is DT only, if no DT idle states are detected (ret == 0)
-	 * let the driver initialization fail accordingly since there is no
-	 * reason to initialize the idle driver if only wfi is supported.
-	 */
-	ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
-	if (ret <= 0)
-		return ret ? : -ENODEV;
-
-	ret = cpuidle_register_driver(drv);
-	if (ret) {
-		pr_err("Failed to register cpuidle driver\n");
-		return ret;
+	for_each_possible_cpu(cpu) {
+
+		if (drv && cpumask_test_cpu(cpu, drv->cpumask))
+			continue;
+
+		ret = -ENOMEM;
+
+		drv = kmemdup(&arm_idle_driver, sizeof(*drv), GFP_KERNEL);
+		if (!drv)
+			goto out_fail;
+
+		drv->cpumask = &cpu_topology[cpu].core_sibling;
+
+		/*
+		 * Initialize idle states data, starting at index 1.  This
+		 * driver is DT only, if no DT idle states are detected (ret
+		 * == 0) let the driver initialization fail accordingly since
+		 * there is no reason to initialize the idle driver if only
+		 * wfi is supported.
+		 */
+		ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
+		if (ret <= 0) {
+			ret = ret ? : -ENODEV;
+			goto out_fail;
+		}
+
+		ret = cpuidle_register_driver(drv);
+		if (ret) {
+			pr_err("Failed to register cpuidle driver\n");
+			goto out_fail;
+		}
 	}
 
 	/*
@@ -141,10 +159,11 @@ static int __init arm_idle_init(void)
 		dev = per_cpu(cpuidle_devices, cpu);
 		cpuidle_unregister_device(dev);
 		kfree(dev);
+		drv = cpuidle_get_driver();
+		cpuidle_unregister_driver(drv);
+		kfree(drv);
 	}
 
-	cpuidle_unregister_driver(drv);
-
 	return ret;
 }
 device_initcall(arm_idle_init);
-- 
2.7.4
