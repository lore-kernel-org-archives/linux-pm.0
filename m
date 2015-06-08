From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v4 5/8] cpufreq: arm_big_little: add SCPI interface driver
Date: Mon,  8 Jun 2015 11:39:59 +0100
Message-ID: <1433760002-24120-6-git-send-email-sudeep.holla@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48093 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbbFHKka (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Jun 2015 06:40:30 -0400
In-Reply-To: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On some ARM based systems, a separate Cortex-M based System Control
Processor(SCP) provides the overall power, clock, reset and system
control including CPU DVFS. SCPI Message Protocol is used to
communicate with the SCPI.

This patch adds a interface driver for adding OPPs and registering
the arm_big_little cpufreq driver for such systems.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/Kconfig.arm    |   9 +++
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/scpi-cpufreq.c | 124 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/cpufreq/scpi-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 611cb09239eb..6419b17b89dd 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -24,6 +24,15 @@ config ARM_VEXPRESS_SPC_CPUFREQ
           This add the CPUfreq driver support for Versatile Express
 	  big.LITTLE platforms using SPC for power management.
 
+config ARM_SCPI_CPUFREQ
+        tristate "SCPI based CPUfreq driver"
+	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL
+        help
+	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
+	  using SCPI protocol for CPU power management.
+
+	  This driver uses SCPI Message Protocol driver to interact with the
+	  firmware providing the CPU DVFS functionality.
 
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
index 000000000000..2c3b16fd3a01
--- /dev/null
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -0,0 +1,124 @@
+/*
+ * System Control and Power Interface (SCPI) based CPUFreq Interface driver
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
+static struct scpi_dvfs_info *scpi_get_dvfs_info(struct device *cpu_dev)
+{
+	u8 domain = topology_physical_package_id(cpu_dev->id);
+
+	if (domain < 0)
+		return ERR_PTR(-EINVAL);
+	return scpi_ops->dvfs_get_info(domain);
+}
+
+static int scpi_opp_table_ops(struct device *cpu_dev, bool remove)
+{
+	int idx, ret = 0;
+	struct scpi_opp *opp;
+	struct scpi_dvfs_info *info = scpi_get_dvfs_info(cpu_dev);
+
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	if (!info->opps)
+		return -EIO;
+
+	for (opp = info->opps, idx = 0; idx < info->count; idx++, opp++) {
+		if (remove)
+			dev_pm_opp_remove(cpu_dev, opp->freq);
+		else
+			ret = dev_pm_opp_add(cpu_dev, opp->freq,
+					     opp->m_volt * 1000);
+		if (ret) {
+			dev_warn(cpu_dev, "failed to add opp %uHz %umV\n",
+				 opp->freq, opp->m_volt);
+			while (idx-- > 0)
+				dev_pm_opp_remove(cpu_dev, (--opp)->freq);
+			return ret;
+		}
+	}
+	return ret;
+}
+
+static int scpi_get_transition_latency(struct device *cpu_dev)
+{
+	struct scpi_dvfs_info *info = scpi_get_dvfs_info(cpu_dev);
+
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+	return info->latency;
+}
+
+static int scpi_init_opp_table(struct device *cpu_dev)
+{
+	return scpi_opp_table_ops(cpu_dev, false);
+}
+
+static void scpi_free_opp_table(struct device *cpu_dev)
+{
+	scpi_opp_table_ops(cpu_dev, true);
+}
+
+static struct cpufreq_arm_bL_ops scpi_cpufreq_ops = {
+	.name	= "scpi",
+	.get_transition_latency = scpi_get_transition_latency,
+	.init_opp_table = scpi_init_opp_table,
+	.free_opp_table = scpi_free_opp_table,
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
+	scpi_ops = NULL;
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
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("ARM SCPI CPUFreq interface driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

