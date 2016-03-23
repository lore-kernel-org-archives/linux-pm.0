From: Matthew McClintock <mmcclint@codeaurora.org>
Subject: [PATCH 14/17] cpufreq: ipq4019: add cpufreq driver
Date: Wed, 23 Mar 2016 17:05:09 -0500
Message-ID: <1458770712-10880-15-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org
Cc: qca-upstream.external@qca.qualcomm.com, Matthew McClintock <mmcclint@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Add cpufreq driver for ipq4019 SoC. This driver simply instantiates
cpufreq-dt.

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
---
 drivers/cpufreq/Kconfig.arm       |  9 +++++++++
 drivers/cpufreq/Makefile          |  1 +
 drivers/cpufreq/ipq4019-cpufreq.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 drivers/cpufreq/ipq4019-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 14b1f93..187803d 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -69,6 +69,15 @@ config ARM_IMX6Q_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_IPQ4019_CPUFREQ
+        tristate "Qualcomm IPQ4019 cpufreq support"
+	depends on ARCH_QCOM && CPUFREQ_DT
+        select PM_OPP
+        help
+	  This adds cpufreq driver support for Qualcomm IPQ4019 series SoCs.
+
+          If in doubt, say N.
+
 config ARM_INTEGRATOR
 	tristate "CPUfreq driver for ARM Integrator CPUs"
 	depends on ARCH_INTEGRATOR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9e63fb1..8ed4cdb 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)	+= hisi-acpu-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
+obj-$(CONFIG_ARM_IPQ4019_CPUFREQ)	+= ipq4019-cpufreq.o
 obj-$(CONFIG_ARM_INTEGRATOR)		+= integrator-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MT8173_CPUFREQ)	+= mt8173-cpufreq.o
diff --git a/drivers/cpufreq/ipq4019-cpufreq.c b/drivers/cpufreq/ipq4019-cpufreq.c
new file mode 100644
index 0000000..6f7bba3
--- /dev/null
+++ b/drivers/cpufreq/ipq4019-cpufreq.c
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+static int __init ipq4019_cpufreq_driver_init(void)
+{
+	struct platform_device *pdev;
+
+	if (!of_machine_is_compatible("qcom,ipq4019"))
+		return -ENODEV;
+
+	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	return PTR_ERR_OR_ZERO(pdev);
+}
+module_init(ipq4019_cpufreq_driver_init);
+
+MODULE_AUTHOR("Matthew McClintock <mmcclint@codeaurora.org>");
+MODULE_DESCRIPTION("ipq4019 cpufreq driver");
+MODULE_LICENSE("GPL");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
