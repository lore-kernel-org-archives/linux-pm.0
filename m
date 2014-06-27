From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 12/16] cpuidle: mvebu: Rename the driver from armada-370-xp to mvebu-v7
Date: Fri, 27 Jun 2014 15:22:53 +0200
Message-ID: <1403875377-940-13-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42131 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753419AbaF0NYD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:24:03 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Actually this driver will be able to manage the cpuidle for more SoCs
that Armada 370 ad XP. It will support Armada 38x and potentially
Armada 375. This patch change the names accordingly to this behavior.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c              |  2 +-
 drivers/cpuidle/Kconfig.arm             |  6 +--
 drivers/cpuidle/Makefile                |  2 +-
 drivers/cpuidle/cpuidle-armada-370-xp.c | 93 ---------------------------------
 drivers/cpuidle/cpuidle-mvebu-v7.c      | 93 +++++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 98 deletions(-)
 delete mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
 create mode 100644 drivers/cpuidle/cpuidle-mvebu-v7.c

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index a2869c5daeb0..00ebd5638633 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -82,7 +82,7 @@ static void __iomem *pmsu_mp_base;
 static void *mvebu_cpu_resume;
 
 static struct platform_device mvebu_v7_cpuidle_device = {
-	.name = "cpuidle-armada-370-xp",
+	.name = "cpuidle-mvebu-v7",
 };
 
 static struct of_device_id of_pmsu_table[] = {
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index b6d69e899f5d..e4fc2fc66e9f 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -1,11 +1,11 @@
 #
 # ARM CPU Idle drivers
 #
-config ARM_ARMADA_370_XP_CPUIDLE
-	bool "CPU Idle Driver for Armada 370/XP family processors"
+config ARM_MVEBU_V7_CPUIDLE
+	bool "CPU Idle Driver for mvebu v7 family processors"
 	depends on ARCH_MVEBU
 	help
-	  Select this to enable cpuidle on Armada 370/XP processors.
+	  Select this to enable cpuidle on Armada 370, 385 and XP processors.
 
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index d8bb1ff72561..11edb31c55e9 100644
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
diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-armada-370-xp.c
deleted file mode 100644
index a5fba0287bfb..000000000000
--- a/drivers/cpuidle/cpuidle-armada-370-xp.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * Marvell Armada 370 and Armada XP SoC cpuidle driver
- *
- * Copyright (C) 2014 Marvell
- *
- * Nadav Haklai <nadavh@marvell.com>
- * Gregory CLEMENT <gregory.clement@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- * Maintainer: Gregory CLEMENT <gregory.clement@free-electrons.com>
- */
-
-#include <linux/cpu_pm.h>
-#include <linux/cpuidle.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/suspend.h>
-#include <linux/platform_device.h>
-#include <asm/cpuidle.h>
-
-#define ARMADA_370_XP_MAX_STATES	3
-#define ARMADA_370_XP_FLAG_DEEP_IDLE	0x10000
-
-static int (*armada_370_xp_cpu_suspend)(int);
-
-static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
-{
-	int ret;
-	bool deepidle = false;
-	cpu_pm_enter();
-
-	if (drv->states[index].flags & ARMADA_370_XP_FLAG_DEEP_IDLE)
-		deepidle = true;
-
-	ret = armada_370_xp_cpu_suspend(deepidle);
-	if (ret)
-		return ret;
-
-	cpu_pm_exit();
-
-	return index;
-}
-
-static struct cpuidle_driver armada_370_xp_idle_driver = {
-	.name			= "armada_370_xp_idle",
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.states[1]		= {
-		.enter			= armada_370_xp_enter_idle,
-		.exit_latency		= 10,
-		.power_usage		= 50,
-		.target_residency	= 100,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "Idle",
-		.desc			= "CPU power down",
-	},
-	.states[2]		= {
-		.enter			= armada_370_xp_enter_idle,
-		.exit_latency		= 100,
-		.power_usage		= 5,
-		.target_residency	= 1000,
-		.flags			= CPUIDLE_FLAG_TIME_VALID |
-						ARMADA_370_XP_FLAG_DEEP_IDLE,
-		.name			= "Deep idle",
-		.desc			= "CPU and L2 Fabric power down",
-	},
-	.state_count = ARMADA_370_XP_MAX_STATES,
-};
-
-static int armada_370_xp_cpuidle_probe(struct platform_device *pdev)
-{
-
-	armada_370_xp_cpu_suspend = (void *)(pdev->dev.platform_data);
-	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
-}
-
-static struct platform_driver armada_370_xp_cpuidle_plat_driver = {
-	.driver = {
-		.name = "cpuidle-armada-370-xp",
-		.owner = THIS_MODULE,
-	},
-	.probe = armada_370_xp_cpuidle_probe,
-};
-
-module_platform_driver(armada_370_xp_cpuidle_plat_driver);
-
-MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
-MODULE_DESCRIPTION("Armada 370/XP cpu idle driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
new file mode 100644
index 000000000000..6066e0d9aabe
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -0,0 +1,93 @@
+/*
+ * Marvell Armada 370 and Armada XP SoC cpuidle driver
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Nadav Haklai <nadavh@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Maintainer: Gregory CLEMENT <gregory.clement@free-electrons.com>
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/suspend.h>
+#include <linux/platform_device.h>
+#include <asm/cpuidle.h>
+
+#define MVEBU_V7_MAX_STATES	3
+#define MVEBU_V7_FLAG_DEEP_IDLE	0x10000
+
+static int (*mvebu_v7_cpu_suspend)(int);
+
+static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	int ret;
+	bool deepidle = false;
+	cpu_pm_enter();
+
+	if (drv->states[index].flags & MVEBU_V7_FLAG_DEEP_IDLE)
+		deepidle = true;
+
+	ret = mvebu_v7_cpu_suspend(deepidle);
+	if (ret)
+		return ret;
+
+	cpu_pm_exit();
+
+	return index;
+}
+
+static struct cpuidle_driver mvebu_v7_idle_driver = {
+	.name			= "mvebu_v7_idle",
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= mvebu_v7_enter_idle,
+		.exit_latency		= 10,
+		.power_usage		= 50,
+		.target_residency	= 100,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "Idle",
+		.desc			= "CPU power down",
+	},
+	.states[2]		= {
+		.enter			= mvebu_v7_enter_idle,
+		.exit_latency		= 100,
+		.power_usage		= 5,
+		.target_residency	= 1000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID |
+						MVEBU_V7_FLAG_DEEP_IDLE,
+		.name			= "Deep idle",
+		.desc			= "CPU and L2 Fabric power down",
+	},
+	.state_count = MVEBU_V7_MAX_STATES,
+};
+
+static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
+{
+
+	mvebu_v7_cpu_suspend = (void *)(pdev->dev.platform_data);
+	return cpuidle_register(&mvebu_v7_idle_driver, NULL);
+}
+
+static struct platform_driver mvebu_v7_cpuidle_plat_driver = {
+	.driver = {
+		.name = "cpuidle-mvebu-v7",
+		.owner = THIS_MODULE,
+	},
+	.probe = mvebu_v7_cpuidle_probe,
+};
+
+module_platform_driver(mvebu_v7_cpuidle_plat_driver);
+
+MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
+MODULE_DESCRIPTION("Mvebu v7 cpu idle driver");
+MODULE_LICENSE("GPL");
-- 
1.8.1.2

