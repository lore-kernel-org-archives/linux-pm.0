From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 12/14] cpuidle: mvebu: Add initial CPU idle support for Armada 370/XP SoC
Date: Mon, 14 Oct 2013 15:58:24 +0200
Message-ID: <1381759106-15004-13-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60884 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756736Ab3JNN66 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 09:58:58 -0400
In-Reply-To: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

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
 drivers/cpuidle/cpuidle-armada-370-xp.c | 117 ++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e36603..071d960 100644
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
 
 config ARM_HIGHBANK_CPUIDLE
 	bool "CPU Idle Driver for Calxeda processors"
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index cea5ef5..395dab6 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_ARMADA_370_XP_CPUIDLE) += cpuidle-armada-370-xp.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-armada-370-xp.c
new file mode 100644
index 0000000..3fa005e
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-armada-370-xp.c
@@ -0,0 +1,117 @@
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
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/suspend.h>
+#include <asm/suspend.h>
+#include <linux/smp.h>
+#include <asm/cpuidle.h>
+#include <asm/smp_plat.h>
+#include <linux/armada-370-xp-pmsu.h>
+#include <linux/platform_device.h>
+
+#define ARMADA_370_XP_MAX_STATES	3
+#define ARMADA_370_XP_FLAG_DEEP_IDLE	0x10000
+
+extern void v7_flush_dcache_all(void);
+
+/* Functions defined in suspend-armada-370-xp.S */
+int armada_370_xp_cpu_resume(unsigned long);
+int armada_370_xp_cpu_suspend(unsigned long);
+
+static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	bool deepidle = false;
+	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
+
+	armada_370_xp_pmsu_set_start_addr(armada_370_xp_cpu_resume, hw_cpu);
+
+	if (drv->states[index].flags & ARMADA_370_XP_FLAG_DEEP_IDLE)
+		deepidle = true;
+
+	cpu_suspend(deepidle, armada_370_xp_cpu_suspend);
+
+	armada_370_xp_pmsu_idle_restore();
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
+	if (!of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu"))
+		return -ENODEV;
+
+	if (!of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
+		return -ENODEV;
+
+	pr_info("Initializing Armada-XP CPU power management ");
+
+	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
+
+	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
+}
+
+static int armada_370_xp_cpuidle_remove(struct platform_device *pdev)
+{
+	cpuidle_unregister(&armada_370_xp_idle_driver);
+	return 0;
+}
+
+
+static struct platform_driver armada_370_xp_cpuidle_plat_driver = {
+	.driver = {
+		.name = "cpuidle-armada-370-xp",
+		.owner = THIS_MODULE,
+	},
+	.probe = armada_370_xp_cpuidle_probe,
+	.remove = armada_370_xp_cpuidle_remove,
+};
+
+
+module_platform_driver(armada_370_xp_cpuidle_plat_driver);
+
+MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
+MODULE_DESCRIPTION("Armada 370/XP cpu idle driver");
+MODULE_LICENSE("GPL");
-- 
1.8.1.2

