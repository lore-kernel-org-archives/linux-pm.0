From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V2 5/8] ARM64: cpuidle: Remove arm64 reference
Date: Wed, 18 Mar 2015 19:46:09 +0100
Message-ID: <1426704372-20406-6-git-send-email-daniel.lezcano@linaro.org>
References: <1426704372-20406-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:32859 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756269AbbCRSq2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 14:46:28 -0400
Received: by wgbcc7 with SMTP id cc7so42926430wgb.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2015 11:46:27 -0700 (PDT)
In-Reply-To: <1426704372-20406-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lorenzo.pieralisi@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin.Marinas@arm.com, robherring2@gmail.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lina.iyer@linaro.org

In the next patch, this driver will be common across ARM/ARM64. Remove all refs
to ARM64 as it will be shared with ARM32.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Kevin Hilman <khilman@linaro.org>
Acked-by: Rob Herring <robherring2@gmail.com>
---
 drivers/cpuidle/cpuidle-arm64.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
index 6ef291c7..1c94b88 100644
--- a/drivers/cpuidle/cpuidle-arm64.c
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -1,5 +1,5 @@
 /*
- * ARM64 generic CPU idle driver.
+ * ARM/ARM64 generic CPU idle driver.
  *
  * Copyright (C) 2014 ARM Ltd.
  * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
@@ -9,7 +9,7 @@
  * published by the Free Software Foundation.
  */
 
-#define pr_fmt(fmt) "CPUidle arm64: " fmt
+#define pr_fmt(fmt) "CPUidle arm: " fmt
 
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
@@ -23,7 +23,7 @@
 #include "dt_idle_states.h"
 
 /*
- * arm64_enter_idle_state - Programs CPU to enter the specified state
+ * arm_enter_idle_state - Programs CPU to enter the specified state
  *
  * dev: cpuidle device
  * drv: cpuidle driver
@@ -32,8 +32,8 @@
  * Called from the CPUidle framework to program the device to the
  * specified target state selected by the governor.
  */
-static int arm64_enter_idle_state(struct cpuidle_device *dev,
-				  struct cpuidle_driver *drv, int idx)
+static int arm_enter_idle_state(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int idx)
 {
 	int ret;
 
@@ -57,8 +57,8 @@ static int arm64_enter_idle_state(struct cpuidle_device *dev,
 	return ret ? -1 : idx;
 }
 
-static struct cpuidle_driver arm64_idle_driver = {
-	.name = "arm64_idle",
+static struct cpuidle_driver arm_idle_driver = {
+	.name = "arm_idle",
 	.owner = THIS_MODULE,
 	/*
 	 * State at index 0 is standby wfi and considered standard
@@ -68,32 +68,32 @@ static struct cpuidle_driver arm64_idle_driver = {
 	 * handler for idle state index 0.
 	 */
 	.states[0] = {
-		.enter                  = arm64_enter_idle_state,
+		.enter                  = arm_enter_idle_state,
 		.exit_latency           = 1,
 		.target_residency       = 1,
 		.power_usage		= UINT_MAX,
 		.name                   = "WFI",
-		.desc                   = "ARM64 WFI",
+		.desc                   = "ARM WFI",
 	}
 };
 
-static const struct of_device_id arm64_idle_state_match[] __initconst = {
+static const struct of_device_id arm_idle_state_match[] __initconst = {
 	{ .compatible = "arm,idle-state",
-	  .data = arm64_enter_idle_state },
+	  .data = arm_enter_idle_state },
 	{ },
 };
 
 /*
- * arm64_idle_init
+ * arm_idle_init
  *
- * Registers the arm64 specific cpuidle driver with the cpuidle
+ * Registers the arm specific cpuidle driver with the cpuidle
  * framework. It relies on core code to parse the idle states
  * and initialize them using driver data structures accordingly.
  */
-static int __init arm64_idle_init(void)
+static int __init arm_idle_init(void)
 {
 	int cpu, ret;
-	struct cpuidle_driver *drv = &arm64_idle_driver;
+	struct cpuidle_driver *drv = &arm_idle_driver;
 
 	/*
 	 * Initialize idle states data, starting at index 1.
@@ -101,7 +101,7 @@ static int __init arm64_idle_init(void)
 	 * let the driver initialization fail accordingly since there is no
 	 * reason to initialize the idle driver if only wfi is supported.
 	 */
-	ret = dt_init_idle_driver(drv, arm64_idle_state_match, 1);
+	ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
 	if (ret <= 0)
 		return ret ? : -ENODEV;
 
@@ -119,4 +119,4 @@ static int __init arm64_idle_init(void)
 
 	return cpuidle_register(drv, NULL);
 }
-device_initcall(arm64_idle_init);
+device_initcall(arm_idle_init);
-- 
1.9.1

