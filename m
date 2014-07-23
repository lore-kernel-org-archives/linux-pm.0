From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 11/16] cpuidle: mvebu: rename the driver from armada-370-xp to mvebu-v7
Date: Wed, 23 Jul 2014 15:00:48 +0200
Message-ID: <1406120453-29291-12-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40731 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754536AbaGWNBI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 09:01:08 -0400
In-Reply-To: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

This driver will be able to manage the cpuidle for more SoCs than just
Armada 370 and XP. It will also support Armada 38x and potentially
other SoC of the Marvell Armada EBU family. To take this into account,
this patch renames the driver and its symbols.

It also changes the driver name from cpuidle-armada-370-xp to
cpuidle-armada-xp, because separate platform drivers will be
registered for the other SoC types. This change must be done
simultaneously in the cpuidle driver and in the PMSU code in order to
remain bisectable.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c                         |  2 +-
 drivers/cpuidle/Kconfig.arm                        | 12 +++----
 drivers/cpuidle/Makefile                           |  2 +-
 ...{cpuidle-armada-370-xp.c => cpuidle-mvebu-v7.c} | 39 +++++++++++-----------
 4 files changed, 27 insertions(+), 28 deletions(-)
 rename drivers/cpuidle/{cpuidle-armada-370-xp.c => cpuidle-mvebu-v7.c} (58%)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 15e67bf..0cd2d09 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -76,7 +76,7 @@ extern void armada_370_xp_cpu_resume(void);
 static void *mvebu_cpu_resume;
 
 static struct platform_device mvebu_v7_cpuidle_device = {
-	.name = "cpuidle-armada-370-xp",
+	.name = "cpuidle-armada-xp",
 };
 
 static struct of_device_id of_pmsu_table[] = {
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index b6d69e8..a563427 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -1,12 +1,6 @@
 #
 # ARM CPU Idle drivers
 #
-config ARM_ARMADA_370_XP_CPUIDLE
-	bool "CPU Idle Driver for Armada 370/XP family processors"
-	depends on ARCH_MVEBU
-	help
-	  Select this to enable cpuidle on Armada 370/XP processors.
-
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
 	depends on ARCH_VEXPRESS_TC2_PM
@@ -61,3 +55,9 @@ config ARM_EXYNOS_CPUIDLE
 	depends on ARCH_EXYNOS
 	help
 	  Select this to enable cpuidle for Exynos processors
+
+config ARM_MVEBU_V7_CPUIDLE
+	bool "CPU Idle Driver for mvebu v7 family processors"
+	depends on ARCH_MVEBU
+	help
+	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index d8bb1ff..11edb31 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
 ##################################################################################
 # ARM SoC drivers
-obj-$(CONFIG_ARM_ARMADA_370_XP_CPUIDLE) += cpuidle-armada-370-xp.o
+obj-$(CONFIG_ARM_MVEBU_V7_CPUIDLE) += cpuidle-mvebu-v7.o
 obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)	+= cpuidle-big_little.o
 obj-$(CONFIG_ARM_CLPS711X_CPUIDLE)	+= cpuidle-clps711x.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
similarity index 58%
rename from drivers/cpuidle/cpuidle-armada-370-xp.c
rename to drivers/cpuidle/cpuidle-mvebu-v7.c
index 28587d0..7252fd8 100644
--- a/drivers/cpuidle/cpuidle-armada-370-xp.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -21,12 +21,11 @@
 #include <linux/platform_device.h>
 #include <asm/cpuidle.h>
 
-#define ARMADA_370_XP_MAX_STATES	3
-#define ARMADA_370_XP_FLAG_DEEP_IDLE	0x10000
+#define MVEBU_V7_FLAG_DEEP_IDLE	0x10000
 
-static int (*armada_370_xp_cpu_suspend)(int);
+static int (*mvebu_v7_cpu_suspend)(int);
 
-static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
+static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
@@ -34,10 +33,10 @@ static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
 	bool deepidle = false;
 	cpu_pm_enter();
 
-	if (drv->states[index].flags & ARMADA_370_XP_FLAG_DEEP_IDLE)
+	if (drv->states[index].flags & MVEBU_V7_FLAG_DEEP_IDLE)
 		deepidle = true;
 
-	ret = armada_370_xp_cpu_suspend(deepidle);
+	ret = mvebu_v7_cpu_suspend(deepidle);
 	if (ret)
 		return ret;
 
@@ -46,11 +45,11 @@ static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
 	return index;
 }
 
-static struct cpuidle_driver armada_370_xp_idle_driver = {
-	.name			= "armada_370_xp_idle",
+static struct cpuidle_driver armadaxp_idle_driver = {
+	.name			= "armada_xp_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
-		.enter			= armada_370_xp_enter_idle,
+		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 10,
 		.power_usage		= 50,
 		.target_residency	= 100,
@@ -59,35 +58,35 @@ static struct cpuidle_driver armada_370_xp_idle_driver = {
 		.desc			= "CPU power down",
 	},
 	.states[2]		= {
-		.enter			= armada_370_xp_enter_idle,
+		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 100,
 		.power_usage		= 5,
 		.target_residency	= 1000,
 		.flags			= CPUIDLE_FLAG_TIME_VALID |
-						ARMADA_370_XP_FLAG_DEEP_IDLE,
+						MVEBU_V7_FLAG_DEEP_IDLE,
 		.name			= "MV CPU DEEP IDLE",
 		.desc			= "CPU and L2 Fabric power down",
 	},
-	.state_count = ARMADA_370_XP_MAX_STATES,
+	.state_count = 3,
 };
 
-static int armada_370_xp_cpuidle_probe(struct platform_device *pdev)
+static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 {
 
-	armada_370_xp_cpu_suspend = (void *)(pdev->dev.platform_data);
-	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
+	mvebu_v7_cpu_suspend = pdev->dev.platform_data;
+	return cpuidle_register(&armadaxp_idle_driver, NULL);
 }
 
-static struct platform_driver armada_370_xp_cpuidle_plat_driver = {
+static struct platform_driver armadaxp_cpuidle_plat_driver = {
 	.driver = {
-		.name = "cpuidle-armada-370-xp",
+		.name = "cpuidle-armada-xp",
 		.owner = THIS_MODULE,
 	},
-	.probe = armada_370_xp_cpuidle_probe,
+	.probe = mvebu_v7_cpuidle_probe,
 };
 
-module_platform_driver(armada_370_xp_cpuidle_plat_driver);
+module_platform_driver(armadaxp_cpuidle_plat_driver);
 
 MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
-MODULE_DESCRIPTION("Armada 370/XP cpu idle driver");
+MODULE_DESCRIPTION("Marvell EBU v7 cpuidle driver");
 MODULE_LICENSE("GPL");
-- 
2.0.0

