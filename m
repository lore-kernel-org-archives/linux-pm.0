From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 12/13] cpuidle: mvebu: Add initial CPU idle support for Armada 370/XP SoC
Date: Thu, 13 Feb 2014 18:33:35 +0100
Message-ID: <1392312816-17657-13-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51945 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752661AbaBMReL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2014 12:34:11 -0500
In-Reply-To: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Add the wfi, cpu idle and cpu deep idle power states support for the
Armada XP SoCs.

All the latencies and the power consumption values used at the
"armada_370_xp_idle_driver" structure are preliminary and will be
modified in the future after running some measurements and analysis.

Based on the work of Nadav Haklai.

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/cpuidle/Kconfig.arm             |   5 ++
 drivers/cpuidle/Makefile                |   1 +
 drivers/cpuidle/cpuidle-armada-370-xp.c | 120 ++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index d988948a89a0..f377eb0840e3 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -1,6 +1,11 @@
 #
 # ARM CPU Idle drivers
 #
+config ARM_ARMADA_370_XP_CPUIDLE
+	bool "CPU Idle Driver for Armada 370/XP family processors"
+	depends on ARCH_MVEBU
+	help
+	  Select this to enable cpuidle on Armada 370/XP processors.
 
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index f71ae1b373c5..9902d052bd87 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_ARMADA_370_XP_CPUIDLE) += cpuidle-armada-370-xp.o
 obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)	+= cpuidle-big_little.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-armada-370-xp.c
new file mode 100644
index 000000000000..57c69812e79d
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-armada-370-xp.c
@@ -0,0 +1,120 @@
+/*
+ * Marvell Armada 370 and Armada XP SoC cpuidle driver
+ *
+ * Copyright (C) 2013 Marvell
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
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/suspend.h>
+#include <asm/suspend.h>
+#include <linux/smp.h>
+#include <asm/cpuidle.h>
+#include <asm/smp_plat.h>
+#include <linux/platform_device.h>
+#include <asm/cp15.h>
+#include <asm/cacheflush.h>
+
+#define ARMADA_370_XP_MAX_STATES	3
+#define ARMADA_370_XP_FLAG_DEEP_IDLE	0x10000
+extern void armada_370_xp_pmsu_idle_prepare(bool deepidle);
+extern void ll_clear_cpu_coherent(void);
+extern void ll_set_cpu_coherent(void);
+
+noinline static int armada_370_xp_cpu_suspend(unsigned long deepidle)
+{
+	armada_370_xp_pmsu_idle_prepare(deepidle);
+
+	v7_exit_coherency_flush(all);
+
+	ll_clear_cpu_coherent();
+
+	dsb();
+
+	wfi();
+
+	ll_set_cpu_coherent();
+
+	asm volatile(
+	"mrc	p15, 0, %0, c1, c0, 0 \n\t"
+	"tst	%0, #(1 << 2) \n\t"
+	"orreq	r0, %0, #(1 << 2) \n\t"
+	"mcreq	p15, 0, %0, c1, c0, 0 \n\t"
+	"isb	"
+	: : "r" (0));
+
+	return 0;
+}
+
+static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	bool deepidle = false;
+	cpu_pm_enter();
+
+	if (drv->states[index].flags & ARMADA_370_XP_FLAG_DEEP_IDLE)
+		deepidle = true;
+
+	cpu_suspend(deepidle, armada_370_xp_cpu_suspend);
+
+	cpu_pm_exit();
+
+	return index;
+}
+
+static struct cpuidle_driver armada_370_xp_idle_driver = {
+	.name			= "armada_370_xp_idle",
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= armada_370_xp_enter_idle,
+		.exit_latency		= 10,
+		.power_usage		= 50,
+		.target_residency	= 100,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "MV CPU IDLE",
+		.desc			= "CPU power down",
+	},
+	.states[2]		= {
+		.enter			= armada_370_xp_enter_idle,
+		.exit_latency		= 100,
+		.power_usage		= 5,
+		.target_residency	= 1000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID |
+						ARMADA_370_XP_FLAG_DEEP_IDLE,
+		.name			= "MV CPU DEEP IDLE",
+		.desc			= "CPU and L2 Fabric power down",
+	},
+	.state_count = ARMADA_370_XP_MAX_STATES,
+};
+
+static int armada_370_xp_cpuidle_probe(struct platform_device *pdev)
+{
+	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
+}
+
+static struct platform_driver armada_370_xp_cpuidle_plat_driver = {
+	.driver = {
+		.name = "cpuidle-armada-370-xp",
+		.owner = THIS_MODULE,
+	},
+	.probe = armada_370_xp_cpuidle_probe,
+};
+
+module_platform_driver(armada_370_xp_cpuidle_plat_driver);
+
+MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
+MODULE_DESCRIPTION("Armada 370/XP cpu idle driver");
+MODULE_LICENSE("GPL");
-- 
1.8.1.2

