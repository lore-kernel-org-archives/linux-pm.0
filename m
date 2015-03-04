From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH 1/6] cpuidle: renesas: Add CPUIdle Driver for Renesas SoCs
Date: Wed, 4 Mar 2015 13:55:41 +0900
Message-ID: <1425444946-3084-2-git-send-email-keita.kobayashi.ym@renesas.com>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:24158 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752665AbbCDE4B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 23:56:01 -0500
In-Reply-To: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>

This patch adds a cpuidle driver for Renesas SoCs.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 drivers/cpuidle/Kconfig.arm                   |   8 ++
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-renesas.c             | 118 ++++++++++++++++++++++++++
 include/linux/platform_data/renesas-cpuidle.h |  24 ++++++
 4 files changed, 151 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-renesas.c
 create mode 100644 include/linux/platform_data/renesas-cpuidle.h

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e07c94..01cb8cc 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -64,3 +64,11 @@ config ARM_MVEBU_V7_CPUIDLE
 	depends on ARCH_MVEBU
 	help
 	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
+
+config ARM_RENESAS_CPUIDLE
+	bool "CPU Idle Driver for the renesas SoCs"
+	depends on ARCH_SHMOBILE_MULTI
+	select ARM_CPU_SUSPEND
+	select CPU_IDLE_MULTIPLE_DRIVERS
+	help
+	  Select this to enable cpuidle for renesas SoCs
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 4d177b9..c718906 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
+obj-$(CONFIG_ARM_RENESAS_CPUIDLE)	+= cpuidle-renesas.o
 
 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-renesas.c b/drivers/cpuidle/cpuidle-renesas.c
new file mode 100644
index 0000000..b469e95
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-renesas.c
@@ -0,0 +1,118 @@
+/*
+ * CPUIdle support code for Renesas ARM
+ *
+ *  Copyright (C) 2014 Renesas Electronics Corporation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/platform_data/renesas-cpuidle.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/suspend.h>
+#include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+#include <asm/smp_plat.h>
+
+static struct cpuidle_driver renesas_cpuidle_default_driver = {
+	.name			= "renesas_default_cpuidle",
+	.owner			= THIS_MODULE,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.safe_state_index	= 0, /* C1 */
+	.state_count		= 1,
+};
+
+static struct renesas_cpuidle_driver default_driver = {
+	.target_cpu	= -1, /* default */
+	.renesas_drv	= &renesas_cpuidle_default_driver,
+};
+
+static struct renesas_cpuidle cpuidle_data = {
+	.num_drvs	= 1,
+	.rcd		= &default_driver,
+};
+
+static int __init renesas_idle_driver_init(struct device *dev,
+				struct renesas_cpuidle_driver *rcd)
+{
+	struct cpumask *cpumask = NULL;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (smp_cpuid_part(cpu) == rcd->target_cpu ||
+		    rcd->target_cpu == -1) { /* default */
+			if (!cpumask) {
+				cpumask = devm_kzalloc(dev,
+					  cpumask_size(), GFP_KERNEL);
+				if (!cpumask)
+					return -ENOMEM;
+			}
+			cpumask_set_cpu(cpu, cpumask);
+			rcd->renesas_drv->cpumask = cpumask;
+		}
+	}
+
+	return 0;
+}
+
+static int renesas_cpuidle_probe(struct platform_device *pdev)
+{
+	struct renesas_cpuidle *pd = pdev->dev.platform_data;
+	struct renesas_cpuidle_driver *rcd;
+	int i, j, ret;
+
+	if (!pd->num_drvs || !pd->rcd)
+		pd = &cpuidle_data;
+
+	for (i = 0; i < pd->num_drvs; i++) {
+		rcd = pd->rcd + i;
+		ret = renesas_idle_driver_init(&pdev->dev, rcd);
+		if (ret)
+			goto out_uninit_driver;
+
+		if (!rcd->renesas_drv->cpumask)
+			continue;
+
+		ret = cpuidle_register(rcd->renesas_drv, NULL);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to register cpuidle driver\n");
+			goto out_uninit_driver;
+		}
+	}
+
+	return 0;
+
+out_uninit_driver:
+	for (j = 0; j < i; j++) {
+		rcd = pd->rcd + j;
+
+		if (!rcd->renesas_drv->cpumask)
+			continue;
+
+		cpuidle_unregister(rcd->renesas_drv);
+	}
+
+	return ret;
+}
+
+static struct platform_driver renesas_cpuidle_driver = {
+	.probe	= renesas_cpuidle_probe,
+	.driver	= {
+		.name = "cpuidle-renesas",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(renesas_cpuidle_driver);
+
+MODULE_DESCRIPTION("Renesas cpuidle driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/platform_data/renesas-cpuidle.h b/include/linux/platform_data/renesas-cpuidle.h
new file mode 100644
index 0000000..9446215
--- /dev/null
+++ b/include/linux/platform_data/renesas-cpuidle.h
@@ -0,0 +1,24 @@
+/*
+ * renesas-cpuidle.h -- CPUIdle support code for Renesas ARM
+ *
+ *  Copyright (C) 2014 Renesas Electronics Corporation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __RENESAS_CPUIDLE_H__
+#define __RENESAS_CPUIDLE_H__
+
+struct renesas_cpuidle_driver {
+	unsigned int		target_cpu;
+	struct cpuidle_driver	*renesas_drv;
+};
+
+struct renesas_cpuidle {
+	unsigned int		num_drvs;
+	struct renesas_cpuidle_driver *rcd;
+};
+
+#endif /* __RENESAS_CPUIDLE_H__ */
-- 
1.9.1

