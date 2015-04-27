From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 4/4] cpufreq: arm_big_little: add SCPI interface driver
Date: Mon, 27 Apr 2015 12:40:46 +0100
Message-ID: <1430134846-24320-5-git-send-email-sudeep.holla@arm.com>
References: <1430134846-24320-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430134846-24320-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On some ARM based systems, a separate Cortex-M based System Control
Processor(SCP) provides the overall power, clock, reset and system
control including CPU DVFS. SCPI Message Protocol is used to
communicate with the SCPI.

This patch adds a interface driver for adding OPPs and registering
the arm_big_little cpufreq driver for such systems.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/Kconfig.arm    |   9 ++++
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/scpi-cpufreq.c | 103 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/cpufreq/scpi-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4f3dbc8cf729..9e678bf1687c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -24,6 +24,15 @@ config ARM_VEXPRESS_SPC_CPUFREQ
           This add the CPUfreq driver support for Versatile Express
 	  big.LITTLE platforms using SPC for power management.
 
+config ARM_SCPI_CPUFREQ
+        tristate "SCPI based CPUfreq driver"
+	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL
+        help
+          This add the CPUfreq driver support for ARM big.LITTLE platforms
+	  using SCPI interface for CPU power management.
+
+	  This driver works only if firmware the supporting CPU DVFS adhere
+	  to SCPI protocol.
 
 config ARM_EXYNOS_CPUFREQ
 	tristate "SAMSUNG EXYNOS CPUfreq Driver"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index cdce92ae2e8b..02fc9f849d4b 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
+obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
 
 ##################################################################################
 # PowerPC platform drivers
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
new file mode 100644
index 000000000000..4c2c11a9dfc6
--- /dev/null
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -0,0 +1,103 @@
+/*
+ * SCPI CPUFreq Interface driver
+ *
+ * It provides necessary ops to arm_big_little cpufreq driver.
+ *
+ * Copyright (C) 2015 ARM Ltd.
+ * Sudeep Holla <sudeep.holla@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/scpi_protocol.h>
+#include <linux/types.h>
+
+#include "arm_big_little.h"
+
+static struct scpi_ops *scpi_ops;
+
+static int scpi_init_opp_table(struct device *cpu_dev)
+{
+	u8 domain = topology_physical_package_id(cpu_dev->id);
+	struct scpi_dvfs_info *info;
+	struct scpi_opp *opp;
+	int idx, ret = 0;
+
+	if ((dev_pm_opp_get_opp_count(cpu_dev)) > 0)
+		return 0;
+	info = scpi_ops->dvfs_get_info(domain);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	opp = info->opps;
+	if (!opp)
+		return -EIO;
+
+	for (idx = 0; idx < info->count; idx++, opp++) {
+		ret = dev_pm_opp_add(cpu_dev, opp->freq, opp->m_volt * 1000);
+		if (ret) {
+			dev_warn(cpu_dev, "failed to add opp %uHz %umV\n",
+				 opp->freq, opp->m_volt);
+			return ret;
+		}
+	}
+	return ret;
+}
+
+static int scpi_get_transition_latency(struct device *cpu_dev)
+{
+	u8 domain = topology_physical_package_id(cpu_dev->id);
+	struct scpi_dvfs_info *info;
+
+	info = scpi_ops->dvfs_get_info(domain);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	return info->latency;
+}
+
+static struct cpufreq_arm_bL_ops scpi_cpufreq_ops = {
+	.name	= "scpi",
+	.get_transition_latency = scpi_get_transition_latency,
+	.init_opp_table = scpi_init_opp_table,
+};
+
+static int scpi_cpufreq_probe(struct platform_device *pdev)
+{
+	scpi_ops = get_scpi_ops();
+	if (!scpi_ops)
+		return -EIO;
+
+	return bL_cpufreq_register(&scpi_cpufreq_ops);
+}
+
+static int scpi_cpufreq_remove(struct platform_device *pdev)
+{
+	bL_cpufreq_unregister(&scpi_cpufreq_ops);
+	return 0;
+}
+
+static struct platform_driver scpi_cpufreq_platdrv = {
+	.driver = {
+		.name	= "scpi-cpufreq",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= scpi_cpufreq_probe,
+	.remove		= scpi_cpufreq_remove,
+};
+module_platform_driver(scpi_cpufreq_platdrv);
+
+MODULE_LICENSE("GPL");
-- 
1.9.1
