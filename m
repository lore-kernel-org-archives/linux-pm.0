From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 13/16] cpuidle: mvebu: Move the description of the cpuidle states in the platform part
Date: Fri, 27 Jun 2014 15:22:54 +0200
Message-ID: <1403875377-940-14-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42123 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753239AbaF0NYE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:24:04 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

In order to prepare the add of new SoCs supports for this cpuidle
driver, this patch moves the description of the state in the platform
part. Indeed the number of the cpuidle state, and the value of the
flag used will vary depending of the SoC.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c         | 32 +++++++++++++++++++++++--
 drivers/cpuidle/cpuidle-mvebu-v7.c | 49 +++++++++++++-------------------------
 include/linux/mvebu-v7-cpuidle.h   | 24 +++++++++++++++++++
 3 files changed, 70 insertions(+), 35 deletions(-)
 create mode 100644 include/linux/mvebu-v7-cpuidle.h

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 00ebd5638633..9396839e162e 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -19,15 +19,18 @@
 #define pr_fmt(fmt) "mvebu-pmsu: " fmt
 
 #include <linux/cpu_pm.h>
+#include <linux/cpuidle.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/mbus.h>
+#include <linux/mvebu-v7-cpuidle.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
 #include <linux/smp.h>
 #include <asm/cacheflush.h>
+#include <asm/cpuidle.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
@@ -299,17 +302,42 @@ static struct notifier_block mvebu_v7_cpu_pm_notifier = {
 
 static bool (*mvebu_v7_cpu_idle_init)(void);
 
+static struct mvebu_v7_cpuidle armada_xp_cpuidle = {
+	.mvebu_v7_idle_driver = {
+		.name			= "armada_xp_idle",
+		.states[0]		= ARM_CPUIDLE_WFI_STATE,
+		.states[1]		= {
+			.exit_latency		= 10,
+			.power_usage		= 50,
+			.target_residency	= 100,
+			.flags			= CPUIDLE_FLAG_TIME_VALID,
+			.name			= "Idle",
+			.desc			= "CPU power down",
+		},
+		.states[2]		= {
+			.exit_latency		= 100,
+			.power_usage		= 5,
+			.target_residency	= 1000,
+			.flags			= CPUIDLE_FLAG_TIME_VALID |
+			MVEBU_V7_FLAG_DEEP_IDLE,
+			.name			= "Deep idle",
+			.desc			= "CPU and L2 Fabric power down",
+		},
+		.state_count = 3,
+	},
+	.mvebu_v7_cpu_suspend = armada_xp_370_cpu_suspend,
+};
+
 static __init bool armada_xp_cpuidle_init(void)
 {
 	struct device_node *np;
-
 	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
 	if (!np)
 		return false;
 	of_node_put(np);
 
 	mvebu_cpu_resume = armada_370_xp_cpu_resume;
-	mvebu_v7_cpuidle_device.dev.platform_data = armada_xp_370_cpu_suspend;
+	mvebu_v7_cpuidle_device.dev.platform_data = &armada_xp_cpuidle;
 	return true;
 }
 
diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 6066e0d9aabe..2fdc18797c0e 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -16,15 +16,12 @@
 #include <linux/cpu_pm.h>
 #include <linux/cpuidle.h>
 #include <linux/module.h>
+#include <linux/mvebu-v7-cpuidle.h>
 #include <linux/of.h>
 #include <linux/suspend.h>
 #include <linux/platform_device.h>
-#include <asm/cpuidle.h>
 
-#define MVEBU_V7_MAX_STATES	3
-#define MVEBU_V7_FLAG_DEEP_IDLE	0x10000
-
-static int (*mvebu_v7_cpu_suspend)(int);
+static struct mvebu_v7_cpuidle *pcpuidle;
 
 static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
@@ -32,12 +29,13 @@ static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
 {
 	int ret;
 	bool deepidle = false;
+
 	cpu_pm_enter();
 
 	if (drv->states[index].flags & MVEBU_V7_FLAG_DEEP_IDLE)
 		deepidle = true;
 
-	ret = mvebu_v7_cpu_suspend(deepidle);
+	ret = pcpuidle->mvebu_v7_cpu_suspend(deepidle);
 	if (ret)
 		return ret;
 
@@ -46,36 +44,21 @@ static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
 	return index;
 }
 
-static struct cpuidle_driver mvebu_v7_idle_driver = {
-	.name			= "mvebu_v7_idle",
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.states[1]		= {
-		.enter			= mvebu_v7_enter_idle,
-		.exit_latency		= 10,
-		.power_usage		= 50,
-		.target_residency	= 100,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "Idle",
-		.desc			= "CPU power down",
-	},
-	.states[2]		= {
-		.enter			= mvebu_v7_enter_idle,
-		.exit_latency		= 100,
-		.power_usage		= 5,
-		.target_residency	= 1000,
-		.flags			= CPUIDLE_FLAG_TIME_VALID |
-						MVEBU_V7_FLAG_DEEP_IDLE,
-		.name			= "Deep idle",
-		.desc			= "CPU and L2 Fabric power down",
-	},
-	.state_count = MVEBU_V7_MAX_STATES,
-};
-
 static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 {
+	int i;
+
+	pcpuidle = (void *)(pdev->dev.platform_data);
+
+	/*
+	 * The first state is the ARM WFI state, so we don't have to
+	 * provide an enter function
+	 */
+	for (i = 1; i < pcpuidle->mvebu_v7_idle_driver.state_count; i++)
+		pcpuidle->mvebu_v7_idle_driver.states[i].enter =
+			mvebu_v7_enter_idle;
 
-	mvebu_v7_cpu_suspend = (void *)(pdev->dev.platform_data);
-	return cpuidle_register(&mvebu_v7_idle_driver, NULL);
+	return cpuidle_register(&pcpuidle->mvebu_v7_idle_driver, NULL);
 }
 
 static struct platform_driver mvebu_v7_cpuidle_plat_driver = {
diff --git a/include/linux/mvebu-v7-cpuidle.h b/include/linux/mvebu-v7-cpuidle.h
new file mode 100644
index 000000000000..28c8674292ad
--- /dev/null
+++ b/include/linux/mvebu-v7-cpuidle.h
@@ -0,0 +1,24 @@
+/*
+ * Marvell EBU cpuidle defintion
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ */
+
+#ifndef __LINUX_MVEBU_V7_CPUIDLE_H__
+#define __LINUX_MVEBU_V7_CPUIDLE_H__
+
+#define MVEBU_V7_FLAG_DEEP_IDLE	0x10000
+
+struct mvebu_v7_cpuidle {
+	struct cpuidle_driver mvebu_v7_idle_driver;
+	int (*mvebu_v7_cpu_suspend)(unsigned long);
+};
+
+#endif
-- 
1.8.1.2

