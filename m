From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/8] cpufreq: add driver for Armada XP
Date: Fri,  4 Jul 2014 11:44:57 +0200
Message-ID: <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56864 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753979AbaGDJpV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jul 2014 05:45:21 -0400
In-Reply-To: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit adds a simple cpufreq driver for the Armada XP SoC, which
has one separately controllable clock for each CPU. For this reason,
the existing cpufreq-cpu0 generic driver cannot be used because it
currently assumes that there is only one clock controlling the
frequency of all CPUs.

There are on-going discussions on extending the cpufreq-cpu0 to cover
the case of having one clock for each CPU, but there are still some
unresolved issues to get this extended cpufreq-cpu0 driver merged. In
the mean time, we propose to have an Armada XP specific cpufreq
driver, and since the choice of the cpufreq driver does not affect the
DT binding at all, it will always be time to get rid of this
SoC-specific driver and use a more generic one when it becomes
available.

In terms of implementation, this cpufreq driver supports two
frequencies: the nominal frequency of the CPU (which cannot be
hardcoded, since it can be changed through Sample At Reset pins) and
half of this frequency. The frequency change itself is implemented by
simply calling clk_set_rate() on the appropriate CPU clock.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/cpufreq/Kconfig.arm        |   6 ++
 drivers/cpufreq/Makefile           |   1 +
 drivers/cpufreq/armadaxp-cpufreq.c | 112 +++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 drivers/cpufreq/armadaxp-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index ebac671..825b273 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -24,6 +24,12 @@ config ARM_VEXPRESS_SPC_CPUFREQ
           This add the CPUfreq driver support for Versatile Express
 	  big.LITTLE platforms using SPC for power management.
 
+config ARM_ARMADAXP_CPUFREQ
+	bool "Marvell Armada XP"
+	depends on MACH_ARMADA_XP
+	default y
+	help
+	  This adds the CPUFreq driver for Marvell Armada XP SoC.
 
 config ARM_EXYNOS_CPUFREQ
 	bool
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 738c8b7..e260a0c 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
 # LITTLE drivers, so that it is probed last.
 obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
+obj-$(CONFIG_ARM_ARMADAXP_CPUFREQ)	+= armadaxp-cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
diff --git a/drivers/cpufreq/armadaxp-cpufreq.c b/drivers/cpufreq/armadaxp-cpufreq.c
new file mode 100644
index 0000000..e59581f
--- /dev/null
+++ b/drivers/cpufreq/armadaxp-cpufreq.c
@@ -0,0 +1,112 @@
+/*
+ * Copyright (C) 2014 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define MAX_CPU_CLKS 4
+
+struct priv {
+	struct clk *cpu_clks[MAX_CPU_CLKS];
+} priv;
+
+#define STATE_CPU_FREQ    0x01
+#define STATE_FABRIC_FREQ 0x02
+
+static struct cpufreq_frequency_table armadaxp_freq_table[] = {
+	{0, STATE_CPU_FREQ,	0},
+	{0, STATE_FABRIC_FREQ,	0},
+	{0, 0,			CPUFREQ_TABLE_END},
+};
+
+static unsigned int armadaxp_cpufreq_get_cpu_frequency(unsigned int cpu)
+{
+	return clk_get_rate(priv.cpu_clks[cpu]) / 1000;
+}
+
+static int armadaxp_cpufreq_target(struct cpufreq_policy *policy,
+			    unsigned int index)
+{
+	clk_set_rate(priv.cpu_clks[policy->cpu],
+		     armadaxp_freq_table[index].frequency * 1000);
+	return 0;
+}
+
+static int armadaxp_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	if (!cpu_online(policy->cpu))
+		return -ENODEV;
+	policy->cpuinfo.transition_latency = 5000;
+	return cpufreq_table_validate_and_show(policy, armadaxp_freq_table);
+}
+
+static struct cpufreq_driver armadaxp_cpufreq_driver = {
+	.flags	= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.get	= armadaxp_cpufreq_get_cpu_frequency,
+	.verify	= cpufreq_generic_frequency_table_verify,
+	.target_index = armadaxp_cpufreq_target,
+	.init	= armadaxp_cpufreq_cpu_init,
+	.name	= "armadaxp-cpufreq",
+	.attr	= cpufreq_generic_attr,
+};
+
+static int armadaxp_cpufreq_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	unsigned long cpu_freq;
+	int i;
+
+	for (i = 0; i < MAX_CPU_CLKS; i++) {
+		np = of_get_cpu_node(i, NULL);
+		if (!np)
+			continue;
+
+		priv.cpu_clks[i] = of_clk_get(np, 0);
+		of_node_put(np);
+	}
+
+	cpu_freq = clk_get_rate(priv.cpu_clks[0]) / 1000;
+
+	/*
+	 * The available frequencies are the nominal CPU frequency,
+	 * and half of it, which is the fabric frequency.
+	 */
+	armadaxp_freq_table[0].frequency = cpu_freq;
+	armadaxp_freq_table[1].frequency = cpu_freq / 2;
+
+	return cpufreq_register_driver(&armadaxp_cpufreq_driver);
+
+}
+
+static int armadaxp_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&armadaxp_cpufreq_driver);
+	return 0;
+}
+
+static struct platform_driver armadaxp_cpufreq_platform_driver = {
+	.probe = armadaxp_cpufreq_probe,
+	.remove = armadaxp_cpufreq_remove,
+	.driver = {
+		.name = "armadaxp-cpufreq",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(armadaxp_cpufreq_platform_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com");
+MODULE_DESCRIPTION("cpufreq driver for Marvell's Armada XP CPU");
+MODULE_ALIAS("platform:armadaxp-cpufreq");
-- 
2.0.0

